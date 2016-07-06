package com.ratchethealth.patient

import com.mashape.unirest.request.GetRequest
import com.mashape.unirest.request.body.RequestBodyEntity
import grails.test.mixin.TestFor
import groovy.json.JsonBuilder
import spock.lang.Specification

@TestFor(MultiTaskService)
class MultiTaskServiceSpec extends Specification {
    def "test getTreatmentTasksWithTreatmentCode with successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : "body"
            ]
        }

        when:
        def result = service.getTreatmentTasksWithTreatmentCode('token', 'code', 1, 'subDomain')

        then:
        result.status == 200
        result.body == "body"
    }

    def "test getTreatmentTasksWithTreatmentCode without successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 404,
                    body  : "body"
            ]
        }

        when:
        def result = service.getTreatmentTasksWithTreatmentCode('token', 'code', 1, 'subDomain')

        then:
        result.status == 404
        result.body == "body"
    }

    def "test getTreatmentTasksWithCombinedTasksCode with successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : "body"
            ]
        }

        when:
        def result = service.getTreatmentTasksWithCombinedTasksCode('token', 'code', 1, 'subDomain')

        then:
        result.status == 200
        result.body == "body"
    }

    def "test getTreatmentTasksWithCombinedTasksCode without successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 404,
                    body  : "body"
            ]
        }

        when:
        def result = service.getTreatmentTasksWithCombinedTasksCode('token', 'code', 1,'subDomain')

        then:
        result.status == 404
        result.body == "body"
    }

    def "test saveDraftAnswer with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            save true
        }

        RequestBodyEntity.metaClass.asJson = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.saveDraftAnswer('token', 1, 'code', 2, 3, 'data', 1)

        then:
        result == true
    }

    def "test saveDraftAnswer without successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            emailConflict true
        }

        RequestBodyEntity.metaClass.asJson = { ->
            return [
                    status: 400,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.saveDraftAnswer('token', 1, 'code', 2, 3, 'data', 1)

        then:
        result == false
    }
}
