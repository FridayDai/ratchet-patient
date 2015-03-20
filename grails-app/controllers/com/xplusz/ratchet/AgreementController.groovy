package com.xplusz.ratchet

class AgreementController {

	def termOfService() {
		render view: '/agreement/termOfService', model: [client: session.client]
	}

	def privacyPolicy() {
		render view: '/agreement/privacyPolicy', model: [client: session.client]
	}

    def index() {
    	render view: '/assist', model: [client: session.client]
    }	
}
