package com.ratchethealth.patient

import grails.converters.JSON

class EmailController extends BaseController {

    def emailService
    def messageSource

    def confirmPatientEmail() {
        render view: 'confirm', model: [client: JSON.parse(session.client)]
    }

    def agreePolicyAndConfirmPatient() {
        String token = request.session.token
        def code = params.code;
        def emailUpdate = params.email_update == 'true'
        def agree = params.agree == 'true'

        def client = emailService.confirmPatientEmail(token, code, agree, emailUpdate)

        if (client) {
            if (client.error?.errorId == 412) {
                render view: '/error/invitationExpired', model: [client: JSON.parse(session.client)]
            } else if (client.error?.errorId == 404) {
                render view: '/email/emailAlreadyConfirm', model: [client: JSON.parse(session.client)]
            } else {
                render view: "/email/confirmSuccess", model: [client: JSON.parse(session.client)]
            }
        }
    }

    def confirmCareGiverEmail() {
        render view: 'confirm', model: [client: JSON.parse(session.client)]
    }

    def agreePolicyAndConfirmCareGiver() {
        String token = request.session.token
        def code = params.code;
        def agree = params.agree == 'true'

        def client = emailService.confirmEmergencyContactEmail(token, code, agree)

        if (client) {
            if (client.error?.errorId == 412) {
                render view: '/error/invitationExpired', model: [client: JSON.parse(session.client)]
            } else {
                render view: "/email/confirmSuccess", model: [client: JSON.parse(session.client)]
            }
        }
    }

    def checkPatientEmailExist() {
        String token = request.session.token
        def client = request.session.client
        def clientId = JSON.parse(client).id
        def email = params?.email
        def data = emailService.checkPatientEmail(token, clientId, email)
        render data as String
    }
}
