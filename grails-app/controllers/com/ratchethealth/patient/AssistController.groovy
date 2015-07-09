package com.ratchethealth.patient

import grails.converters.JSON

class AssistController {

    def assistService

    def index() {
        def patientId = params?.patientId
        render view: '/assist', model: [client: JSON.parse(session.client), patientId: patientId]
    }

    def assistCareGiver() {
        def careGiverId = params?.careGiverId
        render view: '/assist', model: [client: JSON.parse(session.client), careGiverId: careGiverId]
    }

    def addAssist(Assist assist) {
        String token = request.session.token
        def client = request.session.client
        def resp = assistService.addAssist(token, client, assist)
        render resp as JSON
    }
}
