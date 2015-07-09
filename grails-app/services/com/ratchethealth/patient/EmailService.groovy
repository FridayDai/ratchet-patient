package com.ratchethealth.patient

import com.mashape.unirest.http.Unirest
import com.mashape.unirest.http.exceptions.UnirestException
import com.ratchethealth.patient.exceptions.ApiAccessException
import com.ratchethealth.patient.exceptions.ServerException
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class EmailService extends RatchetPatientService {
    def grailsApplication
    def userAgentIdentService

    def confirmPatientEmail(String token, code, emailUpdate) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.patientConfirmation

        withPost(emailUrl) { req ->
            def resp = req
                    .field("code", code)
                    .field("email_update", emailUpdate)
                    .asString()
            def result = JSON.parse(resp.body)

            if (resp.status == 200) {
                log.info("Confirm patient email success, token: ${token}")
                return [resp, result]

            } else if (resp.status == 412) {
                log.info("Invitation link is expired,token:${token}.")
                return [resp, result]
            }

            [resp, null]
        }
    }

    def confirmEmergencyContactEmail(String token, code) {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.emergencyContactConfirmation

        withPost(emailUrl) { req ->
            def resp = req
                    .field("code", code)
                    .field("hasProfile", true)
                    .asString()
            def result = JSON.parse(resp.body)

            if (resp.status == 200) {
                log.info("Confirm emergency contact email success, token: ${token}")
                return [resp, result]
            } else if (resp.status == 412) {
                log.info("Invitation link is expired,token:${token}.")
                return [resp, result]
            }
            [resp, null]
        }
    }

    def emailCheck(String token, int id, int last4Number) {
        String checkPhoneNumberUrl = grailsApplication.config.ratchetv2.server.url.email.checkPhoneNumber

        def url = String.format(checkPhoneNumberUrl, id)

        withPost(url) { req ->
            def resp = req
                    .field("last4PhoneDigit", last4Number)
                    .asString()

            def result = JSON.parse(resp.body)

            if (resp.status == 200) {
                log.info("Email setting check success, token: ${token}")

                return [resp, result]
            }
            [resp, null]
        }
    }

    def unsubscribe(String token, int id, int last4Number, boolean unsubscribe) {
        String unsubscribeUrl = grailsApplication.config.ratchetv2.server.url.email.unsubscribe

        def url = String.format(unsubscribeUrl, id)

        withPost(url) { req ->
            def resp = req
                    .field("last4PhoneDigit", last4Number)
                    .field("unsubscribe", unsubscribe)
                    .asString()

            if (resp.status == 200) {
                log.info("Email setting unsubscribe success, token: ${token}")
                return [resp, true]
            }
            [resp, null]
        }

    }
}
