package com.ratchethealth.patient

import grails.converters.JSON

class AgreementController {

	def termOfService() {
		render view: '/agreement/termOfService', model: [client: JSON.parse(session.client)]
	}

	def privacyPolicy() {
		render view: '/agreement/privacyPolicy', model: [client: JSON.parse(session.client)]
	}

    def index() {
    	render view: '/assist', model: [client: JSON.parse(session.client)]
    }	
}
