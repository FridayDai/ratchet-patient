package com.ratchethealth.patient

import grails.converters.JSON

class MultiTaskController extends TaskController {

    def multiTaskService
    def taskService
    def patientService

    def index() {
        render view: '/multiTask/codeValidation', model: [client: JSON.parse(session.client)]
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
        def resp, allResp

        if (isInClinic) {
            resp = multiTaskService.getTreatmentTasksWithTreatmentCode(token, treatmentCode, null, null, subDomain)
            allResp = multiTaskService.getTreatmentTasksWithTreatmentCode(token, treatmentCode, null, true, subDomain)
        } else {
            resp = multiTaskService.getTreatmentTasksWithCombinedTasksCode(token, treatmentCode, null, null, subDomain)
            allResp = multiTaskService.getTreatmentTasksWithCombinedTasksCode(token, treatmentCode, null, true, subDomain)
        }

        if (resp.status == 200) {
            def tasksListResp = JSON.parse(resp.body)
            def allTasksListResp = JSON.parse(allResp.body)

            def allTaskList = limitFutureTask(allTasksListResp.tests)
            def tasksList = tasksListResp.tests
            def firstName = tasksListResp.firstName
            def emailStatus = tasksListResp.emailStatus
            def patientId = tasksListResp.patientId

            if (allTaskList && tasksList) {
                render view: '/multiTask/tasksList', model: [
                        client          : client,
                        tasksList       : tasksList,
                        allTaskList     : allTaskList,
                        treatmentCode   : treatmentCode,
                        patientFirstName: firstName,
                        emailStatus     : emailStatus,
                        patientId       : patientId,
                        isInClinic      : isInClinic,
                        tasksLength     : tasksList?.size()
                ]
            } else {
                render view: '/multiTask/noActiveTask', model: [
                        client          : client,
                        patientFirstName: firstName,
                        allTaskList     : allTaskList,
                        isInClinic      : isInClinic
                ]
            }
        } else if (isInClinic) {
            if (resp.status == 404) {
                render view: '/multiTask/codeValidation', model: [client: client, errorMsg: RatchetMessage.IN_CLINIC_INCORRECT_TREATMENT_CODE]
            } else if (resp.status == 412) {
                render view: '/multiTask/codeValidation', model: [client: client, errorMsg: RatchetMessage.IN_CLINIC_EXPIRED_TREATMENT_CODE]
            } else {
                render view: '/error/taskExpired', model: [client: client]
            }
        } else {
            taskService.handleError(resp)
        }
    }

    def startTasks() {
        String token = request.session.token
        def tasksList = params.tasksList ? JSON.parse(params?.tasksList) : null
        def itemIndex = params.itemIndex ? params?.int('itemIndex') : 0
        def isInClinic = params?.isInClinic
        def treatmentCode = params?.treatmentCode

        def taskRoute = params?.taskRoute
        def task

        if (taskRoute == "pickTask") {
            task = JSON.parse(params?.task)
        } else {
            task = tasksList[itemIndex]
        }

        def taskCode = task.code
        def taskTitle = task.title

        def resp = getQuestionnaire([
                isInClinic   : isInClinic,
                token        : token,
                treatmentCode: treatmentCode,
                taskCode     : taskCode
        ])

        startTaskHandler(resp, [
                taskCode     : taskCode,
                isInClinic   : isInClinic,
                taskTitle    : taskTitle,
                itemIndex    : itemIndex,
                tasksList    : tasksList,
                treatmentCode: treatmentCode,
                patientId    : params?.patientId,
                emailStatus  : params?.emailStatus,
                taskRoute    : params?.taskRoute
        ])
    }

    def submitTasks() {
        if (params.hardcodeTask) {
            forward(action: "submitSpecialTask", params: [params: params])
            return
        }

        def itemIndex = params?.itemIndex
        def tasksList = params?.tasksList
        def tasksListRecord = tasksList ? JSON.parse(tasksList) : null
        def itemIndexRecord = itemIndex ? itemIndex as int : 0

        def isInClinic = params?.isInClinic
        def treatmentCode = params?.treatmentCode
        def emailStatus = params?.emailStatus
        def patientId = params?.patientId
        def taskTitle = params.taskTitle
        def taskRoute = params?.taskRoute

        submitTaskHandler([
            taskType: params.taskType,
            baseToolType: params.baseToolType,
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

            if(taskRoute == "pickTask") {
                forward(action: "getTreatmentTasks", params: [params: params])
            }
            else if (itemIndexRecord < tasksListRecord?.size()) {
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
        def tasksListRecord = tasksList ? JSON.parse(tasksList) : null
        def itemIndexRecord = itemIndex ? itemIndex as int : 0

        def isInClinic = params?.isInClinic
        def taskRoute = params?.taskRoute

        def treatmentCode = params?.treatmentCode
        def emailStatus = params?.emailStatus
        def choices = params.choices
        def code = params.code

        taskService.submitQuestionnaireWithoutErrorHandle(token, code, [0], choices, null, '')

        if(taskRoute == "pickTask") {
            forward(action: "getTreatmentTasks", params: [params: params])
        }
        else if (itemIndexRecord < tasksListRecord?.size()) {
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

        render(view: '/multiTask/tasksList', model: [
                client        : JSON.parse(session.client),
                tasksCompleted: true,
                doneTaskList  : tasksListRecord,
                treatmentCode : treatmentCode,
                isInClinic    : isInClinic,
                tasksLength   : tasksListRecord?.size()
        ])
    }

    def enterPatientEmail() {
        def tasksList = params?.tasksList
        def treatmentCode = params?.treatmentCode
        def errorMsg = params?.errorMsg
        def isInClinic = params?.isInClinic

        render view: '/multiTask/enterEmail', model: [
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
        def sendTime = params?.sendTime

        multiTaskService.saveDraftAnswer(token, taskId, code, questionId, answerId, complex, sendTime)

        render status: 201
    }

    static private limitFutureTask(allTaskList) {
        def limitNumber = 3
        def limitAccount = 1
        def taskList = []

        for(task in allTaskList) {
            if(RatchetStatusCode.TASK_STATUS[task?.taskStatus] == 'schedule' && limitAccount++ > limitNumber) {
                break
            }
            taskList.add(task)
        }
        return taskList;
    }

}


