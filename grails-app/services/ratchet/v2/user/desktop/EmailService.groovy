package ratchet.v2.user.desktop

import com.mashape.unirest.http.Unirest
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class EmailService {
    // dependency injection for grailsApplication
    def grailsApplication

    /**
     * Confirm patient email
     *
     * @param code # temporary code
     *
     * @return result
     */
    def confirmPatientEmail(HttpServletRequest request, HttpServletResponse response, code, emailUpdate) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.patientConfirmation

        def resp = Unirest.post(emailUrl)
                .field("code", code)
                .field("email_update", emailUpdate)
                .asString()

        if (resp.status == 200) {
            log.info("Confirm patient email success, token: ${request.session.token}")
            return JSON.parse(resp.body)
        } else {
            // TODO: error handle
            return false
        }
    }

    /**
     * Confirm emergency contact email
     *
     * @param code # temporary code
     *
     * @return result
     */
    def confirmEmergencyContactEmail(HttpServletRequest request, HttpServletResponse response, code) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.emergencyContactConfirmation

        def resp = Unirest.post(emailUrl)
                .field("code", code)
                .field("hasProfile", true)
                .asString()

        if (resp.status == 200) {
            log.info("Confirm emergency contact email success, token: ${request.session.token}")
            return JSON.parse(resp.body)
        } else {
            // TODO: error handle
            return false
        }
    }
}
