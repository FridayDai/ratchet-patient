package com.xplusz.ratchet

import exceptions.AccountValidationException

import javax.servlet.http.HttpServletResponse

/**
 * Authentication controller for login/logout
 *
 */
class AuthenticationController extends BaseController {

    static allowedMethods = [login: ['POST', 'GET'], logout: ['GET']]

    def beforeInterceptor = [action: this.&auth, except: ['login']]

    def authenticationService

    /**
     * Default action; redirects to home page if logged in, /login otherwise.
     */
    def index() {
        redirect(uri: '/home')
    }

    /**
     * Handle login and show login page.
     */
    def login() {
        if (request.method == "GET") {
            render view: "login"
        } else if (request.method == "POST") {
            authenticationService.authenticate(request, response, params)
            redirect(uri: '/home')
        }
    }

    /**
     * Handle logout.
     * @return
     */
    def logout() {
        if (!authenticationService.logout(request, response)) {
            log.warn("logout failed")
            response.sendError HttpServletResponse.SC_METHOD_NOT_ALLOWED // 405
            return
        }
        redirect(uri: "/login")

    }

    /**
     * handle AccountValidationException, when Exception happened, it should be back to login.
     * @param request
     * @param response
     * @param params
     * @return
     */

    def handleAccountValidationException(AccountValidationException e) {
        def msg = e.getMessage()
        render(view: 'login', model: [errorMessage: msg])

    }

}
