package com.xplusz.ratchet
/**
 * Base Controller.
 */
class BaseController {

    def validateSessionService

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
        def isValidated = validateSessionService.validateSession(sessionId)
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
