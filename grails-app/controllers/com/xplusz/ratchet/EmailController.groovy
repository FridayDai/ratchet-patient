package com.xplusz.ratchet

class EmailController {

	def emailService

	def confirmEmail() {
		def code = params.code;

		def success = emailService.confirmEmail(code)

		if (success) {
			render view: "/email/confirm"
		} else {
			render 'Patient Not Found'
		}
	}
}
