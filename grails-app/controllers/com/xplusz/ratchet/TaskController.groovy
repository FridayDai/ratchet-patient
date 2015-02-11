package com.xplusz.ratchet

class TaskController extends BaseController {
	def taskService

	def index() {
		def code = params.code

		def result = taskService.getTask(code)

		if (result) {
			def introView

			//1.DASH 2.ODI 3.NDI 4.NRS-BACK 5.NRS-NECK
			if (result.type == 4 || result.type == 5) {
				introView = "/task/intro/nrs"
			} else {
				introView = "/task/intro/normal"
			}

			render view: introView, model: [Task: result]
		} else {
			render 'Task not found'
			// TODO: error handler
		}
	}

	def start() {
		def code = params.code
		def last4Number = params.last4Number

		def questionnaire = taskService.getQuestionnaire(code, last4Number)

		if (questionnaire) {
			def taskView

			//1.DASH 2.ODI 3.NDI 4.NRS-BACK 5.NRS-NECK
			if (questionnaire.type == 1) {
				taskView = '/task/content/dash'
			} else if (questionnaire.type == 2 || questionnaire.type == 3) {
				taskView = '/task/content/odi'
			} else if (questionnaire.type == 4 || questionnaire.type == 5) {
				taskView = '/task/content/nrs'
			}

			render view: taskView, model: [Task: questionnaire, code: code]
		} else {
			render "Task not found"
			// TODO: error handler
		}
	}

	def done() {
		def code = params.code

		if (!code) {
			render 'code is required'
		}

		def choices = params.choices

		def result = taskService.submitQuestionnaire(code, choices)

		if (result) {
			render view: '/task/result', model: [Task: result]
		} else {
			// TODO: error handler
		}
	}

	def result() {
		render view: '/task/result'
	}
}
