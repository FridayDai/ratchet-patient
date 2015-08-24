package com.ratchethealth.patient

import grails.converters.JSON

class ClinicTestPathController extends BaseController {

    def clinicTestPathService
    def taskService

    def index() {
        render view: '/clinicTask/codeValidation', model: [client: JSON.parse(session.client)]
    }

    def getTreatmentTasks() {
        String token = request.session.token
        def treatmentCode = params?.treatmentCode
        def resp = clinicTestPathService.getTreatmentTasks(token, treatmentCode)
        if (resp.status == 200) {
            def tasksListResp = JSON.parse(resp.body)
            def tasksList = tasksListResp.tests
            def firstName = tasksListResp.firstName
            if (tasksList) {
                session["tasksListLength${treatmentCode}"] = tasksList.size()
                render view: '/clinicTask/tasksList', model: [client          : JSON.parse(session.client),
                                                              tasksList       : tasksList, treatmentCode: treatmentCode,
                                                              patientFirstName: firstName,
                                                              tasksLength     : session["tasksListLength${treatmentCode}"]]
            } else {
                render view: '/clinicTask/tasksList', model: [client: JSON.parse(session.client), patientFirstName: firstName]
            }
        } else if (resp.status == 404) {
            render view: '/clinicTask/codeValidation', model: [client: JSON.parse(session.client), errorMsg: RatchetMessage.IN_CLINIC_INCORRECT_TREATMENT_CODE]
        } else {
            render view: '/error/taskExpired', model: [client: JSON.parse(session.client)]
        }
    }

    def startTasks() {
        String token = request.session.token
        def tasksList = JSON.parse(params?.tasksList)
        def itemIndex = params?.int('itemIndex')
        def treatmentCode = params?.treatmentCode

        def task = tasksList[itemIndex]
        def taskTitle = task.title
        def taskCode = task.code

        def resp = taskService.getQuestionnaire(token, treatmentCode, taskCode, null)

        if (resp.status == 200) {
            def result = JSON.parse(resp.body)
            def questionnaireView = ''

            //1.DASH 2.ODI 3.NDI 4.NRS-BACK 5.NRS-NECK 6.QuickDASH
            if (result.type == 1 || result.type == 6) {
                questionnaireView = '/clinicTask/content/dash'
            } else if (result.type == 2 || result.type == 3) {
                questionnaireView = '/clinicTask/content/odi'
            } else if (result.type == 4 || result.type == 5) {
                questionnaireView = '/clinicTask/content/nrs'
            }

            session["questionnaireView${taskCode}"] = questionnaireView

            render view: questionnaireView,
                    model: [
                            client       : JSON.parse(session.client),
                            Task         : result,
                            taskTitle    : taskTitle,
                            taskCode     : taskCode,
                            itemIndex    : itemIndex,
                            tasksList    : tasksList,
                            treatmentCode: treatmentCode,
                            tasksLength  : session["tasksListLength${treatmentCode}"]
                    ]
        } else if (resp.status == 404) {
            render view: '/error/invalidTask', model: [client: JSON.parse(session.client)], status: 404
        }
    }

    def submitTasks() {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        String token = request.session.token
        def itemIndex = params?.itemIndex
        def tasksList = params?.tasksList
        def treatmentCode = params?.treatmentCode
        def taskTitle = params.taskTitle
        def code = params.code
        def taskType = params.taskType
        def choices = params.choices
        def optionals = params.optionals

        def errors = validateChoice(taskType, choices, optionals)

        if (errors.size() > 0) {
            def view = session["questionnaireView${taskCode}"]
            def resp = taskService.getQuestionnaire(token, treatmentCode, code, null)

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
            choices = convertChoice(taskType, choices)
            def resp = taskService.submitQuestionnaireWithoutHandle(token, code, choices)
//            def resp = taskService.submitQuestionnaire(token, code, choices)
            def tasksListRecord = JSON.parse(tasksList)
            def itemIndexRecord = params?.int('itemIndex')
//            def taskRecord = tasksListRecord[itemIndexRecord - 1]
//            if (resp) {
//                taskRecord["status"] = "done"
//            }
            if (itemIndexRecord < tasksListRecord.size()) {
                forward(action: 'startTasks', params: [itemIndex: itemIndex, treatmentCode: treatmentCode, tasksList: tasksList])
            } else {
                render(view: '/clinicTask/tasksList', model: [client     : JSON.parse(session.client),
                                                              tasksList  : JSON.parse(tasksList), treatmentCode: treatmentCode,
                                                              tasksLength: itemIndex])
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
