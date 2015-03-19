package com.xplusz.ratchet

import grails.converters.JSON

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
        def code = params.code;

        def client = emailService.confirmEmergencyContactEmail(request, response, code)

        if (client) {
            render view: "/email/confirm", model: [client: session.client]
        }
    }

    def emailSetting() {
        def patientId = params.id
        render view: "/email/emailSetting", model: [client: session.client, patientId: patientId]
    }

    def emailSettingCheck() {
        String id = params.id
        String last4Number = params.last4Number

        def result = emailService.emailCheck(request, id.toInteger(), last4Number.toInteger())

        if (result) {
            render result as JSON
        }
    }

    def subscription() {
        String id = params.id
        String last4Number = params.last4Number
        def unsubscribe = params.boolean("unsubscribe")

        def result = emailService.unsubscribe(request, id.toInteger(), last4Number.toInteger(), unsubscribe)

        if (result) {
            render status: 200
        }
    }
}
