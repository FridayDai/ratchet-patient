package com.ratchethealth.patient

import grails.converters.JSON

class EmailController extends BaseController {

    def emailService

    def confirmPatientEmail() {
        String token = request.session.token
        def code = params.code;
        def emailUpdate = params.email_update == 'true'

        def client = emailService.confirmPatientEmail(token, code, emailUpdate)

        if (client) {
            if (client.error?.errorId == 412) {
                render view: '/error/invitationExpired', model: [client: JSON.parse(session.client)]
            } else {
                render view: "/email/confirm", model: [client: JSON.parse(session.client)]
            }
        }
    }

    def confirmEmergencyContactEmail() {
        String token = request.session.token
        def code = params.code;

        def client = emailService.confirmEmergencyContactEmail(token, code)

        if (client) {
            if (client.error?.errorId == 412) {
                render view: '/error/invitationExpired', model: [client: JSON.parse(session.client)]
            } else {
                render view: "/email/confirm", model: [client: JSON.parse(session.client)]
            }
        }
    }

    def emailSetting() {
        def patientId = params.id
        render view: "/email/emailSetting", model: [client: JSON.parse(session.client), patientId: patientId]
    }

    def emailSettingCheck() {
        String token = request.session.token
        String id = params.id
        String last4Number = params.last4Number

        def result = emailService.emailCheck(token, id.toInteger(), last4Number.toInteger())

        if (result) {
            render result as JSON
        }
    }

    def subscription() {
        String token = request.session.token
        String id = params.id
        String last4Number = params.last4Number
        def unsubscribe = params.boolean("unsubscribe")

        def result = emailService.unsubscribe(token, id.toInteger(), last4Number.toInteger(), unsubscribe)

        if (result) {
            render status: 200
        }
    }
}
