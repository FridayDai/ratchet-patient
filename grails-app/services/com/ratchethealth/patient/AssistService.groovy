package com.ratchethealth.patient

import com.mashape.unirest.http.Unirest
import com.mashape.unirest.http.exceptions.UnirestException
import com.ratchethealth.patient.exceptions.ApiAccessException
import com.ratchethealth.patient.exceptions.ApiReturnException
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest


class AssistService {
    /** dependency injection for grailsApplication */
    def grailsApplication
    def messageSource

    def addAssist(HttpServletRequest request, params)
            throws ApiAccessException, ApiReturnException {

        def title = params?.title
        def desc = params?.desc
        def browser = params?.browser
        def url = params?.url
        def type
        
        def patientId = params?.patientId
        def careGiverId = params?.careGiverId
        def clientId = JSON.parse(request.session.client).id

        if (patientId) {
            type = 'Patient'
        } else if (careGiverId) {
            type = 'Care Giver'
        }

        String addAssistUrl = grailsApplication.config.ratchetv2.server.url.addAssist
        def formattedUrl = String.format(addAssistUrl, clientId)

        try {
            def resp = Unirest.post(formattedUrl)
                    .field("title", title)
                    .field("desc", desc)
                    .field("browser", browser)
                    .field("patientId", patientId)
                    .field("careGiverId", careGiverId)
                    .field("clientId", clientId)
                    .field("url", url)
                    .field("type", type)
                    .asString()
            def result = JSON.parse(resp.body)

            if (resp.status == 201) {
                def map = [:]
                map.put("status", "ok")
                log.info("Add assist success, token: ${request.session.token}.")
                return map
            } else {
                def message = result?.error?.errorMessage
                throw new ApiReturnException(resp.status, message)
            }
        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }
    }
}
