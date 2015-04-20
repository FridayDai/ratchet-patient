package com.ratchethealth.patient

import com.ratchethealth.patient.commands.UserCommand
import grails.converters.JSON


class TaskController extends BaseController {
	def taskService

	def index() {
		def patientName = params.patientName
		def code = params.code
		def taskTitle = params.taskTitle

		if (session["taskComplete${code}"]) {
			redirectToComplete(patientName, taskTitle, code)
		} else if (session["task${code}"]) {
			def result = JSON.parse(session["task${code}"])

			render view: '/task/intro', model: [
					Task     : result,
					client   : session.client,
					taskTitle: taskTitle,
					taskCode : code
			]
		} else {
			def resp = taskService.getTask(request, response, code)

			if (resp.status == 200) {
				def result = JSON.parse(resp.body)
				session["task${code}"] = resp.body

				render view: '/task/intro', model: [
						Task     : result,
						client   : session.client,
						taskTitle: taskTitle,
						taskCode : code
				]
			} else if (resp.status == 207) {
				session["taskComplete${code}"] = true
				session["task${code}"] = resp.body

				redirectToComplete(patientName, code, taskTitle)
			}
		}
	}

	def phoneNumberValidate(UserCommand user) {
		def patientName = params.patientName
		def code = params.code
		def taskTitle = params.taskTitle

		if (!user.validate()) {
			def task = JSON.parse(session["task${code}"])

			render view: '/task/intro',
					model: [client   : session.client,
							Task     : task,
							taskTitle: taskTitle,
							taskCode : code,
							errorMsg : RatchetMessage.TASK_INTRO_INVALID_PHONE_NUMBER
					]
		} else {
			def resp = taskService.getQuestionnaire(request, response, code, user.last4Number)

			if (resp.status == 200) {
				def result = JSON.parse(resp.body)
				def questionnaireView = ''

				//1.DASH 2.ODI 3.NDI 4.NRS-BACK 5.NRS-NECK 6.QuickDASH
				if (result.type == 1 || result.type == 6) {
					questionnaireView = '/task/content/dash'
				} else if (result.type == 2 || result.type == 3) {
					questionnaireView = '/task/content/odi'
				} else if (result.type == 4 || result.type == 5) {
					questionnaireView = '/task/content/nrs'
				}

				session["questionnaireView${code}"] = questionnaireView
				session["questionnaire${code}"] = resp.body

				redirect(mapping: 'taskStart', params: [
						patientName: patientName,
						taskTitle  : taskTitle,
						code       : code,
				])
			} else if (resp.status == 404 || !request.session["task${code}"]) {
				render view: '/error/invalidTask', model: [client: session.client], status: 404
			} else {
				def task = JSON.parse(session["task${code}"])

				render view: '/task/intro',
						model: [client   : session.client,
								Task     : task,
								taskTitle: taskTitle,
								taskCode : code,
								errorMsg : RatchetMessage.TASK_INTRO_WRONG_PHONE_NUMBER
						]
			}
		}
	}

	def start() {
		def patientName = params.patientName
		def taskTitle = params.taskTitle
		def code = params.code

		if (session["taskComplete${code}"]) {
			redirectToComplete(patientName, taskTitle, code)
		} else if (session["questionnaireView${code}"]) {
			def view = session["questionnaireView${code}"]
			def questionnaire = JSON.parse(session["questionnaire${code}"])

			render view: view,
					model: [
							client   : session.client,
							Task     : questionnaire,
							taskTitle: taskTitle,
							taskCode : code,
					]
		} else {
			redirectToIndex(patientName, taskTitle, code)
		}
	}

	def submit() {
		def patientName = params.patientName
		def taskTitle = params.taskTitle
		def code = params.code
		def taskType = params.taskType
		def choices = params.choices
		def optionals = params.optionals

		def errors = validateChoice(taskType, choices, optionals)

		if (errors.size() > 0) {
			def view = session["questionnaireView${code}"]
			def questionnaire = JSON.parse(session["questionnaire${code}"])

			render view: view,
					model: [
							client   : session.client,
							Task     : questionnaire,
							taskTitle: taskTitle,
							taskCode : code,
							choices  : choices,
							errors   : errors
					]
		} else {
			taskService.submitQuestionnaire(request, response, code, choices)

			session["taskComplete${code}"] = true

			redirectToComplete(patientName, taskTitle, code)
		}
	}

	def complete() {
		def patientName = params.patientName
		def taskTitle = params.taskTitle
		def code = params.code

		if (session["taskComplete${code}"]) {
			def task = JSON.parse(session["task${code}"])

			render view: '/task/result', model: [
					Task     : task,
					client   : session.client,
					taskTitle: taskTitle,
					taskCode : code
			]
		} else {
			def resp = taskService.getTask(request, response, code)

			if (resp.status == 200) {
				session["task${code}"] = resp.body

				redirectToIndex(patientName, taskTitle, code)
			} else if (resp.status == 207) {
				session["taskComplete${code}"] = true
				session["task${code}"] = resp.body
				def task = JSON.parse(resp.body)

				render view: '/task/result', model: [
						Task     : task,
						client   : session.client,
						taskTitle: taskTitle,
						taskCode : code
				]
			}
		}
	}

	def validateChoice(type, choices, optionals) {
		def errors = [:]

		if (type == '4') {
			// 4.NRS-BACK
			if (choices?.back == null) {
				errors[0] = 1
			}
			if (choices?.leg == null) {
				errors[1] = 1
			}
		} else if (type == '5') {
			// 5.NRS-NECK
			if (choices?.neck == null) {
				errors[0] = 1
			}
			if (choices?.arm == null) {
				errors[1] = 1
			}
		} else {
			// others
			for (choice in optionals) {
				if (optionals[choice.key] == '1' && !choices?.containsKey(choice.key)) {
					errors[choice.key] = 1
				}
			}
		}

		return errors
	}

	def redirectToIndex(patientName, taskTitle, code) {
		redirect(mapping: 'taskIndex', params: [
				patientName: patientName,
				taskTitle  : taskTitle,
				code       : code,
		])
	}

	def redirectToComplete(patientName, taskTitle, code) {
		redirect(mapping: 'taskComplete', params: [
				patientName: patientName,
				taskTitle  : taskTitle,
				code       : code,
		])
	}
}
