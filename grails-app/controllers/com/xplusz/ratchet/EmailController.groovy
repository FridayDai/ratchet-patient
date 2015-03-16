package com.xplusz.ratchet

class EmailController extends BaseController {

    def emailService

    def confirmPatientEmail() {
        def code = params.code;
        def emailUpdate = params.email_update == 'true'

        def client = emailService.confirmPatientEmail(request, response, code, emailUpdate)

        if (client) {
            render view: "/email/confirm", model: [client: session.client]
        }
    }

    def confirmEmergencyContactEmail() {
        def code = params.code

        def client = emailService.confirmEmergencyContactEmail(request, response, code)

        if (client) {
            render view: "/email/confirm", model: [client: session.client]
        }
    }
}
