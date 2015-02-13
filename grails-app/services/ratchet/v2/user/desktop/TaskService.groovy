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
	 * @return task summary object if success, otherwise error status code
	 */
	def getTask(code) {
		def url = grailsApplication.config.ratchetv2.server.url.task.oneTest

		url = String.format(url, code)

		def resp = Unirest.get(url)
				.queryString("summary", true)
				.asString()

		if (resp.status == 200) {
			return JSON.parse(resp.body)
		} else {
			return resp.status
		}
	}

	/**
	 * Get task short description
	 *
	 * @param code # temporary code
	 * @param last4Number # last 4 number of patient phone
	 *
	 * @return questionnaire object if success otherwise error status code
	 */
	def getQuestionnaire(code, last4Number) {
		def url = grailsApplication.config.ratchetv2.server.url.task.oneTest

		url = String.format(url, code)

		def resp = Unirest.get(url)
				.queryString("last4PhoneDigit", last4Number)
				.asString()

		if (resp.status == 200) {
			return JSON.parse(resp.body)
		} else {
			return resp.status
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
		String url = grailsApplication.config.ratchetv2.server.url.task.oneTest

		url = String.format(url, code)

		String json = JsonOutput.toJson([code: code, choices: choices])

		def resp = Unirest.post(url).body(json).asJson()

		if (resp.status == 200) {
			return JSON.parse(resp.body.toString())
		} else {
			return resp.status
		}
	}
}
