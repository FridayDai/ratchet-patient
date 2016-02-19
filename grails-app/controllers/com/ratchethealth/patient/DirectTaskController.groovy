package com.ratchethealth.patient

import grails.converters.JSON

class DirectTaskController extends TaskController {

    def index() {
        String token = request.session.token
        def taskCode = params.code

        def patientId = taskService.getPatientInfoByTaskCode(token, taskCode).patientPK
        def resp = taskService.getQuestionnaire(token, null, taskCode)

        startTaskHandler(resp, [
            taskCode: taskCode,
            taskTitle: params.title,
            patientId: patientId
        ])
    }

    def submit() {
        if(params.hardcodeTask) {
            forward(action: "submitSpecialTask", params: [params: params])
            return
        }

        def taskTitle = params.title

        submitTaskHandler([
            token: request.session.token,
            patientId: params.patientId,
            taskTitle: params.title,
            code: params.code,
            taskType: params.taskType,
            choices: params.choices,
            optionals: params.optionals,
            sections: params.sections,
            accountId: params.accountId,
            completeDate: params.completeDate
        ]) { resp ->
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
        def accountId = params?.accountId
        def completeDate = params.completeDate

        taskService.submitQuestionnaireWithoutErrorHandle(token, code, [0], choices, accountId, completeDate)

        render(view: '/clinicTask/tasksList', model: [
            client: JSON.parse(session.client),
            tasksCompleted: true,
            tasksLength   : 1,
            isSingleTask  : true,
            taskTitle     : taskTitle
        ])
    }
}
