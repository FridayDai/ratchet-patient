package com.ratchethealth.patient

import com.mashape.unirest.request.body.MultipartBody
import com.ratchethealth.patient.exceptions.ServerException
import grails.converters.JSON
import grails.test.mixin.TestFor
import groovy.json.JsonBuilder
import spock.lang.Specification

@TestFor(AssistService)
class AssistServiceSpec extends Specification {
    def "test addAssist with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            id 1
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 201,
                    body  : jBuilder.toString()
            ]
        }

        Assist assist = new Assist()
        assist.title = 'title'
        assist.desc = 'desc'
        assist.browser = 'browser'
        assist.url = 'url'
        assist.patientId = 1


        when:
        def result = service.addAssist('token', 1, assist)

        then:
        result.status == "ok"
    }

    def "test addAssist without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        Assist assist = new Assist()

        when:
        service.addAssist('token', 1, assist)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }
}
