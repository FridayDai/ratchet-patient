package com.ratchethealth.patient

import com.mashape.unirest.http.Unirest
import com.mashape.unirest.http.exceptions.UnirestException
import com.ratchethealth.patient.exceptions.ApiAccessException
import com.ratchethealth.patient.exceptions.ApiReturnException
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class EmailService {
    // dependency injection for grailsApplication
    def grailsApplication
    def userAgentIdentService

    /**
     * Confirm patient email
     *
     * @param code # temporary code
     *
     * @return result
     */
    def confirmPatientEmail(HttpServletRequest request, HttpServletResponse response, code, emailUpdate)
            throws ApiAccessException, ApiReturnException {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.patientConfirmation

        try {
            def resp = Unirest.post(emailUrl)
                    .field("code", code)
                    .field("email_update", emailUpdate)
                    .asString()
            def result = JSON.parse(resp.body)
            if (resp.status == 200) {
                log.info("Confirm patient email success, token: ${request.session.token}")
                return result
            } else {
                def message = result?.error?.errorMessage
                throw new ApiReturnException(message, resp.status)
            }
        }
        catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }

    }

    /**
     * Confirm emergency contact email
     *
     * @param code # temporary code
     *
     * @return result
     */
    def confirmEmergencyContactEmail(HttpServletRequest request, HttpServletResponse response, code)
            throws ApiAccessException, ApiReturnException {
        String emailUrl = grailsApplication.config.ratchetv2.server.url.email.emergencyContactConfirmation

        try {
            def resp = Unirest.post(emailUrl)
                    .field("code", code)
                    .field("hasProfile", true)
                    .asString()
            def result = JSON.parse(resp.body)

            if (resp.status == 200) {
                log.info("Confirm emergency contact email success, token: ${request.session.token}")
                return result
            } else {
                def message = result?.error?.errorMessage
                throw new ApiReturnException(message, resp.status)
            }
        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }
    }

    def emailCheck(HttpServletRequest request, int id, int last4Number)
            throws ApiReturnException, ApiReturnException {
        String checkPhoneNumberUrl = grailsApplication.config.ratchetv2.server.url.email.checkPhoneNumber

        def url = String.format(checkPhoneNumberUrl, id)

        try {
            def resp = Unirest.post(url)
                    .field("last4PhoneDigit", last4Number)
                    .asString()

            def result = JSON.parse(resp.body)

            if (resp.status == 200) {
                log.info("Email setting check success, token: ${request.session.token}")

                return result
            } else {

                def message = result?.error?.errorMessage

                throw new ApiReturnException(message, resp.status)
            }
        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }
    }

    def unsubscribe(HttpServletRequest request, int id, int last4Number, boolean unsubscribe)
            throws ApiReturnException, ApiReturnException {
        String unsubscribeUrl = grailsApplication.config.ratchetv2.server.url.email.unsubscribe

        def url = String.format(unsubscribeUrl, id)

        try {
            def resp = Unirest.post(url)
                    .field("last4PhoneDigit", last4Number)
                    .field("unsubscribe", unsubscribe)
                    .asString()

            if (resp.status == 200) {
                log.info("Email setting unsubscribe success, token: ${request.session.token}")
                return true
            } else {
                def result = JSON.parse(resp.body)
                def message = result?.error?.errorMessage

                throw new ApiReturnException(message, resp.status)
            }
        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }
    }
}
