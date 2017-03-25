package org.grails.s3

import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory
import org.grails.s3.S3Asset
import org.jets3t.service.model.S3Object
import org.springframework.dao.TransientDataAccessException
import org.jets3t.service.multithread.*
import org.hibernate.StaleObjectStateException
import org.springframework.orm.hibernate3.SessionHolder
import org.springframework.transaction.support.TransactionSynchronizationManager
import org.hibernate.FlushMode
import org.springframework.orm.hibernate3.SessionFactoryUtils
import org.hibernate.Session
import org.hibernate.SessionFactory

class HandleS3Events implements S3ServiceEventListener {

    List assets;
    SessionFactory sessionFactory

    Log log = LogFactory.getLog(HandleS3Events.class)
    boolean existingSession

    HandleS3Events(List assets, SessionFactory sessionFactory) {
        this.assets = assets;
        this.sessionFactory = sessionFactory
    }

    //S3ServiceEventListener event listener methods

    void s3ServiceEventPerformed(CreateObjectsEvent event) {
        try {
            createSession();
            if (ServiceEvent.EVENT_STARTED == event.getEventCode()) {
                assets.each {a ->
                    a.refresh()
                    if (a.status == S3Asset.STATUS_NEW) {

                        a.status = S3Asset.STATUS_INPROGRESS;
                        try {
                            a.save(flush: true)
                        } catch (TransientDataAccessException e) {
                            recoverInprogressUpload(a)
                        } catch (StaleObjectStateException e) {
                            recoverInprogressUpload(a)
                        }

                        log.debug("Asset ${a.id} is in progress")
                    } else {
                        log.warn("Asset ${a.id} should have been NEW but was ${a.status}")
                    }
                }
            } else if (event.getEventCode() == event.EVENT_IN_PROGRESS) {
                def created = event.getCreatedObjects()
                created.each {S3Object c ->
                    def a = assets.find {it.key == c.key}
                    if (a) {
                        a.refresh()
                        a.status = S3Asset.STATUS_HOSTED
                        boolean removeLocalOnPut = Boolean.valueOf(a.options.get("removeLocalOnPut") ?: 'true')
                        //if we are supposed to delete the local file on put
                        String localPath = a.localPath
                        if (removeLocalOnPut && localPath) {
                            File f = new File(localPath)
                            if (f.exists()) f.delete()
                            a.localPath = null
                        }
                        try {
                            a.save(flush: true)
                        } catch (TransientDataAccessException e) {
                            recoverCompletedUpload(a, removeLocalOnPut)
                        } catch (StaleObjectStateException e) {
                            recoverCompletedUpload(a, removeLocalOnPut)
                        }
                        log.debug("Uploaded asset ${a.id} at ${a.url()}. Status is ${a.status}")
                    } else {
                        log.warn('Unexpected S3 object created: ' + it.key)
                    }
                }
            } else if (event.getEventCode() == event.EVENT_ERROR) {
                log.error('S3 upload error: ' + event.getErrorCause(), event.getErrorCause())
            } else if (event.getEventCode() == event.EVENT_IGNORED_ERRORS) {
                event.getIgnoredErrors().each {
                    log.warn('S3 upload error ignored: ' + it, it)
                }
            }
        } catch (Throwable t) {
            log.error("Exception occurred handling S3 Event: ${event} ", t)
        } finally {
            cleanUpSession()
        }
    }

    private def cleanUpSession() {
        if (!existingSession) {
            SessionHolder sessionHolder = (SessionHolder) TransactionSynchronizationManager.unbindResourceIfPossible(sessionFactory);
            if (sessionHolder) {
                if (!FlushMode.MANUAL.equals(sessionHolder.getSession().getFlushMode())) {
                    sessionHolder.getSession().flush();
                }
                SessionFactoryUtils.closeSession(sessionHolder.getSession());
            }
        }
    }

    private def createSession() {
        SessionHolder sessionHolder = (SessionHolder) TransactionSynchronizationManager.unbindResourceIfPossible(sessionFactory);
        if (sessionHolder) {
            TransactionSynchronizationManager.bindResource(sessionFactory, sessionHolder)
            existingSession = true
        } else {
            existingSession = false
            Session session = SessionFactoryUtils.getSession(sessionFactory, true);
            session.setFlushMode(FlushMode.AUTO);
            TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(session))
        }
    }

    private def recoverCompletedUpload(a, boolean removeLocalOnPut) {
        log.debug('recovering from concurrent access exception')
        a.refresh()
        a.status = S3Asset.STATUS_HOSTED
        if (removeLocalOnPut) {
            a.localPath = null
        }
        a.save(flush: true)
    }

    private def recoverInprogressUpload(a) {
        log.debug('recovering from concurrent access exception')
        a.refresh()
        a.status = S3Asset.STATUS_INPROGRESS
        a.save(flush: true)
    }

    void s3ServiceEventPerformed(CreateBucketsEvent event) {
    }

    void s3ServiceEventPerformed(DeleteObjectsEvent event) {
        try {
            createSession()
            if (event.getEventCode() == event.EVENT_IN_PROGRESS) {
                def deleted = event.getDeletedObjects()
                deleted.each {S3Object c ->
                    def a = assets.find {it.key == c.key}
                    if (a) {
                        a.refresh()
                        boolean removeLocalOnDelete = Boolean.valueOf(a.options.get("removeLocalOnDelete") ?: 'true')
                        a.status = S3Asset.STATUS_REMOVED
                        String localpath = a.localPath
                        //if we are supposed to delete the local file on delete
                        if (removeLocalOnDelete && localpath) {
                            File f = new File(localpath)
                            if (f.exists()) f.delete()
                            a.localPath = null
                        }
                        try {
                            a.save(flush: true)
                        } catch (TransientDataAccessException e) {
                            recoverCompletedDelete(a, removeLocalOnDelete)
                        } catch (StaleObjectStateException e) {
                            recoverCompletedDelete(a, removeLocalOnDelete)
                        }
                        log.debug("Removed asset ${a.id} at ${a.url()}")
                    } else {
                        log.warn('Unexpected S3 object deleted: ' + it.key)
                    }
                }
            } else if (event.getEventCode() == event.EVENT_ERROR) {
                log.error('S3 delete error: ' + event.getErrorCause(), event.getErrorCause())
            } else if (event.getEventCode() == event.EVENT_IGNORED_ERRORS) {
                event.getIgnoredErrors().each {
                    log.warn('S3 delete error ignored: ' + it, it)
                }
            }
        } catch (Throwable t) {
            log.error("Exception occurred handling S3 Event: ${event} ", t)
        } finally {
            cleanUpSession()
        }
    }

    private def recoverCompletedDelete(a, boolean removeLocalOnDelete) {
        log.debug('recovering from concurrent access exception')
        a.refresh()
        a.status = S3Asset.STATUS_REMOVED
        if (removeLocalOnDelete) {
            a.localPath = null
        }
        a.save(flush: true)
    }

    void s3ServiceEventPerformed(GetObjectsEvent event) {}

    void s3ServiceEventPerformed(GetObjectHeadsEvent event) {}

    void s3ServiceEventPerformed(LookupACLEvent event) {}

    void s3ServiceEventPerformed(DownloadObjectsEvent event) {}

    void s3ServiceEventPerformed(UpdateACLEvent event) {}

    void s3ServiceEventPerformed(ListObjectsEvent event) {}

    void s3ServiceEventPerformed(CopyObjectsEvent event) {}

}