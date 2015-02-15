package com.xplusz.ratchet

import grails.converters.JSON


class TaskController extends BaseController {
	def taskService

	def index() {
		def code = params.code

		def result = taskService.getTask(code)

		if (!(result instanceof Integer)) {
			request.session.task = result.toString()

			render view: '/task/intro', model: [Task: result]
		} else {
			return result
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
