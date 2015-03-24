package com.xplusz.ratchet

class AnnouncementController {

	def close() {
		session.announcementLastUpdate = params.announcementLastUpdate

		render status: 200
	}
}
