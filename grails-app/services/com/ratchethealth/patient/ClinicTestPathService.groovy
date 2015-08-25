package com.ratchethealth.patient

class ClinicTestPathService extends RatchetAPIService {

    def grailsApplication

    def getTreatmentTasks(String token, treatmentCode, completedTasksOnly) {
        def url = grailsApplication.config.ratchetv2.server.url.task.getClinicTests

        url = String.format(url, treatmentCode)

        withGet(url) { req ->
            def resp = req
                    .queryString("completedTasksOnly",completedTasksOnly)
                    .asString()

            if (resp.status == 200) {
                log.info("Get clinic task success, token: ${token}")
                return resp
            } else {
                return resp
            }
        }
    }
}
