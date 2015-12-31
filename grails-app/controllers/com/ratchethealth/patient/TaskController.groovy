package com.ratchethealth.patient

import grails.converters.JSON
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper


class TaskController extends BaseController {
    def taskService

    def singleTask() {
        String token = request.session.token
        def patientName = params.patientName
        def code = params.code
        def taskTitle = params.title

        def patientId = taskService.getPatientInfoByTaskCode(token, code).patientPK

        if (session["taskComplete${code}"]) {
            redirectToComplete(patientName, patientId, taskTitle, code)
        } else {
            taskService.recordBehaviour(token, code)
            def resp = taskService.getQuestionnaire(token, null, code, null)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)

                def questionnaireView = ''

                switch (result.type) {
                    case 1: case 6: case 10:
                        questionnaireView = '/task/content/dash'
                        break
                    case 2: case 3:
                        questionnaireView = '/task/content/odi'
                        break
                    case 4: case 5:
                        questionnaireView = '/task/content/nrs'

                        if (result.draft) {
                            draft = JSON.parse(JSON.parse(result.draft).yourData)
                        }
                        break
                    case 7: case 8:
                        questionnaireView = '/task/content/koos'
                        break
                    case 9:
                        questionnaireView = '/task/content/verticalChoice'
                        break
                //TODO merger odi to verticalChoice template after api portal gives the same format data in all tasks.
                    case 11:
                        questionnaireView = '/task/content/painChartNeck'

                        if (result.draft) {
                            draft = JSON.parse(JSON.parse(result.draft).yourData)
                        }
                        break
                    case 12:
                        questionnaireView = '/task/content/painChartBack'

                        if (result.draft) {
                            draft = JSON.parse(JSON.parse(result.draft).yourData)
                        }
                        break
                    case 13:
                        questionnaireView = '/task/content/newPatientQuestionnaire'
                        if (result.draft) {
                            draft = JSON.parse(JSON.parse(result.draft).yourData)
                        }
                        break
                }

                render view: questionnaireView, model: [
                        Task     : result,
                        client   : JSON.parse(session.client),
                        taskTitle: taskTitle,
                        taskCode : code
                ]
            }
        }
    }

    def submitSingleTask() {

        if(params.hardcodeTask) {
            forward(action: "submitSpecialTask", params: [params: params])
            return
        }

        String token = request.session.token
        def patientName = params.patientName
        def patientId = params.patientId
        def taskTitle = params.title
        def code = params.code
        def taskType = params.taskType
        def choices = params.choices
        def optionals = params.optionals
        def sections = params.sections
        def answer = []
        def errors
        def accountId = params.accountId

        if (sections) {
            sections.each { key, value ->
                def section = [:]
                def options = [:]

                if (value.getClass() == String) {
                    if (choices) {
                        options.put(value, choices[value])
                    }
                } else {
                    value.each {
                        if (choices) {
                            def val = choices[it]
                            if (val) {
                                options.put(it, val)
                            }
                        }
                    }
                }
                section.put("sectionId", key)
                section.put("choices", options)
                answer.add(section)
            }
        } else {
            def section = [:]
            section.put("sectionId", null)
            section.put("choices", choices)
            answer.add(section)
        }

        //validation
        if (taskType == '7' || taskType == '8') {
            //only check for (7.KOOS 8.HOOS)
            errors = validateSectionChoice(sections, answer)
        } else {
            errors = validateChoice(taskType, choices, optionals)
        }

        if (errors.size() > 0) {
            def view = session["questionnaireView${code}"]
            def last4Number = session["last4Number${code}"]
            def resp = taskService.getQuestionnaire(token, null, code, last4Number)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)

                render view: view,
                        model: [
                                client   : JSON.parse(session.client),
                                patientId: patientId,
                                Task     : result,
                                taskTitle: taskTitle,
                                taskCode : code,
                                choices  : choices,
                                errors   : errors
                        ]
            }
        } else {
            answer.each {
                it.choices = convertChoice(taskType, it.choices)
            }

            def resp = taskService.submitSingleTask(token, code, answer, accountId)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body.toString())
                saveResultToSession(code, result)
            }

            if (resp.status == 200 || resp.status == 207) {

                render(view: '/clinicTask/tasksList', model: [
                        client: JSON.parse(session.client),
                        tasksCompleted: true,
                        tasksLength   : 1,
                        isSingleTask  : true,
                        taskTitle     : taskTitle
                ])
            }
        }
    }

    def submitSpecialTask() {
        String token = request.session.token
        def taskTitle = params?.title
        def choices = params.choices
        def code = params.code

        taskService.submitQuestionnaireWithoutErrorHandle(token, code, [0], choices)

        render(view: '/clinicTask/tasksList', model: [
                client: JSON.parse(session.client),
                tasksCompleted: true,
                tasksLength   : 1,
                isSingleTask  : true,
                taskTitle     : taskTitle
        ])
    }


    def start() {
        String token = request.session.token
        def patientName = params.patientName
        def taskTitle = params.taskTitle
        def code = params.code
        def patientId = params.patientId

        if (session["taskComplete${code}"]) {
            redirectToComplete(patientName, patientId, taskTitle, code)
        } else if (session["questionnaireView${code}"]) {
            def view = session["questionnaireView${code}"]
            def last4Number = session["last4Number${code}"]
            def resp = taskService.getQuestionnaire(token, null, code, last4Number)

            if (resp.status == 200) {
                taskService.recordTaskStart(token, code)
                def result = JSON.parse(resp.body)

                render view: view,
                        model: [
                                client   : JSON.parse(session.client),
                                Task     : result,
                                taskTitle: taskTitle,
                                taskCode : code,
                                patientId: patientId
                        ]
            } else if (resp.status == 207) {
                session["taskComplete${code}"] = true

                redirectToComplete(patientName, patientId, taskTitle, code)
            } else if (resp.status == 412) {
                render view: "/error/taskExpired", model: [client: JSON.parse(session.client)]
            }
        } else {
            redirectToIndex(patientName, taskTitle, code)
        }
    }

    def submit() {
        String token = request.session.token
        def patientName = params.patientName
        def patientId = params.patientId
        def taskTitle = params.taskTitle
        def code = params.code
        def taskType = params.taskType
        def choices = params.choices
        def optionals = params.optionals
        def sections = params.sections
        def answer = []
        def errors

        if (sections) {
            sections.each { key, value ->
                def section = [:]
                def options = [:]

                if (value.getClass() == String) {
                    if (choices) {
                        options.put(value, choices[value])
                    }
                } else {
                    value.each {
                        if (choices) {
                            def val = choices[it]
                            if (val) {
                                options.put(it, val)
                            }
                        }
                    }
                }
                section.put("sectionId", key)
                section.put("choices", options)
                answer.add(section)
            }
        } else {
            def section = [:]
            section.put("sectionId", null)
            section.put("choices", choices)
            answer.add(section)
        }

        //validation
        if (taskType == '7' || taskType == '8') {
            //only check for (7.KOOS 8.HOOS)
            errors = validateSectionChoice(sections, answer)
        } else {
            errors = validateChoice(taskType, choices, optionals)
        }

        if (errors.size() > 0) {
            def view = session["questionnaireView${code}"]
            def last4Number = session["last4Number${code}"]
            def resp = taskService.getQuestionnaire(token, null, code, last4Number)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)

                render view: view,
                        model: [
                                client   : JSON.parse(session.client),
                                patientId: patientId,
                                Task     : result,
                                taskTitle: taskTitle,
                                taskCode : code,
                                choices  : choices,
                                errors   : errors
                        ]
            }
        } else {
            answer.each {
                it.choices = convertChoice(taskType, it.choices)
            }

            def resp = taskService.submitQuestionnaire(token, code, answer)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body.toString())
                saveResultToSession(code, result)
            }

            if (resp.status == 200 || resp.status == 207) {
                session["taskComplete${code}"] = true

                redirectToComplete(patientName, patientId, taskTitle, code)
            } else if (resp.status == 412) {
                render view: "/error/taskExpired", model: [client: JSON.parse(session.client)]
            }
        }
    }

    def complete() {
        String token = request.session.token
        def patientName = params.patientName
        def patientId = params.patientId
        def taskTitle = params.taskTitle
        def code = params.code
        def completeTask
        if (session["result${code}"]) {
            def slurper = new JsonSlurper()
            completeTask = slurper.parseText(session["result${code}"])
            if (completeTask.nrsScore) {
                if (completeTask.type == 4 || completeTask.type == 5) {
                    completeTask = splitNrsScore(completeTask)
                }
            }
        } else {
            completeTask = taskService.getTaskResult(token, code)
            if (completeTask.nrsScore) {
                if (completeTask.type == 4 || completeTask.type == 5) {
                    completeTask = splitNrsScore(completeTask)
                }
            }
        }

        if (session["taskComplete${code}"]) {
            def resp = taskService.getTask(token, code)

            if (resp.status == 207) {
                def result = JSON.parse(resp.body)

                render view: '/task/result/resultBase', model: [
                        Task        : result,
                        client      : JSON.parse(session.client),
                        taskTitle   : taskTitle,
                        taskCode    : code,
                        patientId   : patientId,
                        completeTask: completeTask
                ]
            } else {
                redirectToIndex(patientName, taskTitle, code)
            }
        } else {
            def resp = taskService.getTask(token, code)

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
            } else if (resp.status == 412) {
                render view: "/error/taskExpired", model: [client: JSON.parse(session.client)]
            }
        }
    }

    def convertChoice(type, choices) {
        if (type == '4' || type == '5') {
            return choices
        } else {
            def newType = [:]

            choices.entrySet().each { entry ->
                def vals = entry.value.split('\\.')

                newType[vals[0]] = vals[1]
            };

            return newType
        }
    }

    def splitNrsScore(completeTask) {
        def nrsScoreString = '{' + completeTask.nrsScore + '}'
        def nrsScoreJson = JSON.parse(nrsScoreString)
        if (completeTask.type == 4) {
            completeTask.nrsScore1 = nrsScoreJson.back
            completeTask.nrsScore2 = nrsScoreJson.leg
        } else {
            completeTask.nrsScore1 = nrsScoreJson.neck
            completeTask.nrsScore2 = nrsScoreJson.arm
        }
        return completeTask
    }

    def validateSectionChoice(sections, answer) {
        def errors = [:]
        answer.each {
            def sectionId = it.sectionId
            if (it.choices.size() < RatchetStatusCode.choicesLimit[sectionId.toInteger()]) {
                def sectionChoices = sections[sectionId] ?: []
                def checkedChoices = it.choices.keySet() ?: []
                def list = sectionChoices - checkedChoices
                list.each {
                    errors[it] = 1
                }
            }
        }
        return errors
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

    def saveResultToSession(code, result) {
        def fields = ['comparison', 'nrsScore', 'type', 'score', 'lastScoreTime']

        def resultsObj = [:]

        result.keySet().each { key ->
            if (key in fields) {
                resultsObj.put(key, result[key])
            }
        }
        def builder = new JsonBuilder()
        builder(resultsObj)
        session["result${code}"] = builder.toString()
    }

    def redirectToIndex(patientName, taskTitle, code) {
        redirect(mapping: 'taskIndex', params: [
                patientName: patientName,
                taskTitle  : taskTitle,
                code       : code,
        ])
    }

    def redirectToComplete(patientName, patientId, taskTitle, code) {

        redirect(mapping: 'taskComplete', params: [
                patientName: patientName,
                patientId  : patientId,
                taskTitle  : taskTitle,
                code       : code
        ])

    }
}
