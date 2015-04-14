package com.ratchethealth.patient

import grails.converters.JSON

class AssistController {

    def assistService

    def index() {
    	def patientId = params?.patientId
    	render view: '/assist', model: [client: session.client, patientId:patientId]
    }

    def addAssist() {
        def resp = assistService.addAssist(request, response, params, session)
        render resp as JSON
    }
}
