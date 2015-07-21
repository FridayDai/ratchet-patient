package com.ratchethealth.patient

import com.mashape.unirest.request.GetRequest
import com.ratchethealth.patient.exceptions.ServerException
import grails.test.mixin.TestFor
import groovy.json.JsonBuilder
import spock.lang.Specification

@TestFor(AnnouncementService)
class AnnouncementServiceSpec extends Specification {

    def "test checkAnnouncement with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            items 1, 2
        }

        GetRequest.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.checkAnnouncement()

        then:
        result == 1
    }

    def "test checkAnnouncement without successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.checkAnnouncement()

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }
}
