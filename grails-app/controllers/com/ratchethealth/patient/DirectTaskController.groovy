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
            patientId: patientId,
            isInClinic: true
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
            baseToolType: params.baseToolType,
            choices: params.choices,
            optionals: params.optionals,
            sections: params.sections,
            accountId: params.accountId,
            completeDate: params.completeDate,
            isInClinic: true
        ]) { resp ->
            if (resp.status == 200 || resp.status == 207) {
                render(view: '/multiTask/tasksList', model: [
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

        taskService.submitQuestionnaireWithoutErrorHandle(token, code, [0], choices, accountId, completeDate, RatchetConstants.TaskSourceFromEnum.MA.value)

        render(view: '/multiTask/tasksList', model: [
            client: JSON.parse(session.client),
            tasksCompleted: true,
            tasksLength   : 1,
            isSingleTask  : true,
            taskTitle     : taskTitle
        ])
    }
}
