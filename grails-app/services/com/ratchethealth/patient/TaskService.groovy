package com.ratchethealth.patient

import com.mashape.unirest.http.Unirest
import com.mashape.unirest.http.exceptions.UnirestException
import com.ratchethealth.patient.exceptions.ApiAccessException
import com.ratchethealth.patient.exceptions.InvalidTaskException
import grails.converters.JSON
import groovy.json.JsonOutput

import javax.servlet.http.HttpServletRequest

class TaskService extends RatchetPatientService {

    def grailsApplication
    def userAgentIdentService

    def getTask(String token, code) {
        def url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)

        withGet(url) { req ->
            def resp = req
                    .queryString("summary", true)
                    .asString()

            if (resp.status == 200 || resp.status == 207) {
                log.info("Get task success, token: ${token}")
                return [resp, resp]
            }

            [resp, null]
        }
    }

    def recordBehaviour(String token, code) {
        def url = grailsApplication.config.ratchetv2.server.url.task.recordBehaviour

        url = String.format(url, code)

        def browserName = userAgentIdentService.getBrowser()
        def browserVersion = userAgentIdentService.getBrowserVersion()
        def OSName = userAgentIdentService.getOperatingSystem()

        withPost(url) { req ->
            def resp = req
                    .field("browserName", browserName)
                    .field("browserVersion", browserVersion)
                    .field("OSName", OSName)
                    .asString()

            if (resp.status == 200) {
                log.info("Record behaviour success, token: ${token}")
                return [resp, true]
            }

            [resp, null]
        }
    }

    def getQuestionnaire(String token, code, last4Number) {
        def url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)

        def browserName = userAgentIdentService.getBrowser()
        def browserVersion = userAgentIdentService.getBrowserVersion()
        def OSName = userAgentIdentService.getOperatingSystem()

        withGet(url) { req ->
            def resp = req
                    .queryString("last4PhoneDigit", last4Number)
                    .queryString("browserName", browserName)
                    .queryString("browserVersion", browserVersion)
                    .queryString("OSName", OSName)
                    .asString()

            if (resp.status == 200) {
                log.info("Get questionnaire success, token: ${token}")
                return [resp, resp]
            }

            [resp, null]
        }
    }

    def submitQuestionnaire(String token, code, choices) {
        String url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)
        def browserName = userAgentIdentService.getBrowser()
        def browserVersion = userAgentIdentService.getBrowserVersion()
        def OSName = userAgentIdentService.getOperatingSystem()

        String json = JsonOutput.toJson([code: code, choices: choices, browserName: browserName, browserVersion: browserVersion, OSName: OSName])

        withPost(url) { req ->
            def resp = req.body(json).asJson()

            if (resp.status == 200) {
                log.info("Submit questionnaire success, token: ${token}")
                def result = JSON.parse(resp.body.toString())
                return [resp, result]
            }

            [resp, null]
        }
    }

    def recordTaskStart(String token, code) {
        def url = grailsApplication.config.ratchetv2.server.url.task.recordTaskStart

        url = String.format(url, code)

        withPost(url) { req ->
            def resp = req
                    .asString()

            if (resp.status == 200) {
                log.info("Record task start success, token: ${token}")
                return [resp, resp]
            }

            [resp, null]
        }
    }

    def getTaskResult(String token, code) {
        def getTestResultUrl = grailsApplication.config.ratchetv2.server.url.task.testResult

        withGet(getTestResultUrl) { req ->
            def resp = req
                    .queryString("code", code)
                    .asString()

            def result = JSON.parse(resp.body)
            if (resp.status == 200) {
                log.info("Get task result success, token: ${token}")
                return [resp, result]
            }
            [resp, null]
        }

    }
}
