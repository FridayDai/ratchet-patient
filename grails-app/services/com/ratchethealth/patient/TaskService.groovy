package com.ratchethealth.patient

import grails.converters.JSON
import groovy.json.JsonOutput

class TaskService extends RatchetAPIService {

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
                return resp
            }
            else if (resp.status == 412) {
                log.info("Task expired, token: ${token}")
                return resp
            } else {
                handleError(resp)
            }
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
                resp
            }
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
                true
            } else if(resp.status == 412) {
                String errorMessage = JSON.parse(resp.body.toString())?.error?.errorMessage
                log.error("Record behaviour error ${errorMessage}")
            }
        }
    }

    def getQuestionnaire(String token, treatmentCode, code, last4Number) {
        def url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)

        def browserName = userAgentIdentService.getBrowser()
        def browserVersion = userAgentIdentService.getBrowserVersion()
        def OSName = userAgentIdentService.getOperatingSystem()

        withGet(url) { req ->
            def resp = req
                    .queryString("treatmentCode", treatmentCode)
                    .queryString("last4PhoneDigit", last4Number)
                    .queryString("browserName", browserName)
                    .queryString("browserVersion", browserVersion)
                    .queryString("OSName", OSName)
                    .asString()

            if (resp.status == 200 || resp.status == 207) {
                log.info("Get questionnaire success, token: ${token}")
                resp
            } else if (resp.status == 412 || resp.status == 400) {
                def result = JSON.parse(resp.body)
                log.error("Invalid task exception: ${result?.error?.errorMessage}, token: ${token}.")
                return resp
            } else {
                handleError(resp)
            }
        }
    }

    def submitQuestionnaire(String token, code, answer) {
        String url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)
        def browserName = userAgentIdentService.getBrowser()
        def browserVersion = userAgentIdentService.getBrowserVersion()
        def OSName = userAgentIdentService.getOperatingSystem()

        String json = JsonOutput.toJson([code: code, answer: answer, browserName: browserName, browserVersion: browserVersion, OSName: OSName])

        withPost(url) { req ->
            def resp = req.body(json).asJson()

            if (resp.status == 200 || resp.status == 207) {
                log.info("Submit questionnaire success, token: ${token}")
                def result = JSON.parse(resp.body.toString())
                result
            } else if (resp.status == 412) {
                def result = JSON.parse(resp.body)
                log.error("Task expire exception: ${result?.error?.errorMessage}, token: ${token}.")
                return resp
            } else {
                handleError(resp)
            }
        }
    }

    def getTaskResult(String token, code) {
        def getTestResultUrl = grailsApplication.config.ratchetv2.server.url.task.testResult

        withGet(getTestResultUrl) { req ->
            def resp = req
                    .queryString("code", code)
                    .asString()

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)
                log.info("Get task result success, token: ${token}")
                result
            } else {
                handleError(resp)
            }
        }

    }

    def submitQuestionnaireWithoutErrorHandle(String token, code, answer) {
        String url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)
        def browserName = userAgentIdentService.getBrowser()
        def browserVersion = userAgentIdentService.getBrowserVersion()
        def OSName = userAgentIdentService.getOperatingSystem()

        String json = JsonOutput.toJson([code: code, answer: answer, browserName: browserName, browserVersion: browserVersion, OSName: OSName])

        withPost(url) { req ->
            def resp = req.body(json).asJson()

            if (resp.status == 200) {
                log.info("Submit questionnaire success, token: ${token}")
                def result = JSON.parse(resp.body.toString())
                result
            } else {
                return true
            }
        }
    }
}
