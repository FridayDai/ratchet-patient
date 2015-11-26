package com.ratchethealth.patient

import groovy.json.JsonOutput

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

    def saveDraftAnswer(String token, taskId, code, questionId, answerId, data) {
        def url = grailsApplication.config.ratchetv2.server.url.task.saveDraftAnswer

        def json = [
                taskId: taskId as long,
                code: code
        ]

        if (questionId != null && answerId != null) {
            json += [
                    question: questionId as long,
                    answer: answerId as long
            ]
        }

        if (data != null) {
            json += [
                    yourData: data
            ]
        }

        String jsonStr = JsonOutput.toJson(json)

        withPost(url) { req ->
            def resp = req.body(jsonStr).asJson()

            if (resp.status == 200) {
                log.info("Save draft answer success, token: ${token}")

                true
            } else {
                false
            }
        }
    }
}
