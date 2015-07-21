package com.ratchethealth.patient

import com.mashape.unirest.request.GetRequest
import com.ratchethealth.patient.exceptions.ServerException
import grails.test.mixin.TestFor
import groovy.json.JsonBuilder
import spock.lang.Specification

@TestFor(ClientService)
class ClientServiceSpec extends Specification {

    def "test getClient with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            id 1
        }

        GetRequest.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.getClient('token', 'subDomain')

        then:
        result.id == 1
    }

    def "test getClient without successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.getClient('token', 'subDomain')

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }
}
