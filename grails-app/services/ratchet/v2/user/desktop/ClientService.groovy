package ratchet.v2.user.desktop

import com.mashape.unirest.http.Unirest
import grails.converters.JSON

class ClientService {

	def grailsApplication

	def getClient(String subDomain) {
		String subDomainUrl = grailsApplication.config.ratchetv2.server.url.client.subDomain

		def clientUrl = String.format(subDomainUrl, subDomain)

		def resp = Unirest.get(clientUrl).asString()

		if (resp.status == 200) {
			def result = JSON.parse(resp.body)

			return result
		} else {
			return resp.status
		}
	}
}
