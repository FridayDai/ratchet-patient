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

    static afterInterceptor = { model ->
        //TO-DO: add logic here to determin maintenance mode

        def announcement =[:]
        announcement.id = 1
        announcement.announcement = "The system will be down for maintenance on Wed, Jan 21 2016-15:00 PST. Sorry for the inconvenience!"
        announcement.status = "not_active"
        announcement.background = "red"
        announcement.timeCreated = "12:00"

        model.announcement = announcement
    }    

    def handleApiAccessException(ApiAccessException e) {
        log.error("API access exception: ${e.message}, token: ${session.token}.")
        render view: '/error/404', status: 404
    }

    def handleApiReturnException(ApiReturnException e) {
        log.error("API return exception: ${e.message}, token: ${session.token}.")
        render view: '/error/404', status: 404
    }

    def handleInvalidTaskException(InvalidTaskException e) {
        log.error("Invalid task exception: ${e.message}, token: ${session.token}.")
        render view: '/error/invalidTask', model: [client: session.client], status: 404
    }


}
