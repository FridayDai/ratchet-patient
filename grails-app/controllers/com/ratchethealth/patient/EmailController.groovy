package com.ratchethealth.patient

import grails.converters.JSON

class EmailController extends BaseController {

    def emailService
    def patientService
    def messageSource

    def confirmPatientEmail() {
        String token = request.session.token
        def code = params.code;
        try{
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
        }catch (e){
            handleException(e)
        }

    }

    def agreePolicyAndConfirmPatient() {
        try{
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
        }catch (e){
            handleException(e)
        }


    }

    def confirmCareGiverEmail() {
        try{
            String token = request.session.token
            def code = params.code;

            def client = emailService.checkCareGiverEmailStatus(token, code)

            if (client.error?.errorId == 404) {
                render view: '/email/emailAlreadyConfirm', model: [client: JSON.parse(session.client)]
            } else {
                render view: 'confirm', model: [client: JSON.parse(session.client)]
            }
        }catch (e){
            handleException(e)
        }
    }

    def agreePolicyAndConfirmCareGiver() {
        try{
            String token = request.session.token
            def code = params.code;
            def agree = params.agree == 'true'

            def client = emailService.confirmCaregiverEmail(token, code, agree)

            if (client) {
                if (client.error?.errorId == 412) {
                    render view: '/error/invitationExpired', model: [client: JSON.parse(session.client)]
                } else {
                    render view: "/email/confirmSuccess", model: [client: JSON.parse(session.client)]
                }
            }
        }catch (e){
            handleException(e)
        }
    }

    def checkPatientEmailExist() {
        try{
            String token = request.session.token
            def client = request.session.client
            def clientId = JSON.parse(client).id
            def email = params?.email
            def data = emailService.checkPatientEmail(token, clientId, email)
            render data as String
        }catch (e){
            handleException(e)
        }
    }

    def unsubscribeEmail() {
        try{
            String token = request.session.token
            def patientId = params.patientId
            def code = params.code
            emailService.unsubscribeEmail(token, code, patientId)
            render view: 'unsubscribe', model: [client: JSON.parse(session.client)]
        }catch (e){
            handleException(e)
        }
    }
}
