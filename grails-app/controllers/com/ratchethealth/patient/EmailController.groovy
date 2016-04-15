package com.ratchethealth.patient

import grails.converters.JSON

class EmailController extends BaseController {

    def emailService
    def patientService
    def messageSource

    def confirmPatientEmail() {
        String token = request.session.token
        def code = params.code;

        def client = emailService.checkPatientEmailStatus(token, code)
        def hasBirthday = patientService.checkPatientBirthday(token, code)

        if (client.error?.errorId == 404) {
            render view: '/email/emailAlreadyConfirm', model: [client: JSON.parse(session.client)]
        } else {
            render view: 'confirm', model: [client        : JSON.parse(session.client),
                                            errorMsg      : flash?.errorMsg,
                                            patientConfirm: 'true',
                                            hasBirthday   : hasBirthday
            ]
        }
    }

    def agreePolicyAndConfirmPatient() {
        String token = request.session.token
        def code = params.code;
        def birthday = params.birthday;
        def emailUpdate = params.email_update == 'true'
        def agree = params.agree == 'true'

        def client = emailService.confirmPatientEmail(token, code, agree, birthday, emailUpdate)

        if (client) {
            if (client.error?.errorId == 400) {
                flash.errorMsg = client.error?.errorMessage
                forward(action: 'confirmPatientEmail')
            } else if (client.error?.errorId == 412) {
                render view: '/error/invitationExpired', model: [client: JSON.parse(session.client)]
            } else if (client.error?.errorId == 404) {
                render view: '/email/emailAlreadyConfirm', model: [client: JSON.parse(session.client)]
            } else {
                render view: "/email/confirmSuccess", model: [client: JSON.parse(session.client)]
            }
        }
    }

    def confirmCareGiverEmail() {
        String token = request.session.token
        def code = params.code;

        def client = emailService.checkCareGiverEmailStatus(token, code)

        if (client.error?.errorId == 404) {
            render view: '/email/emailAlreadyConfirm', model: [client: JSON.parse(session.client)]
        } else {
            render view: 'confirm', model: [client: JSON.parse(session.client)]
        }
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

    def unsubscribeEmail() {
        String token = request.session.token
        def patientId = params.patientId
        def code = params.code
        emailService.unsubscribeEmail(token, code, patientId)
        render view: 'unsubscribe', model: [client: JSON.parse(session.client)]
    }
}
