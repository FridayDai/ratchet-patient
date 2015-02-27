package ratchet.v2.user.desktop

import com.mashape.unirest.http.Unirest
import grails.converters.JSON

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
    def confirmPatientEmail(code) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.patientConfirmation

        def resp = Unirest.post(emailUrl)
                .field("code", code)
                .asString()

        if (resp.status == 200) {
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
    def confirmEmergencyContactEmail(code) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.emergencyContactConfirmation

        def resp = Unirest.post(emailUrl)
                .field("code", code)
                .field("hasProfile", true)
                .asString()

        if (resp.status == 200) {
            return JSON.parse(resp.body)
        } else {
            // TODO: error handle
            return false
        }
    }
}
