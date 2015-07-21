package com.ratchethealth.patient

import com.mashape.unirest.request.GetRequest
import com.mashape.unirest.request.HttpRequestWithBody
import com.mashape.unirest.request.body.MultipartBody
import com.mashape.unirest.request.body.RequestBodyEntity
import com.ratchethealth.patient.exceptions.ServerException
import grails.converters.JSON
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import groovy.json.JsonBuilder
import org.geeks.browserdetection.UserAgentIdentService
import spock.lang.Specification

@TestFor(TaskService)
@Mock(UserAgentIdentService)
class TaskServiceSpec extends Specification {

    def setup() {
        UserAgentIdentService.metaClass.getBrowser = { ->
            return "1"
        }

        UserAgentIdentService.metaClass.getBrowserVersion = { ->
            return "1"
        }

        UserAgentIdentService.metaClass.getOperatingSystem = { ->
            return "1"
        }
    }

    def "test getTask with successful result"() {
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
        def result = service.getTask('token', 1)
        def resultJson = JSON.parse(result.body)

        then:
        resultJson.id == 1
    }

    def "test getTask without successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.getTask('token', 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test recordBehaviour with successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : ''
            ]
        }

        when:
        def result = service.recordBehaviour('token', 1)

        then:
        result == true
    }

    def "test recordBehaviour without successful result"() {
        given:
        MultipartBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.recordBehaviour('token', 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test getQuestionnaire with successful result"() {
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
        def result = service.getQuestionnaire('token', 1, 1)
        def resultJson = JSON.parse(result.body)

        then:
        resultJson.id == 1
    }

    def "test getQuestionnaire without 400 result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            msg 'wrong phone number'
        }

        GetRequest.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.getQuestionnaire('token', 1, 1)
        def resultJson = JSON.parse(result.body)

        then:
        resultJson.msg == 'wrong phone number'
    }

    def "test getQuestionnaire without successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 404,
                    body  : "body"
            ]
        }

        when:
        service.getQuestionnaire('token', 1, 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test submitQuestionnaire with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            id 1
        }

        RequestBodyEntity.metaClass.asJson = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.submitQuestionnaire('token', 1, 1)

        then:
        result.id == 1
    }

    def "test submitQuestionnaire without successful result"() {
        given:
        RequestBodyEntity.metaClass.asJson = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.submitQuestionnaire('token', 1, 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test recordTaskStart with successful result"() {
        given:
        def jBuilder = new JsonBuilder()
        jBuilder {
            id 1
        }

        HttpRequestWithBody.metaClass.asString = { ->
            return [
                    status: 200,
                    body  : jBuilder.toString()
            ]
        }

        when:
        def result = service.recordTaskStart('token', 1)
        def resultJson = JSON.parse(result.body)

        then:
        resultJson.id == 1
    }


    def "test recordTaskStart without successful result"() {
        given:
        HttpRequestWithBody.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.recordTaskStart('token', 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }

    def "test getTaskResult with successful result"() {
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
        def result = service.getTaskResult('token', 1)

        then:
        result.id == 1
    }

    def "test getTaskResult without successful result"() {
        given:
        GetRequest.metaClass.asString = { ->
            return [
                    status: 400,
                    body  : "body"
            ]
        }

        when:
        service.getTaskResult('token', 1)

        then:
        ServerException e = thrown()
        e.getMessage() == "body"
    }
}
