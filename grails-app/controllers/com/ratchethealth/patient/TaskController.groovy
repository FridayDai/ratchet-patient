package com.ratchethealth.patient

import grails.converters.JSON


class TaskController extends BaseController {
    def taskService

    def index() {
        def code = params.code
        def taskTitle = params.taskTitle

        def resp = taskService.getTask(request, response, code)

        if (resp.status == 200) {
            def result = JSON.parse(resp.body)
            request.session.task = result.toString()

            render view: '/task/intro', model: [
                    Task: result,
                    client: session.client,
                    taskTitle: taskTitle,
                    taskCode: code
            ]
        } else if (resp.status == 207) {
            def result = JSON.parse(resp.body)
            flash.task = result.toString()

            redirect uri: request.forwardURI.replaceFirst(/\/start$/, '') + '/complete'
        }
    }

    def start() {
        def code = params.code
        def taskTitle = params.taskTitle
        def last4Number = params.last4Number

        def resp = taskService.getQuestionnaire(request, response, code, last4Number)

        if (resp.status == 200) {
            def result = JSON.parse(resp.body)
            def taskView

            //1.DASH 2.ODI 3.NDI 4.NRS-BACK 5.NRS-NECK
            if (result.type == 1) {
                taskView = '/task/content/dash'
            } else if (result.type == 2 || result.type == 3) {
                taskView = '/task/content/odi'
            } else if (result.type == 4 || result.type == 5) {
                taskView = '/task/content/nrs'
            }

            render view: taskView, model: [
                    Task: result,
                    taskCode: code,
                    client: session.client,
                    taskTitle: taskTitle
            ]
        } else if (resp.status == 404 || !request.session.task) {
            render view: '/error/invalidTask', model: [client: session.client], status: 404
        } else {
            def task = JSON.parse(request.session.task)

            render view: '/task/intro',
                    model: [client  : session.client,
                            Task    : task,
                            taskTitle: taskTitle,
                            taskCode: code,
                            errorMsg: RatchetMessage.TASK_INTRO_WRONG_PHONE_NUMBER
                    ]
        }
    }

    def hasComplete() {
        def code = params.code
        def taskTitle = params.taskTitle

        if (flash.task) {
            def task = JSON.parse(flash.task)

            render view: '/task/result', model: [
                    Task: task,
                    client: session.client,
                    taskTitle: taskTitle,
                    taskCode: code
            ]
        } else {
            def resp = taskService.getTask(request, response, code)

            if (resp.status == 200) {
                redirect uri: request.forwardURI.replaceFirst(/\/complete$/, '')
            } else if (resp.status == 207) {
                def result = JSON.parse(resp.body)
                render view: '/task/result', model: [
                        Task: result,
                        client: session.client,
                        taskTitle: taskTitle,
                        taskCode: code
                ]
            }
        }
    }

    def done() {
        def code = params.code
        def taskTitle = params.taskTitle

        if (!code) {
            render 'code is required'
        }

        def choices = params.choices

        def result = taskService.submitQuestionnaire(request, response, code, choices)

        if (!(result instanceof Integer)) {
            render view: '/task/result', model: [
                    Task: result,
                    client: session.client,
                    taskTitle: taskTitle,
                    taskCode: code
            ]
        }
    }
}
