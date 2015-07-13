package com.ratchethealth.patient

import grails.converters.JSON


class AssistService extends RatchetAPIService {

    def grailsApplication
    def messageSource

    def addAssist(String token, client, Assist assist) {

        def title = assist?.title
        def desc = assist?.desc
        def browser = assist?.browser
        def url = assist?.url
        def type

        def patientId = assist?.patientId
        def careGiverId = assist?.careGiverId
        def clientId = JSON.parse(client).id

        if (patientId) {
            type = 'Patient'
        } else if (careGiverId) {
            type = 'Care Giver'
        }

        String addAssistUrl = grailsApplication.config.ratchetv2.server.url.addAssist
        def formattedUrl = String.format(addAssistUrl, clientId)

        withPost(formattedUrl) { req ->
            def resp = req
                    .field("title", title)
                    .field("desc", desc)
                    .field("browser", browser)
                    .field("patientId", patientId)
                    .field("careGiverId", careGiverId)
                    .field("clientId", clientId)
                    .field("url", url)
                    .field("type", type)
                    .asString()

            if (resp.status == 201) {
                def map = [:]
                map.put("status", "ok")
                log.info("Add assist success, token: ${token}.")

                map
            } else {
                handleError(resp)
            }
        }

    }

}
