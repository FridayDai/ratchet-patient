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

        def errMsg = params?.errorMsg
        if (client.error?.errorId == 404) {
            render view: '/email/emailAlreadyConfirm', model: [client: JSON.parse(session.client)]
        } else {
            render view: 'confirm', model: [client        : JSON.parse(session.client),
                                            patientConfirm: 'true',
                                            hasBirthday   : hasBirthday,
                                            errorMsg      : errMsg
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
                def errorMsg = client.error?.errorMessage
                forward(action: 'confirmPatientEmail', params:[errorMsg: errorMsg])
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
        def errMsg = params?.errorMsg

        def client = emailService.checkCareGiverEmailStatus(token, code)

        if (client.error?.errorId == 404) {
            render view: '/email/emailAlreadyConfirm', model: [client: JSON.parse(session.client)]
        } else {
            render view: 'confirm', model: [client: JSON.parse(session.client),
                                            careGiverConfirm: 'true',
                                            errorMsg      : errMsg
                                            ]
        }
    }

    def agreePolicyAndConfirmCareGiver() {
        String token = request.session.token
        def code = params.code;
        def agree = params.agree == 'true';
        def birthday = params.birthday;

        def client = emailService.confirmCaregiverEmail(token, code, agree, birthday)

        if (client) {
            if (client.error?.errorId == 400) {
                def errorMsg = client.error?.errorMessage
                forward(action: 'confirmCareGiverEmail', params: [errorMsg: errorMsg])
            } else if (client.error?.errorId == 412) {
                render view: '/error/invitationExpired', model: [client: JSON.parse(session.client)]
            } else if (client.error?.errorId == 404) {
                render view: '/email/emailAlreadyConfirm', model: [client: JSON.parse(session.client)]
            }
            else {
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

    def unsubscribeCaregiverEmail() {
        String token = request.session.token
        def patientId = params.patientId
        def caregiverId = params.careGiverId
        def clientId = params.clientId
        def code = params.code

        emailService.unsubscribeCaregiverEmail(token, code, clientId, patientId, caregiverId)
        render view: 'unsubscribe', model: [client: JSON.parse(session.client)]

    }

}
