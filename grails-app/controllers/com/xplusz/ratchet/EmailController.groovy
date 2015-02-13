package com.xplusz.ratchet

class EmailController {

	def emailService

	def confirmPatientEmail() {
		def code = params.code;

		def success = emailService.confirmPatientEmail(code)

		if (success) {
			render view: "/email/confirm"
		} else {
			return 404
		}
	}

	def confirmEmergencyContactEmail() {
		def code = params.code;

		def success = emailService.confirmEmergencyContactEmail(code)

		if (success) {
			render view: "/email/confirm"
		} else {
			return 404
		}
	}
}
