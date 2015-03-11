package ratchet.v2.user.desktop

import com.mashape.unirest.http.Unirest
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class ClientService {

    def grailsApplication

    def getClient(HttpServletRequest request, HttpServletResponse response, String subDomain) {
        String subDomainUrl = grailsApplication.config.ratchetv2.server.url.client.subDomain

        def clientUrl = String.format(subDomainUrl, subDomain)

        def resp = Unirest.get(clientUrl).asString()

        if (resp.status == 200) {
            def result = JSON.parse(resp.body)

            log.info("Get client success, token: ${request.session.token}")
            return result
        } else {
            return resp.status
        }
    }
}
