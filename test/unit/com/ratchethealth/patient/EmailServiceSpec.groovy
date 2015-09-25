package com.ratchethealth.patient

import com.mashape.unirest.request.body.MultipartBody
import com.ratchethealth.patient.exceptions.ServerException
import grails.test.mixin.TestFor
import groovy.json.JsonBuilder
import spock.lang.Specification

@TestFor(EmailService)
class EmailServiceSpec extends Specification {

    def "test confirmPatientEmail with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            confirmation true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.confirmPatientEmail('token', 1, true)

        then:
        result.confirmation == true
    }

    def "test confirmPatientEmail with 412 result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            expired true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 412,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.confirmPatientEmail('token', 1, true)

        then:
        result.expired == true
    }

    def "test confirmPatientEmail without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 405,
                    body  : "body"
            ]
        }

        when:
        service.confirmPatientEmail('token', 1, true)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test confirmEmergencyContactEmail with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            confirmation true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.confirmEmergencyContactEmail('token', 1)

        then:
        result.confirmation == true
    }

    def "test confirmEmergencyContactEmail with 412 result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            expired true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 412,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.confirmEmergencyContactEmail('token', 1)

        then:
        result.expired == true
    }

    def "test confirmEmergencyContactEmail without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.confirmEmergencyContactEmail('token', 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test emailCheck with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            check true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.emailCheck('token', 1, 1)

        then:
        result.check == true
    }

    def "test emailCheck without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.emailCheck('token', 1, 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test subscribe with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            subscribe true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.subscribe('token', 1, 1, true)

        then:
        result == true
    }

    def "test subscribe without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.subscribe('token', 1, 1, true)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }
}

