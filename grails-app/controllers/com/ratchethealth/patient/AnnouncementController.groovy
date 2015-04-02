package com.ratchethealth.patient

class AnnouncementController {

	def close() {
		session.announcementLastUpdated = params.announcementLastUpdated

		render status: 200
	}
}
