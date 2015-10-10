package com.ratchethealth.patient

class PatientService extends RatchetAPIService {

    def grailsApplication

    def updatePatient(String token, clientId, Patient patient) {
        String updatePatientUrl = grailsApplication.config.ratchetv2.server.url.patient.update
        def url = String.format(updatePatientUrl, patient?.patientId)

        log.info("Call backend service to update single patient with clientId and patient info, token: ${token}.")
        withPost(token, url) { req ->
            def resp = req
                    .field("clientId", clientId)
                    .field("email", patient?.email)
                    .asString()

            if (resp.status == 200) {
                log.info("Update single patient success, token: ${token}")
                def status = resp.status
                return status
            }
            else {
                handleError(resp)
            }
        }
    }
}
