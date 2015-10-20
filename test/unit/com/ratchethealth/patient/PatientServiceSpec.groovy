package com.ratchethealth.patient

import com.mashape.unirest.request.body.MultipartBody
import com.ratchethealth.patient.exceptions.ServerException
import grails.converters.JSON
import grails.test.mixin.TestFor
import groovy.json.JsonBuilder
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(PatientService)
class PatientServiceSpec extends Specification {

    def "test update patientEmail with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            save true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.updatePatient('token', 1, 'email')

        then:
        result.status == 200
    }

    def "test update patientEmail with 400 result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            emailConflict true
        }

        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.updatePatient('token', 1, 'email')
        def resultJson = JSON.parse(result.body)

        then:
        resultJson.emailConflict == true
    }

    def "test update patientEmail without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 404,
                    body  : "body"
            ]
        }

        when:
        service.updatePatient('token', 1, 'email')

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }
}
