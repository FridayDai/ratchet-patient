package com.xplusz.ratchet

import com.mashape.unirest.http.exceptions.UnirestException
import com.xplusz.ratchet.exceptions.ApiAccessException
import com.xplusz.ratchet.exceptions.ApiReturnException
import org.codehaus.groovy.grails.web.converters.exceptions.ConverterException

class ClientFilters {

    def clientService

    def filters = {
        all(controller: 'email|task|agreement') {
            before = {
                log.info("${request.requestURI} params: ${params}, session: ${session.token}, ip: ${request.getRemoteAddr()}")
                if (!session.client) {
                    def hostname = request.getServerName()

                    def clientName = hostname.replaceAll(/\.(qa|stable)?\.ratchethealth\.com$/, '')

                    try {
                        def result = clientService.getClient(request, response, clientName)
                        if (!(result instanceof Integer)) {
                            session.client = result
                        }
                    } catch (ConverterException | MissingPropertyException e) {
                        log.error("Client Not Found, token: ${session.token}")

                        if (request.isXhr()) {
                            render status: 404, text: e.message
                        } else {
                            render view: '/error/404', status: 404
                        }
                        return false
                    }
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
