package com.ratchethealth.patient

import grails.converters.JSON

class AssistController {

    def assistService

    def index() {
    	def patientId = params?.patientId
    	render view: '/assist', model: [client: JSON.parse(session.client), patientId:patientId]
    }

    def assistCareGiver() {
        def careGiverId = params?.careGiverId
        render view: '/assist', model: [client: JSON.parse(session.client), careGiverId:careGiverId]
    }

    def addAssist() {
        def resp = assistService.addAssist(request, params)
        render resp as JSON
    }
}
