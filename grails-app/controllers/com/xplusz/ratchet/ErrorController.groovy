package com.xplusz.ratchet

class ErrorController {

	def notFound() {
		if (request.isXhr()) {
			render status: 404, text: e.message
		} else {
			render view: '/error/404', status: 404
		}
	}
}
