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
        def completedTasksOnly
        def resp = clinicTestPathService.getTreatmentTasks(token, treatmentCode, completedTasksOnly)
        if (resp.status == 200) {
            def tasksListResp = JSON.parse(resp.body)
            def tasksList = tasksListResp.tests
            def firstName = tasksListResp.firstName
            if (tasksList) {
//                session["tasksListLength${treatmentCode}"] = tasksList.size()
                render view: '/clinicTask/tasksList', model: [client          : JSON.parse(session.client),
                                                              tasksList       : tasksList, treatmentCode: treatmentCode,
                                                              patientFirstName: firstName,
                                                              tasksLength     : tasksList.size()]
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

            //1.DASH 2.ODI 3.NDI 4.NRS-BACK 5.NRS-NECK 6.QuickDASH 7.KOOS 8.HOOS
            if (result.type == 1 || result.type == 6) {
                questionnaireView = '/clinicTask/content/dash'
            } else if (result.type == 2 || result.type == 3) {
                questionnaireView = '/clinicTask/content/odi'
            } else if (result.type == 4 || result.type == 5) {
                questionnaireView = '/clinicTask/content/nrs'
            } else if (result.type == 7 || result.type == 8) {
                questionnaireView = '/clinicTask/content/koos'
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
                            tasksLength  : tasksList.size()
                    ]
        } else if (resp.status == 404) {
            render view: '/error/invalidTask', model: [client: JSON.parse(session.client)], status: 404
        }
    }

    def submitTasks() {
        String token = request.session.token
        def itemIndex = params?.itemIndex
        def tasksList = params?.tasksList
        def tasksListRecord = JSON.parse(tasksList)
        def itemIndexRecord = params?.int('itemIndex')
        def treatmentCode = params?.treatmentCode
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
                value.each {
                    def val = choices[it]
                    if (val) {
                        options.put(it, val)
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
            def resp = taskService.getQuestionnaire(token, treatmentCode, code, null)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)

                render view: view,
                        model: [
                                client       : JSON.parse(session.client),
                                Task         : result,
                                taskTitle    : taskTitle,
                                taskCode     : code,
                                choices      : choices,
                                itemIndex    : (itemIndexRecord - 1),
                                tasksList    : tasksListRecord,
                                treatmentCode: treatmentCode,
                                tasksLength  : tasksListRecord.size(),
                                errors       : errors,
                        ]
            }
        } else {
            answer.each {
                it.choices = convertChoice(taskType, it.choices)
            }
            taskService.submitQuestionnaireWithoutErrorHandle(token, code, answer)

            if (itemIndexRecord < tasksListRecord.size()) {
                forward(action: 'startTasks', params: [itemIndex: itemIndex, treatmentCode: treatmentCode, tasksList: tasksList])
            } else {
                def completedTasksOnly = true
                def resp = clinicTestPathService.getTreatmentTasks(token, treatmentCode, completedTasksOnly)
                if (resp.status == 200) {
                    def completeTasksList = JSON.parse(resp.body)
                    def uncompleteTasksList = tasksListRecord - completeTasksList.tests
                    render(view: '/clinicTask/tasksList', model: [client           : JSON.parse(session.client),
                                                                  completeTasksList: completeTasksList, uncompleteTasksList: uncompleteTasksList,
                                                                  treatmentCode    : treatmentCode,
                                                                  tasksLength      : completeTasksList.tests.size()])
                } else {
                    render(view: '/clinicTask/tasksList', model: [client     : JSON.parse(session.client),
                                                                  tasksList  : tasksListRecord, treatmentCode: treatmentCode,
                                                                  tasksLength: tasksListRecord.size()])
                }
            }
        }
    }

    def validateSectionChoice(sections, answer) {
        def errors = [:]
        answer.each {
            def sectionId = it.sectionId
            if (it.choices.size() < RatchetMessage.choicesLimit[sectionId.toInteger()]) {
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
