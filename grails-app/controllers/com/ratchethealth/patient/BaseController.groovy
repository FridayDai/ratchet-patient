package com.ratchethealth.patient

import com.ratchethealth.patient.exceptions.ApiAccessException
import com.ratchethealth.patient.exceptions.ServerException
import com.ratchethealth.patient.exceptions.InvalidTaskException
import grails.converters.JSON

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

        if (request.isXhr()) {
            render status: 503, text: e.message
        } else {
            render view: '/error/503', status: 503
        }
    }

    def handleApiReturnException(ServerException e) {
        log.error("API return exception: ${e.message}, token: ${session.token}.")

        if (request.isXhr()) {
            render status: 404, text: e.message
        } else {
            render view: '/error/404', status: 404
        }
    }

    def handleInvalidTaskException(InvalidTaskException e) {
        log.error("Invalid task exception: ${e.message}, token: ${session.token}.")

        if (request.isXhr()) {
            render status: 404, text: e.message
        } else {
            render view: '/error/invalidTask', model: [client: JSON.parse(session.client)], status: 404
        }
    }

    def exceptionEmailService

    def handleException(Exception e) {
        log.error("Uncaught_Exception: ${e.message},stack trace: ${e.getStackTrace()}, token: ${session.token}.")

        def sw = new StringWriter()
        def pw = new PrintWriter(sw)
        e.printStackTrace(pw)
        def stackTrace = sw.toString()

        def sendEmail = exceptionEmailService.sendExceptionEmail(stackTrace)

        if(request.isXhr()) {
            render status: 400, text: e.message
        }
        else{
            render view: '/error/404', status: 404
        }
    }
}
