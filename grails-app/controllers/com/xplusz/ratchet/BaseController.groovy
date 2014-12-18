package com.xplusz.ratchet

import grails.converters.JSON

import javax.servlet.http.HttpServletResponse

/**
 * Base Controller.
 */
class BaseController {

    def baseService

    /**
     *  Verify Permissions. Quick check to see if the current user is logged in. If not, it will redirect to login.
     *
     * @return
     */
    protected auth() {
        if (!session.uid) {
            redirect(uri: "/login")
            return false
        }

        def sessionId = session.uid
        def isValidated = baseService.validateSession(sessionId)
        if (isValidated) {
            return true
        } else {
            redirect(uri: "/login")
            return false
        }

    }

    /**
     * Handle runtimeException and log the error.
     * @param exception
     * @return
     */

    def handleException(RuntimeException exception) {
        log.error(exception)
    }

}
