package com.ratchethealth.patient

import com.mashape.unirest.http.Unirest
import com.mashape.unirest.http.exceptions.UnirestException
import com.ratchethealth.patient.exceptions.ApiAccessException
import com.ratchethealth.patient.exceptions.InvalidTaskException
import grails.converters.JSON
import groovy.json.JsonOutput

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class TaskService {

    def grailsApplication
    def userAgentIdentService
    /**
     * Get task short description
     *
     * @param code # temporary code
     *
     * @return response
     */
    def getTask(HttpServletRequest request, HttpServletResponse response, code)
            throws ApiAccessException, InvalidTaskException {
        def url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)
        try {
            def resp = Unirest.get(url)
                    .queryString("summary", true)
                    .asString()

            if (resp.status == 200 || resp.status == 207) {
                log.info("Get task success, token: ${request.session.token}")
                return resp
            } else {
                def result = JSON.parse(resp.body)
                def message = result?.error?.errorMessage
                throw new InvalidTaskException(message)
            }

        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }

    }

    /**
     * Get task short description
     *
     * @param code # temporary code
     * @param last4Number # last 4 number of patient phone
     *
     * @return questionnaire object if success otherwise error status code
     */
    def getQuestionnaire(HttpServletRequest request, HttpServletResponse response, code, last4Number)
            throws ApiAccessException {
        def url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)

        try {
            def resp = Unirest.get(url)
                    .queryString("last4PhoneDigit", last4Number)
                    .asString()

            if (resp.status == 200) {
                log.info("Get questionnaire success, token: ${request.session.token}")
                return resp
            } else {
                def result = JSON.parse(resp.body)
                log.error("Invalid task exception: ${result?.error?.errorMessage}, token: ${request.session.token}.")
                return resp
            }
        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }

    }

    /**
     * Get task short description
     *
     * @param code # temporary code
     * @param choices # answer of questionnaire
     *
     * @return questionnaire result
     */
    def submitQuestionnaire(HttpServletRequest request, HttpServletResponse response, code, choices)
            throws ApiAccessException, InvalidTaskException {
        String url = grailsApplication.config.ratchetv2.server.url.task.oneTest

        url = String.format(url, code)
        def browserName = userAgentIdentService.getBrowser()
        def browserVersion = userAgentIdentService.getBrowserVersion()
        def OSName = userAgentIdentService.getOperatingSystem()

        String json = JsonOutput.toJson([code: code, choices: choices, browserName: browserName, browserVersion: browserVersion, OSName: OSName])

        try {
            def resp = Unirest.post(url).body(json).asJson()
//                    .field("browserName", browserName)
//                    .field("browserVersion", browserVersion)
//                    .field("OSName", OSName)
//                    .asString()


            if (resp.status == 200) {
                log.info("Submit questionnaire success, token: ${request.session.token}")
                return JSON.parse(resp.body.toString())
            } else {
                def result = JSON.parse(resp.body)
                def message = result?.error?.errorMessage
                throw new InvalidTaskException(message)
            }
        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }

    }
}
