package ratchet.v2.user.desktop

import com.mashape.unirest.http.Unirest

class EmailService {
    // dependency injection for grailsApplication
    def grailsApplication

    /**
     * Confirm email
     *
     * @param code # temporary code
     *
     * @return success
     */
    def confirmEmail(code) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.confirmation

        def resp = Unirest.post(emailUrl)
                .field("code", code)
                .asString()

        if (resp.status == 200) {
            return true
        } else {
            // TODO: error handle
            return false
        }
    }
}
