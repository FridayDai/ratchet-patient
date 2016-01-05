package com.ratchethealth.patient

import grails.converters.JSON

class MultiTaskController extends BaseController {

    def multiTaskService
    def taskService
    def patientService

    def index() {
        render view: '/clinicTask/codeValidation', model: [client: JSON.parse(session.client)]
    }

    def checkPath() {
        def pathRoute = params?.pathRoute
        if (pathRoute == "codeValidation") {
            forward(action: "getTreatmentTasks", params: [params: params])
        } else if (pathRoute == "tasksList") {
            forward(action: "startTasks", params: [params: params])
        } else if (pathRoute == "todoTask") {
            forward(action: "submitTasks", params: [params: params])
        } else if (pathRoute == "submitEmail") {
            forward(action: "submitPatientEmail", params: [params: params])
        } else if (pathRoute == "completeTask") {
            forward(action: "completeTasks", params: [params: params])
        }
    }

    def getTreatmentTasks() {
        String token = request.session.token
        def treatmentCode = params?.treatmentCode
        def isInClinic = params?.isInClinic
        def serverName = request.getServerName()
        def subDomain = serverName.substring(0, serverName.indexOf('.'))
        def resp

        if (isInClinic) {
            resp = multiTaskService.getTreatmentTasksWithTreatmentCode(token, treatmentCode, null, subDomain)
        } else {
            resp = multiTaskService.getTreatmentTasksWithCombinedTasksCode(token, treatmentCode, null, subDomain)
        }

        if (resp.status == 200) {
            def tasksListResp = JSON.parse(resp.body)
            def tasksList = tasksListResp.tests
            def firstName = tasksListResp.firstName
            def emailStatus = tasksListResp.emailStatus
            def patientId = tasksListResp.patientId
            if (tasksList) {
                render view: '/clinicTask/tasksList', model: [
                    client: JSON.parse(session.client),
                    tasksList: tasksList,
                    treatmentCode: treatmentCode,
                    patientFirstName: firstName,
                    emailStatus: emailStatus,
                    patientId: patientId,
                    isInClinic: isInClinic,
                    tasksLength: tasksList.size()
                ]
            } else {
                render view: '/clinicTask/tasksList', model: [
                    client: JSON.parse(session.client),
                    patientFirstName: firstName,
                    isInClinic: isInClinic
                ]
            }
        } else if (isInClinic) {
            if (resp.status == 404) {
                render view: '/clinicTask/codeValidation', model: [client: JSON.parse(session.client), errorMsg: RatchetMessage.IN_CLINIC_INCORRECT_TREATMENT_CODE]
            } else if (resp.status == 412) {
                render view: '/clinicTask/codeValidation', model: [client: JSON.parse(session.client), errorMsg: RatchetMessage.IN_CLINIC_EXPIRED_TREATMENT_CODE]
            } else {
                render view: '/error/taskExpired', model: [client: JSON.parse(session.client)]
            }
        } else {
            taskService.handleError(resp)
        }
    }

    def startTasks() {
        String token = request.session.token
        def tasksList = JSON.parse(params?.tasksList)
        def itemIndex = params?.int('itemIndex')
        def isInClinic = params?.isInClinic
        def treatmentCode = params?.treatmentCode
        def emailStatus = params?.emailStatus
        def patientId = params?.patientId

        def task = tasksList[itemIndex]
        def taskTitle = task.title
        def taskCode = task.code
        def resp, draft = null

        if (isInClinic) {
            resp = taskService.getQuestionnaire(token, treatmentCode, taskCode, null)
        } else {
            resp = taskService.getQuestionnaireWithCombineTaskCode(token, treatmentCode, taskCode)
        }

        if (resp.status == 200) {
            def result = JSON.parse(resp.body)
            def questionnaireView = ''

            //1.DASH 2.ODI 3.NDI 4.NRS-BACK 5.NRS-NECK 6.QuickDASH 7.KOOS 8.HOOS
            // 9.Harris Hip Score 10.Fairley Nasal Symptom 11.Pain Chart Reference - Neck
            // 12.Pain Chart Reference - Beck 13.New Patient Questionnaire Tool
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
                case 7:
                case 8:
                case 15:
                case 1000:
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
                case 14:
                    questionnaireView = '/task/content/promis'

                    if (result.draft) {
                        draft = JSON.parse(JSON.parse(result.draft).yourData)
                    }
                    break
            }

            session["questionnaireView${taskCode}"] = questionnaireView

            render view: questionnaireView,
                    model: [
                            client: JSON.parse(session.client),
                            isInClinic: isInClinic,
                            Task: result,
                            Draft: draft,
                            taskTitle: taskTitle,
                            taskCode: taskCode,
                            itemIndex: itemIndex,
                            tasksList: tasksList,
                            treatmentCode: treatmentCode,
                            tasksLength: tasksList.size(),
                            patientId: patientId,
                            emailStatus: emailStatus
                    ]
        } else if (resp.status == 404) {
            render view: '/error/invalidTask', model: [client: JSON.parse(session.client)], status: 404
        }
    }

    def submitTasks() {
        if(params.hardcodeTask) {
            forward(action: "submitSpecialTask", params: [params: params])
            return
        }
        String token = request.session.token
        def itemIndex = params?.itemIndex
        def tasksList = params?.tasksList
        def tasksListRecord = JSON.parse(tasksList)
        def itemIndexRecord = params?.int('itemIndex')
        def isInClinic = params?.isInClinic
        def treatmentCode = params?.treatmentCode
        def emailStatus = params?.emailStatus
        def patientId = params?.patientId
        def taskTitle = params.taskTitle
        def code = params.code
        def taskType = params.taskType
        def choices = params.choices
        def optionals = params.optionals
        def sections = params.sections
        def answer = []
        def errors

        if (sections) {
            sections.each { key, String[] value ->
                def section = [:]
                def options = [:]
                value.each {
                    if(choices){
                        def val = choices[it]
                        if (val) {
                            options.put(it, val)
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
        if ( taskType=='2' || taskType=='3' || taskType == '7' || taskType == '8') {
            //for complex validation, only valid in js.(2.ODI 3.NDI 7.KOOS 8.HOOS)
            errors = [];
        } else {
            errors = validateChoice(taskType, choices, optionals)
        }

        if (errors.size() > 0) {
            def view = session["questionnaireView${code}"]
            def resp

            if (isInClinic) {
                resp = taskService.getQuestionnaire(token, treatmentCode, code, null)
            } else {
                resp = taskService.getQuestionnaireWithCombineTaskCode(token, treatmentCode, code)
            }

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)

                render view: view,
                        model: [
                                client: JSON.parse(session.client),
                                isInClinic: isInClinic,
                                Task: result,
                                taskTitle: taskTitle,
                                taskCode: code,
                                choices: choices,
                                itemIndex: (itemIndexRecord - 1),
                                tasksList: tasksListRecord,
                                treatmentCode: treatmentCode,
                                tasksLength: tasksListRecord.size(),
                                errors: errors,
                                emailStatus: emailStatus
                        ]
            }
        } else {
            answer.each {
                it.choices = convertChoice(taskType, it.choices)
            }
            taskService.submitQuestionnaireWithoutErrorHandle(token, code, answer, null)

            if (itemIndexRecord < tasksListRecord.size()) {
                forward(action: 'startTasks', params: [
                    itemIndex: itemIndex,
                    treatmentCode: treatmentCode,
                    tasksList: tasksList,
                    isInClinic: isInClinic
                ])
            } else {
                if(isInClinic && RatchetStatusCode.emailStatus[emailStatus.toInteger()] == 'NO_EMAIL') {
                    forward(action: 'enterPatientEmail', params: [
                        patientId: patientId,
                        treatmentCode: treatmentCode,
                        tasksList: tasksList,
                        isInClinic: isInClinic
                    ])
                } else {
                    forward(action: 'completeTasks', params: [
                        treatmentCode: treatmentCode,
                        tasksList: tasksList,
                        isInClinic: isInClinic
                    ])
                }
            }
        }
    }

    def submitSpecialTask() {
        String token = request.session.token
        def itemIndex = params?.itemIndex
        def tasksList = params?.tasksList
        def tasksListRecord = JSON.parse(tasksList)
        def itemIndexRecord = params?.int('itemIndex')
        def isInClinic = params?.isInClinic

        def treatmentCode = params?.treatmentCode
        def emailStatus = params?.emailStatus
        def choices = params.choices
        def code = params.code

        taskService.submitQuestionnaireWithoutErrorHandle(token, code, [0], choices)
        if (itemIndexRecord < tasksListRecord.size()) {
            forward(action: 'startTasks', params: [
                    itemIndex: itemIndex,
                    treatmentCode: treatmentCode,
                    tasksList: tasksList,
                    isInClinic: isInClinic
            ])
        } else {
            if(isInClinic && RatchetStatusCode.emailStatus[emailStatus.toInteger()] == 'NO_EMAIL') {
                forward(action: 'enterPatientEmail', params: [
                        treatmentCode: treatmentCode,
                        tasksList: tasksList,
                        isInClinic: isInClinic
                ])
            } else {
                forward(action: 'completeTasks', params: [
                        treatmentCode: treatmentCode,
                        tasksList: tasksList,
                        isInClinic: isInClinic
                ])
            }
        }
    }

    def completeTasks() {
        def tasksList = params?.tasksList
        def treatmentCode = params?.treatmentCode
        def tasksListRecord = JSON.parse(tasksList)
        def isInClinic = params?.isInClinic

        render(view: '/clinicTask/tasksList', model: [
            client: JSON.parse(session.client),
            tasksCompleted: true,
            doneTaskList: tasksListRecord,
            treatmentCode: treatmentCode,
            isInClinic: isInClinic,
            tasksLength: tasksListRecord.size()
        ])
    }

    def enterPatientEmail() {
        def tasksList = params?.tasksList
        def treatmentCode = params?.treatmentCode
        def errorMsg = params?.errorMsg
        def isInClinic = params?.isInClinic

        render view: '/clinicTask/enterEmail', model: [
            client: JSON.parse(session.client),
            treatmentCode: treatmentCode,
            tasksList: tasksList,
            isInClinic: isInClinic,
            errorMsg: errorMsg
        ]
    }

    def submitPatientEmail() {
        String token = request.session.token
        def email = params?.email
        def tasksList = params?.tasksList
        def treatmentCode = params?.treatmentCode
        def isInClinic = params?.isInClinic

        def resp = patientService.updatePatient(token, treatmentCode, email)
        if (resp.status == 400 || resp.status == 404) {
            def result = JSON.parse(resp.body)

            forward(action: 'enterPatientEmail', params: [
                treatmentCode: treatmentCode,
                tasksList: tasksList,
                isInClinic: isInClinic,
                errorMsg: result?.error?.errorMessage
            ])
        } else {
            forward(action: 'completeTasks', params: [
                treatmentCode: treatmentCode,
                isInClinic: isInClinic,
                tasksList: tasksList
            ])
        }
    }

    def saveDraftAnswer() {
        String token = request.session.token
        def taskId = params?.taskId
        def code = params?.code
        def questionId = params?.questionId
        def answerId = params?.answerId
        def complex = params?.complex

        multiTaskService.saveDraftAnswer(token, taskId, code, questionId, answerId, complex)

        render status: 201
    }

//    def validateSectionChoice(sections, answer) {
//        def errors = [:]
//        answer.each {
//            def sectionId = it.sectionId
//            if (it.choices.size() < RatchetStatusCode.choicesLimit[sectionId.toInteger()]) {
//                def sectionChoices = sections[sectionId] ?: []
//                def checkedChoices = it.choices.keySet() ?: []
//                def list = sectionChoices - checkedChoices
//                list.each {
//                    errors[it] = 1
//                }
//            }
//        }
//        return errors
//    }

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
}
