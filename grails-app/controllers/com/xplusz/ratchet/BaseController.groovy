package com.xplusz.ratchet

import com.xplusz.ratchet.exceptions.ApiAccessException
import com.xplusz.ratchet.exceptions.ApiReturnException
import com.xplusz.ratchet.exceptions.InvalidTaskException

/**
 * Base Controller.
 */
class BaseController {

    /**
     *  Verify Permissions. Quick check to see if the current user is logged in. If not, it will redirect to login.
     *
     * @return
     */
    protected auth() {
        if (!session.token) {
            redirect(uri: "/login")
            return false
        } else {
            return true
        }

    }

    def handleApiAccessException(ApiAccessException e) {
        log.error("API access exception: ${e.message}, token: ${session.token}.")
        render view: '/error/404'
    }

    def handleApiReturnException(ApiReturnException e) {
        log.error("API return exception: ${e.message}, token: ${session.token}.")
        render view: '/error/404'
    }

    def handleInvalidTaskException(InvalidTaskException e) {
        log.error("Invalid task exception: ${e.message}, token: ${session.token}.")
        render view: '/error/invalidTask', model: [client: session.client], status: 404
    }


}
