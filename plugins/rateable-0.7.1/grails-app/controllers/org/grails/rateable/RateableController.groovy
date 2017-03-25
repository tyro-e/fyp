package org.grails.rateable

import grails.util.*

class RateableController {
    
    def rate = {
        def rater = evaluateRater()

        // for an existing rating, update it
        def rating = RatingLink.createCriteria().get {
            createAlias("rating", "r")
            projections {
                property "rating"
            }
            eq "ratingRef", params.id.toLong()
            eq "type", params.type
            eq "r.raterId", rater.id.toLong()
            cache true
        }
        if (rating) {
            rating.stars = params.rating.toDouble()
            assert rating.save()
        }
        // create a new one otherwise
        else {
            // create Rating
            rating = new Rating(stars: params.rating, raterId: rater.id, raterClass: rater.class.name)
            assert rating.save()
            def link = new RatingLink(rating: rating, ratingRef: params.id, type: params.type)
            assert link.save()
        }

        def allRatings = RatingLink.withCriteria {
            projections {
                property 'rating'
            }
            eq "ratingRef", params.id.toLong()
            eq "type", params.type
            cache true
        }
        def avg = allRatings.size() ? allRatings*.stars.sum() / allRatings.size() : 0

        render "${avg},${allRatings.size()}"
    }

    def evaluateRater() {
		def evaluator = grailsApplication.config.grails.rateable.rater.evaluator
		def rater 
		if(evaluator instanceof Closure) {
			evaluator.delegate = this
			evaluator.resolveStrategy = Closure.DELEGATE_ONLY
			rater = evaluator.call()
		}
		
		if(!rater) {
			throw new RatingException("No [grails.rateable.rater.evaluator] setting defined or the evaluator doesn't evaluate to an entity. Please define the evaluator correctly in grails-app/conf/Config.groovy or ensure rating is secured via your security rules")
		}
		if(!rater.id) {
			throw new RatingException("The evaluated Rating rater is not a persistent instance.")
		}
		return rater
	}
}