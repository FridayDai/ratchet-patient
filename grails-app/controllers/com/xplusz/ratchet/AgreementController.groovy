package com.xplusz.ratchet

class AgreementController {

	def termOfService() {
		render view: '/termOfService', model: [client: session.client]
	}

	def privacyPolicy() {
		render view: '/privacyPolicy', model: [client: session.client]
	}
}