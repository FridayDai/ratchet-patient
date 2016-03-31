package com.ratchethealth.patient

import grails.converters.JSON

class EmailService extends RatchetAPIService {
    def grailsApplication

    def confirmPatientEmail(String token, code, agree, emailUpdate) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.patientConfirmation

        withPost(emailUrl) { req ->
            def resp = req
                    .field("code", code)
                    .field("agreedPolicy", agree)
                    .field("email_update", emailUpdate)
                    .asString()

            if (resp.status == 200) {
                log.info("Confirm patient email success, token: ${token}")

                JSON.parse(resp.body)
            } else if (resp.status == 404 || resp.status == 412) {
                log.info("Invitation link is expired or already confirmed,token:${token}.")

                JSON.parse(resp.body)
            } else {
                handleError(resp)
            }
        }
    }

    def confirmEmergencyContactEmail(String token, code, agree) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.emergencyContactConfirmation

        withPost(emailUrl) { req ->
            def resp = req
                    .field("code", code)
                    .field("agreedPolicy", agree)
                    .field("hasProfile", true)
                    .asString()

            if (resp.status == 200) {
                log.info("Confirm emergency contact email success, token: ${token}")

                JSON.parse(resp.body)
            } else if (resp.status == 412) {
                log.info("Invitation link is expired,token:${token}.")

                JSON.parse(resp.body)
            } else {
                handleError(resp)
            }
        }
    }

    def emailCheck(String token, long id, int last4Number) {
        String checkPhoneNumberUrl = grailsApplication.config.ratchetv2.server.url.email.checkPhoneNumber

        def url = String.format(checkPhoneNumberUrl, id)

        withPost(url) { req ->
            def resp = req
                    .field("last4PhoneDigit", last4Number)
                    .asString()

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)
                log.info("Email setting check success, token: ${token}")

                result
            } else {
                handleError(resp)
            }
        }
    }

    def subscribe(String token, long id, int last4Number, boolean subscribe) {
        String subscribeUrl = grailsApplication.config.ratchetv2.server.url.email.subscribe

        def url = String.format(subscribeUrl, id)

        withPost(url) { req ->
            def resp = req
                    .field("last4PhoneDigit", last4Number)
                    .field("subscribe", subscribe)
                    .asString()

            if (resp.status == 200) {
                log.info("Email setting unsubscribe success, token: ${token}")
                true
            } else {
                handleError(resp)
            }
        }
    }

    def checkPatientEmail(String token, clientId, email) {
        def url = grailsApplication.config.ratchetv2.server.url.email.checkPatientEmail

        log.info("Call backend service to check patient email, token: ${token}.")
        withPost(url) { req ->
            def resp = req
                .field("clientId", clientId)
                .field("email", email)
                .asString()

            if (resp.status == 200) {
                log.info("this patient email already exist, token: ${token}")
                return false
            } else if (resp.status == 404) {
                log.info("this patient email doesn't exist, token: ${token}")
                return true
            } else {
                handleError(resp)
            }
        }
    }
}
