package ratchet.v2.user.desktop

import com.mashape.unirest.http.Unirest
import grails.converters.JSON
import groovy.json.JsonOutput

class TaskService {

	def grailsApplication

	/**
	 * Get task short description
	 *
	 * @param code # temporary code
	 *
	 * @return success
	 */
	def getTask(code) {
		def url = grailsApplication.config.ratchetv2.server.url.task.get

		def resp = Unirest.get(url)
				.queryString("code", code)
				.queryString("summary", true)
				.asString()

		if (resp.status == 200) {
			return JSON.parse(resp.body)
		} else {
			// TODO: error handler
		}
	}

	/**
	 * Get task short description
	 *
	 * @param code # temporary code
	 * @param last4Number # last 4 number of patient phone
	 *
	 * @return questionnaire object
	 */
	def getQuestionnaire(code, last4Number) {
		def url = grailsApplication.config.ratchetv2.server.url.task.get

		def resp = Unirest.get(url)
				.queryString("code", code)
				.queryString("last4PhoneDigit", last4Number)
				.asString()

		if (resp.status == 200) {
			return JSON.parse(resp.body)
		} else {
			// TODO: error handler
		}
	}

	/**
	 * Get task short description
	 *
	 * @param code # temporary code
	 * @param choices # answer of questionnaire
	 *
	 * @return questionnaire result
	 */
	def submitQuestionnaire(code, choices) {
		def url = grailsApplication.config.ratchetv2.server.url.task.get

		def json = JsonOutput.toJson([code: code, choices: choices])

		def resp = Unirest.post(url)
				.body(json.toString())
				.asJson()

		if (resp.status == 200) {
			return JSON.parse(resp.body.toString())
		} else {
			// TODO: error handler
		}
	}
}