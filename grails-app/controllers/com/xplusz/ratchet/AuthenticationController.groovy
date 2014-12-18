package com.xplusz.ratchet
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
     * Handle login.
     */
    def login() {

        if (request.method == "GET") {
            render view: "login"
        } else if (request.method == "POST") {
            authenticate(request, response, params)
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


    private def authenticate(request, response, params) {

        def resp = authenticationService.authenticate(request, response, params)

        if (resp.authenticated) {
            redirect(uri: '/home')
        } else {
            def errorMessage = resp.errorMessage
            render(view: 'login', model: [errorMessage: errorMessage])
        }

    }

}
