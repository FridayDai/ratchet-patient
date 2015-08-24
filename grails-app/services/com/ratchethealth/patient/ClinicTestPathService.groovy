package com.ratchethealth.patient

import grails.converters.JSON


class ClinicTestPathService extends RatchetAPIService {

    def grailsApplication

    def getTreatmentTasks(String token, treatmentCode) {
        def url = grailsApplication.config.ratchetv2.server.url.task.getClinicTests

        url = String.format(url, treatmentCode)

        withGet(url) { req ->
            def resp = req
                    .asString()

            if (resp.status == 200) {
                log.info("Get clinic task success, token: ${token}")
                return  resp
            }else{
                return resp
            }
        }
    }
}
