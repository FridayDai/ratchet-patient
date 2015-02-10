package com.xplusz.ratchet

import grails.converters.JSON

class TaskController extends BaseController {
	def taskService

	def index() {
		def code = params.code

		def result = taskService.getTask(code)

		if (result) {
			render view: "/task/intro", model: [Task: result]
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

			if (questionnaire.type == 1) {
				taskView = '/task/content/dash'
			} else if (questionnaire.type == 2) {
				taskView = '/task/content/odi'
			} else {
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

	def getIntro() {
		render view: "/task/intro"
	}
}
