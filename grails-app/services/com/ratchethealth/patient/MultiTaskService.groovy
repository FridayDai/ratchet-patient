package com.ratchethealth.patient

class MultiTaskService extends RatchetAPIService {

    def grailsApplication

    def getTreatmentTasksWithTreatmentCode(String token, treatmentCode, completedTasksOnly) {
        def url = grailsApplication.config.ratchetv2.server.url.task.getTreatmentTests

        withGet(url) { req ->
            def resp = req
                    .queryString("code", treatmentCode)
                    .queryString("completedTasksOnly", completedTasksOnly)
                    .asString()

            if (resp.status == 200) {
                log.info("Get clinic task success, token: ${token}")
                return resp
            } else {
                return resp
            }
        }
    }

    def getTreatmentTasksWithCombinedTasksCode(String token, combinedTasksCode, completedTasksOnly) {
        def url = grailsApplication.config.ratchetv2.server.url.task.getTreatmentTests

        withGet(url) { req ->
            def resp = req
                    .queryString("combinedTasksCode", combinedTasksCode)
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
