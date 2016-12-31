dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "root"
    password = "root"
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:devDb;MVCC=TRUE"
        }
    }
  staging {
    dataSource {      
      dbCreate = "update"
      driverClassName = "com.mysql.jdbc.Driver"
      url = System.getProperty("JDBC_CONNECTION_STRING") + "?useUnicode=true&characterEncoding=UTF8&autoReconnect=true&zeroDateTimeBehavior=convertToNull"
      username = System.getProperty("PARAM1")
      password = System.getProperty("PARAM2")
      
      properties {
        minEvictableIdleTimeMillis=1800000
        timeBetweenEvictionRunsMillis=1800000
        numTestsPerEvictionRun=3
        testOnBorrow=true
        testWhileIdle=true
        testOnReturn=true
        validationQuery="SELECT 1"
      }
    }
  }
  production {
    dataSource {      
      dbCreate = "update"
      driverClassName = "com.mysql.jdbc.Driver"
      url = System.getProperty("JDBC_CONNECTION_STRING") + "?useUnicode=true&characterEncoding=UTF8&autoReconnect=true&zeroDateTimeBehavior=convertToNull"
      username = System.getProperty("PARAM1")
      password = System.getProperty("PARAM2")
      
      properties {
        minEvictableIdleTimeMillis=1800000
        timeBetweenEvictionRunsMillis=1800000
        numTestsPerEvictionRun=3
        testOnBorrow=true
        testWhileIdle=true
        testOnReturn=true
        validationQuery="SELECT 1"
      }
    }
  }
  test {
    dataSource {
      dbCreate = "create-drop"
      url = "jdbc:h2:mem:testDb;MVCC=TRUE"
    }
  }
}