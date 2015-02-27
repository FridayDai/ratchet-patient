package com.xplusz.ratchet

class EmailController {

	def emailService

	def confirmPatientEmail() {
		def code = params.code;

		def client = emailService.confirmPatientEmail(code)

		if (client) {
			render view: "/email/confirm", model: [client: client]
		} else {
			return 404
		}
	}

	def confirmEmergencyContactEmail() {
		def code = params.code;

		def client = emailService.confirmEmergencyContactEmail(code)

		if (client) {
			render view: "/email/confirm", model: [client: client]
		} else {
			return 404
		}
	}
}
