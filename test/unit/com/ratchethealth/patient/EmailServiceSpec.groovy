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
        def result = service.confirmPatientEmail('token', 1, true, true, true)

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
        def result = service.confirmPatientEmail('token', 1, true, true, true)

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
        service.confirmPatientEmail('token', 1, true, true, true)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test confirmCaregiverEmail with successful result"() {
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
        def result = service.confirmCaregiverEmail('token', 1, true, true)

        then:
        result.confirmation == true
    }

    def "test confirmCaregiverEmail with 412 result"() {
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
        def result = service.confirmCaregiverEmail('token', 1, true, true)

        then:
        result.expired == true
    }

    def "test confirmCaregiverEmail without successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            expired true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.confirmCaregiverEmail('token', 1, true, true)

        then:
        result.expired == true
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

    def "test unsubscribe caregiver's email with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            unsubscribe true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.unsubscribeCaregiverEmail('token', 1, 1, 1, 1)

        then:
        result == true
    }

    def "test unsubscribe caregiver's email without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.unsubscribeCaregiverEmail('token', 1, 1, 1, 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }




    def "test unsubscribe patient's email with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            unsubscribe true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.unsubscribeEmail('token', 1, 1)

        then:
        result == true
    }

    def "test unsubscribe patient's email without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.unsubscribeEmail('token', 1, 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }



}

