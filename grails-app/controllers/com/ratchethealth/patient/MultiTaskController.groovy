package com.ratchethealth.patient

import grails.converters.JSON

class MultiTaskController extends TaskController {

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
        def client = JSON.parse(session.client)
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
                        client          : client,
                        tasksList       : tasksList,
                        treatmentCode   : treatmentCode,
                        patientFirstName: firstName,
                        emailStatus     : emailStatus,
                        patientId       : patientId,
                        isInClinic      : isInClinic,
                        tasksLength     : tasksList.size()
                ]
            } else {
                render view: '/clinicTask/tasksList', model: [
                        client          : client,
                        patientFirstName: firstName,
                        isInClinic      : isInClinic
                ]
            }
        } else if (isInClinic) {
            if (resp.status == 404) {
                render view: '/clinicTask/codeValidation', model: [client: client, errorMsg: RatchetMessage.IN_CLINIC_INCORRECT_TREATMENT_CODE]
            } else if (resp.status == 412) {
                render view: '/clinicTask/codeValidation', model: [client: client, errorMsg: RatchetMessage.IN_CLINIC_EXPIRED_TREATMENT_CODE]
            } else {
                render view: '/error/taskExpired', model: [client: client]
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

        def task = tasksList[itemIndex]
        def taskCode = task.code

        def resp = getQuestionnaire([
            isInClinic: isInClinic,
            token: token,
            treatmentCode: treatmentCode,
            taskCode: taskCode
        ])

        startTaskHandler(resp, [
            taskCode: taskCode,
            isInClinic: isInClinic,
            taskTitle: task.title,
            itemIndex: itemIndex,
            tasksList: tasksList,
            treatmentCode: treatmentCode,
            patientId: params?.patientId,
            emailStatus: params?.emailStatus
        ])
    }

    def submitTasks() {
        if (params.hardcodeTask) {
            forward(action: "submitSpecialTask", params: [params: params])
            return
        }

        def itemIndex = params?.itemIndex
        def tasksList = params?.tasksList
        def tasksListRecord = JSON.parse(tasksList)
        def itemIndexRecord = itemIndex as int
        def isInClinic = params?.isInClinic
        def treatmentCode = params?.treatmentCode
        def emailStatus = params?.emailStatus
        def patientId = params?.patientId
        def taskTitle = params.taskTitle

        submitTaskHandler([
            taskType: params.taskType,
            code: params.code,
            token: request.session.token,
            itemIndex: itemIndex,
            tasksList: tasksList,
            isInClinic: isInClinic,
            treatmentCode: treatmentCode,
            emailStatus: emailStatus,
            taskTitle: taskTitle,
            choices: params.choices,
            optionals: params.optionals,
            sections: params.sections
        ]) { resp ->
            if (itemIndexRecord < tasksListRecord.size()) {
                forward(action: 'startTasks', params: [
                        itemIndex    : itemIndex,
                        treatmentCode: treatmentCode,
                        tasksList    : tasksList,
                        isInClinic   : isInClinic
                ])
            } else {
                if (isInClinic && RatchetStatusCode.emailStatus[emailStatus.toInteger()] == 'NO_EMAIL') {
                    forward(action: 'enterPatientEmail', params: [
                            patientId    : patientId,
                            treatmentCode: treatmentCode,
                            tasksList    : tasksList,
                            isInClinic   : isInClinic
                    ])
                } else {
                    forward(action: 'completeTasks', params: [
                            treatmentCode: treatmentCode,
                            tasksList    : tasksList,
                            isInClinic   : isInClinic
                    ])
                }
            }
        }
    }

    def getQuestionnaire(opts) {
        if (opts?.isInClinic) {
            return taskService.getQuestionnaire(opts?.token, opts?.treatmentCode, opts?.taskCode)
        } else {
            return taskService.getQuestionnaireWithCombineTaskCode(opts?.token, opts?.treatmentCode, opts?.taskCode)
        }
    }

    def submitQuestionnaire(opts) {
        return taskService.submitQuestionnaireWithoutErrorHandle(opts?.token, opts?.code, opts?.answer, null, null, '')
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

        taskService.submitQuestionnaireWithoutErrorHandle(token, code, [0], choices, null, '')
        if (itemIndexRecord < tasksListRecord.size()) {
            forward(action: 'startTasks', params: [
                    itemIndex    : itemIndex,
                    treatmentCode: treatmentCode,
                    tasksList    : tasksList,
                    isInClinic   : isInClinic
            ])
        } else {
            if (isInClinic && RatchetStatusCode.emailStatus[emailStatus.toInteger()] == 'NO_EMAIL') {
                forward(action: 'enterPatientEmail', params: [
                        treatmentCode: treatmentCode,
                        tasksList    : tasksList,
                        isInClinic   : isInClinic
                ])
            } else {
                forward(action: 'completeTasks', params: [
                        treatmentCode: treatmentCode,
                        tasksList    : tasksList,
                        isInClinic   : isInClinic
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
                client        : JSON.parse(session.client),
                tasksCompleted: true,
                doneTaskList  : tasksListRecord,
                treatmentCode : treatmentCode,
                isInClinic    : isInClinic,
                tasksLength   : tasksListRecord.size()
        ])
    }

    def enterPatientEmail() {
        def tasksList = params?.tasksList
        def treatmentCode = params?.treatmentCode
        def errorMsg = params?.errorMsg
        def isInClinic = params?.isInClinic

        render view: '/clinicTask/enterEmail', model: [
                client       : JSON.parse(session.client),
                treatmentCode: treatmentCode,
                tasksList    : tasksList,
                isInClinic   : isInClinic,
                errorMsg     : errorMsg
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
                    tasksList    : tasksList,
                    isInClinic   : isInClinic,
                    errorMsg     : result?.error?.errorMessage
            ])
        } else {
            forward(action: 'completeTasks', params: [
                    treatmentCode: treatmentCode,
                    isInClinic   : isInClinic,
                    tasksList    : tasksList
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

}


