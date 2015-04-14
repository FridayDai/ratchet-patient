package com.ratchethealth.patient

import com.mashape.unirest.http.Unirest
import com.mashape.unirest.http.exceptions.UnirestException
import com.ratchethealth.patient.exceptions.ApiAccessException
import com.ratchethealth.patient.exceptions.ApiReturnException
import grails.converters.JSON
import org.codehaus.groovy.grails.web.converters.exceptions.ConverterException

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class ClientService {

    def grailsApplication

    def getClient(HttpServletRequest request, HttpServletResponse response, String subDomain)
            throws ApiAccessException, ApiReturnException {
        String subDomainUrl = grailsApplication.config.ratchetv2.server.url.client.subDomain

        def clientUrl = String.format(subDomainUrl, subDomain)

        try {
            def resp = Unirest.get(clientUrl).asString()
            if (resp.status == 200) {
                log.info("Get client success, token: ${request.session.token}")
                return JSON.parse(resp.body)
            } else {
                log.warn("Get client failed, status: ${resp.status}\n Body: {$resp.body}")
                throw new ApiReturnException(resp.body, resp.status)
            }
        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        } catch (ConverterException e) {
            log.error "Failed to convert JSON: ${resp}\n" +
                      "Cause: ${e.getCause()}"
            throw new ApiAccessException(e.message)
        }
    }
}
