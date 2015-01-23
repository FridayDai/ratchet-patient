package com.xplusz.ratchet

import com.mashape.unirest.http.Unirest
import exceptions.AccountValidationException
import grails.converters.JSON
import net.sf.cglib.core.Local

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class AuthenticationService {

    /** dependency injection for grailsApplication */
    def grailsApplication

    def messageSource

    /**
     * Authenticate against backend. when login, authenticate will be needed. It used username and password to call
     * ratchet-v2-server restAPI login.
     *
     * @param request
     * @param response
     * @param params
     *
     * @return the authenticated status and errorMessage which restAPI returned.
     */

    def authenticate(HttpServletRequest request, HttpServletResponse response, params) throws AccountValidationException {

        def email = params.email
        def password = params.password

        if (!(email && password)) {
            def errorMessage = messageSource.getMessage("security.errors.login.missParams", null, null)
            throw new AccountValidationException(errorMessage)
        }

        def url = grailsApplication.config.ratchetv2.server.login.url
        def clientPlatform = grailsApplication.config.ratchetv2.project.client_platform
        def clientType = grailsApplication.config.ratchetv2.project.client_type
        def resp = Unirest.post(url)
                .field("email", email)
                .field("password", password)
                .field("clientPlatform", clientPlatform)
                .field("clientType", clientType)
                .asString()
        def result = JSON.parse(resp.body)

        if (resp?.status == 200) {
            request.session.token = result.token
            def data = [
                    authenticated: true,
            ]

            return data
        } else {
            def errorMessage = result.error.errorMessage
            throw new AccountValidationException(errorMessage)

        }

    }

    /**
     * Logout user, Here is two step. Step one is call ratchet-v2-server restAPI logout and check returned status .
     * Step two ,session in local needs to be invalidate.
     *
     * @param request
     * @param response
     */
    def logout(request, response) {
        def session = request.session
        def token = session?.token

        if (!token){
            log.warn("session may be killed or token in session is null")
            return false
        }

        def url = grailsApplication.config.ratchetv2.server.logout.url
        def resp = Unirest.get(url)
                .header("X-Auth-Token", "${token}")
                .asString()
        if (resp.status != 200) {
            log.warn("No user login in the session.")
            return false
        }

        log.info("Logout $token")
        session.invalidate()
        return true
    }
}
