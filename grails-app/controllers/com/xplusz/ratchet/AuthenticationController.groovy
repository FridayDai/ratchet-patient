package com.xplusz.ratchet

import grails.converters.JSON

/**
 * Authentication controller for login/logout
 *
 */
class AuthenticationController extends AbstractController {

    static allowedMethods = [login: ['POST'], logout: ['GET']]

    def beforeInterceptor = [action: this.&auth, except: ['login']]

    def authenticationService

    /**
     * Default action; redirects to home page if logged in, /login otherwise.
     */
    def index() {
        redirect(uri: '/home')
    }

    /**
     * Handle login.
     */
    def login() {
        def resp = authenticationService.authenticate(request, response, params)
        if (resp) {
            if (resp.authenticated) {
                redirect(uri: '/home')
            } else {
                def errorMessage = resp.errorMessage
                render(view: 'login', model: [errorMessage: errorMessage])
            }
        } else {
            render(view: 'login')
        }

    }

    /**
     * Handle logout.
     * @return
     */
    def logout() {

        if (!authenticationService.logout(request, response)) {
            log.warn("logout failed")
        }
        redirect(uri: "/login")
    }

}
