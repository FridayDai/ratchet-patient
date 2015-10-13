package com.ratchethealth.patient

class PatientService extends RatchetAPIService {

    def grailsApplication

    def updatePatient(String token, treatmentCode, email) {
        String url = grailsApplication.config.ratchetv2.server.url.patient.update

        log.info("Call backend service to update single patient with clientId and patient info, token: ${token}.")
        withPost(token, url) { req ->
            def resp = req
                    .field("code", treatmentCode)
                    .field("email", email)
                    .asString()

            if (resp.status == 200) {
                log.info("Update single patient success, token: ${token}")
                return resp
            } else if(resp.status == 400) {
                log.info("Update single patient failed, token: ${token}")
                return resp
            } else {
                handleError(resp)
            }
        }
    }
}
