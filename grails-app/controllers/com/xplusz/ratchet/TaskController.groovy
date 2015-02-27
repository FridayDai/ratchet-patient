package com.xplusz.ratchet

import grails.converters.JSON


class TaskController extends BaseController {
	def taskService

	def index() {
		def code = params.code

		def resp = taskService.getTask(code)

		if (resp.status == 200) {
			def result = JSON.parse(resp.body)
			request.session.task = result.toString()

			render view: '/task/intro', model: [Task: result]
		} else if (resp.status == 207) {
			def result = JSON.parse(resp.body)
			flash.task = result.toString()

			redirect uri: request.forwardURI.replaceFirst(/\/start$/, '') + '/complete'
		} else {
			return resp.status
		}
	}

	def start() {
		def code = params.code
		def last4Number = params.last4Number

		def result = taskService.getQuestionnaire(code, last4Number)

		if (!(result instanceof Integer)) {
			def taskView

			//1.DASH 2.ODI 3.NDI 4.NRS-BACK 5.NRS-NECK
			if (result.type == 1) {
				taskView = '/task/content/dash'
			} else if (result.type == 2 || result.type == 3) {
				taskView = '/task/content/odi'
			} else if (result.type == 4 || result.type == 5) {
				taskView = '/task/content/nrs'
			}

			render view: taskView, model: [Task: result, code: code]
		} else if (result == 404 || !request.session.task) {
			return 404
		} else {
			def task = JSON.parse(request.session.task)

			render view: '/task/intro',
					model: [Task: task, errorMsg: RatchetMessage.TASK_INTRO_WRONG_PHONE_NUMBER]
		}
	}

	def hasComplete () {
		if (flash.task) {
			def task = JSON.parse(flash.task)

			render view: '/task/result', model: [Task: task]
		} else {
			def code = params.code

			def resp = taskService.getTask(code)

			if (resp.status == 200) {
				redirect uri: request.forwardURI.replaceFirst(/\/complete$/, '')
			} else if (resp.status == 207) {
				def result = JSON.parse(resp.body)

				render view: '/task/result', model: [Task: result]
			} else {
				return 404
			}
		}
	}

	def done() {
		def code = params.code

		if (!code) {
			render 'code is required'
		}

		def choices = params.choices

		def result = taskService.submitQuestionnaire(code, choices)

		if (!(result instanceof Integer)) {
			render view: '/task/result', model: [Task: result]
		} else {
			return 404
		}
	}
}
