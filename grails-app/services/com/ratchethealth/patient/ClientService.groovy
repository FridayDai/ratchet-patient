package com.ratchethealth.patient

import grails.converters.JSON

class ClientService extends RatchetAPIService {

    def grailsApplication

    def getClient(String token, String subDomain) {
        String subDomainUrl = grailsApplication.config.ratchetv2.server.url.client.subDomain

        def clientUrl = String.format(subDomainUrl, subDomain)


        withGet(token, clientUrl) { req ->
            def resp = req.asString()

            if (resp.status == 200) {
                log.info("Get client success, token: ${token}")
                JSON.parse(resp.body)
            } else {
                log.warn("Get client failed, status: ${resp.status}\n Body: {$resp.body}")
                handleError(resp)
            }
        }
    }
}
