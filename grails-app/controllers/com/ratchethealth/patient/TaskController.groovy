package com.ratchethealth.patient

import com.ratchethealth.patient.commands.UserCommand
import grails.converters.JSON
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper


class TaskController extends BaseController {
    def taskService

    def index() {
        def patientName = params.patientName
        def code = params.code
        def taskTitle = params.taskTitle

        if (session["taskComplete${code}"]) {
            redirectToComplete(patientName, taskTitle, code)
        } else {
            def resp = taskService.getTask(request, code)
            taskService.recordBehaviour(request, code)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)

                render view: '/task/intro', model: [
                        Task     : result,
                        client   : JSON.parse(session.client),
                        taskTitle: taskTitle,
                        taskCode : code
                ]
            } else if (resp.status == 207) {
                session["taskComplete${code}"] = true

                redirectToComplete(patientName, taskTitle, code)
            }
        }
    }

    def phoneNumberValidate(UserCommand user) {
        def patientName = params.patientName
        def code = params.code
        def taskTitle = params.taskTitle

        if (!user.validate()) {
            def resp = taskService.getTask(request, code)

            if (resp.status == 200) {
                def task = JSON.parse(resp.body)

                render view: '/task/intro',
                        model: [client   : JSON.parse(session.client),
                                Task     : task,
                                taskTitle: taskTitle,
                                taskCode : code,
                                errorMsg : RatchetMessage.TASK_INTRO_INVALID_PHONE_NUMBER
                        ]
            }
        } else {
            def resp = taskService.getQuestionnaire(request, code, user.last4Number)

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
                session["last4Number${code}"] = user.last4Number

                redirect(mapping: 'taskStart', params: [
                        patientName: patientName,
                        taskTitle  : taskTitle,
                        code       : code,
                ])
            } else if (resp.status == 404) {
                render view: '/error/invalidTask', model: [client: JSON.parse(session.client)], status: 404
            } else {
                def taskResp = taskService.getTask(request, code)

                if (taskResp.status == 200) {
                    def task = JSON.parse(taskResp.body)

                    render view: '/task/intro',
                            model: [client   : JSON.parse(session.client),
                                    Task     : task,
                                    taskTitle: taskTitle,
                                    taskCode : code,
                                    errorMsg : RatchetMessage.TASK_INTRO_WRONG_PHONE_NUMBER
                            ]
                }
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
            def last4Number = session["last4Number${code}"]
            def resp = taskService.getQuestionnaire(request, code, last4Number)

            if (resp.status == 200) {
                taskService.recordTaskStart(request, code)
                def result = JSON.parse(resp.body)

                render view: view,
                        model: [
                                client   : JSON.parse(session.client),
                                Task     : result,
                                taskTitle: taskTitle,
                                taskCode : code,
                        ]
            }
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
            def last4Number = session["last4Number${code}"]
            def resp = taskService.getQuestionnaire(request, code, last4Number)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)

                render view: view,
                        model: [
                                client   : JSON.parse(session.client),
                                Task     : result,
                                taskTitle: taskTitle,
                                taskCode : code,
                                choices  : choices,
                                errors   : errors
                        ]
            }
        } else {
            def resp = taskService.submitQuestionnaire(request, code, choices)

//            saveResultToSession(code, resp)

            session["taskComplete${code}"] = true

            redirectToComplete(patientName, taskTitle, code)
        }
    }

    def complete() {
        def patientName = params.patientName
        def taskTitle = params.taskTitle
        def code = params.code
        def completeTask
//        if (session["result${code}"]) {
//            def slurper = new JsonSlurper()
//            completeTask = slurper.parseText(session["result${code}"])
//            if (completeTask.nrsScore) {
//                def nrsScoreString = '{' + completeTask.nrsScore + '}'
//                def nrsScoreJson = JSON.parse(nrsScoreString)
//                if (completeTask.type == 4) {
//                    completeTask.nrsScore1 = nrsScoreJson.back
//                    completeTask.nrsScore2 = nrsScoreJson.leg
//                } else {
//                    completeTask.nrsScore1 = nrsScoreJson.neck
//                    completeTask.nrsScore2 = nrsScoreJson.arm
//                }
//            }
//        } else {
        completeTask = taskService.getTaskResult(request, code)
        if (completeTask.nrsScore) {
            def nrsScoreString = '{' + completeTask.nrsScore + '}'
            def nrsScoreJson = JSON.parse(nrsScoreString)
            if (completeTask.type == 4) {
                completeTask.nrsScore1 = nrsScoreJson.back
                completeTask.nrsScore2 = nrsScoreJson.leg
            } else {
                completeTask.nrsScore1 = nrsScoreJson.neck
                completeTask.nrsScore2 = nrsScoreJson.arm
            }
        }
//        }


        if (session["taskComplete${code}"]) {
            def resp = taskService.getTask(request, code)

            if (resp.status == 207) {
                def result = JSON.parse(resp.body)

                render view: '/task/result/resultBase', model: [
                        Task        : result,
                        client      : JSON.parse(session.client),
                        taskTitle   : taskTitle,
                        taskCode    : code,
                        completeTask: completeTask
                ]
            } else {
                redirectToIndex(patientName, taskTitle, code)
            }
        } else {
            def resp = taskService.getTask(request, code)

            if (resp.status == 200) {
                session["task${code}"] = resp.body

                redirectToIndex(patientName, taskTitle, code)
            } else if (resp.status == 207) {
                session["taskComplete${code}"] = true
                session["task${code}"] = resp.body
                def task = JSON.parse(resp.body)

                render view: '/task/result/resultBase', model: [
                        Task        : task,
                        client      : JSON.parse(session.client),
                        taskTitle   : taskTitle,
                        taskCode    : code,
                        completeTask: completeTask
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

//    def saveResultToSession(code, result) {
//        def fields = ['comparison', 'nrsScore', 'type', 'score', 'lastScoreTime']
//
//        def resultsObj = [:]
//
//        result.keySet().each { key ->
//            if (key in fields) {
//                resultsObj.put(key, result[key])
//            }
//        }
//        def builder = new JsonBuilder()
//        builder(resultsObj)
//        session["result${code}"] = builder.toString()
//    }

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
                code       : code
        ])
    }
}
