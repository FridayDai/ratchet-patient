package com.xplusz.ratchet

class ClientFilters {

	def clientService

	def filters = {
		all(controller: 'email|task') {
			before = {
				if (!session.client) {
					def hostname = request.getServerName()

					def clientName = hostname.replaceAll(/\.(qa|stable)?\.ratchethealth\.com$/, '')

					def result = clientService.getClient(clientName)

					if (!(result instanceof Integer)) {
						session.client = result
					} else {
						render view: '/error/404'
						return false
					}
				}
			}
			after = { Map model ->

			}
			afterView = { Exception e ->

			}
		}
	}
}
