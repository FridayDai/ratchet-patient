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
     * Handle login and show login page.
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

    /**
     * Authenticate for login, when authentication is passed, it will turn to home page . If not, it should be back to login.
     * @param request
     * @param response
     * @param params
     * @return
     */
    def authenticate(request, response, params) {

        def username = params.username
        def password = params.password

        if (!(username && password)) {
//            throw new ValiationException(eeeegaga)
            log.info("username and password can't be null")
            def errorMessage = message(code: "security.errors.login.missParams")
            render(view: 'login', model: [errorMessage: errorMessage])
            return
        }

        def resp = authenticationService.authenticate(request, response, params)

        if (resp?.authenticated) {
            redirect(uri: '/home')
        } else {
            def errorMessage = resp?.errorMessage
            render(view: 'login', model: [errorMessage: errorMessage])
        }

    }

}
