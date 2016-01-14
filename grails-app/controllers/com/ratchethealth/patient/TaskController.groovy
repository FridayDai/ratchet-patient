package com.ratchethealth.patient

import grails.converters.JSON

class TaskController extends BaseController {
    def taskService

    def startTaskHandler(resp, opts) {
        def draft = null

<<<<<<< HEAD
        if (resp.status == 200) {
            def result = JSON.parse(resp.body)
            def questionnaireView = ''

            switch (result.type) {
                case RatchetConstants.ToolEnum.DASH.value:
                case RatchetConstants.ToolEnum.QUICK_DASH.value:
                case RatchetConstants.ToolEnum.FAIRLEY_NASAL_SYMPTOM.value:
                    questionnaireView = '/task/content/dash'
                    break

                case RatchetConstants.ToolEnum.ODI.value:
                case RatchetConstants.ToolEnum.NDI.value:
                    questionnaireView = '/task/content/odi'
                    break

                case RatchetConstants.ToolEnum.NRS_BACK.value:
                case RatchetConstants.ToolEnum.NRS_NECK.value:
                    questionnaireView = '/task/content/nrs'
                    break

                case RatchetConstants.ToolEnum.KOOS.value:
                case RatchetConstants.ToolEnum.HOOS.value:
                case RatchetConstants.ToolEnum.KOOS_JR.value:
                case RatchetConstants.ToolEnum.HOOS_JR.value:
                    questionnaireView = '/task/content/koos'
                    break

                case RatchetConstants.ToolEnum.HARRIS_HIP_SCORE.value:
                    questionnaireView = '/task/content/verticalChoice'
                    break

            //TODO merger odi to verticalChoice template after api portal gives the same format data in all tasks.
                case RatchetConstants.ToolEnum.PAIN_CHART_REFERENCE_NECK.value:
                    questionnaireView = '/task/content/painChartNeck'
                    break

                case RatchetConstants.ToolEnum.PAIN_CHART_REFERENCE_BACK.value:
                    questionnaireView = '/task/content/painChartBack'
                    break

                case RatchetConstants.ToolEnum.NEW_PATIENT_QUESTIONNAIRE.value:
                    questionnaireView = '/task/content/newPatientQuestionnaire'
                    break

                case RatchetConstants.ToolEnum.RETURN_PATIENT_QUESTIONNAIRE.value:
                    questionnaireView = '/task/content/returnPatientQuestionnaire'
                    break
            }

            if (result.draft) {
                draft = JSON.parse(JSON.parse(result.draft).yourData)
            }

            session["questionnaireView${opts?.taskCode}"] = questionnaireView

            render view: questionnaireView,
                    model: [
                            client     : JSON.parse(session.client),
                            isInClinic : opts?.isInClinic,
                            Task       : result,
                            Draft      : draft,
                            taskTitle  : opts?.taskTitle,
                            taskCode   : opts?.taskCode,
                            itemIndex  : opts?.itemIndex,
                            tasksList  : opts?.tasksList,
                            treatmentCode: opts?.treatmentCode,
                            tasksLength: opts?.tasksList?.size(),
                            patientId  : opts?.patientId,
                            emailStatus: opts?.emailStatus
                    ]
        } else if (resp.status == 404) {
            render view: '/error/invalidTask', model: [client: JSON.parse(session.client)], status: 404
=======
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

                render view: questionnaireView, model: [
                        Task     : result,
                        client   : JSON.parse(session.client),
                        taskTitle: taskTitle,
                        taskCode : code,
                        Draft    : draft
                ]
            }
>>>>>>> 84d154955c95344e43a94d6388fb3e0d8ecb25ff
        }
    }

    def submitTaskHandler(opts, Closure successHandler) {
        def taskType = opts?.taskType as int
        def itemIndex = opts?.itemIndex ? opts?.itemIndex as int : 0
        def code = opts?.code
        def choices = opts?.choices
        def optionals = opts?.optionals
        def sections = opts?.sections
        def tasksList = opts?.tasksList
        def tasksListRecord = tasksList ? JSON.parse(tasksList) : null
        def answer = [], errors

        if (sections) {
            sections.each { key, String[] value ->
                def section = [:]
                def options = [:]
                value.each {
                    if (choices) {
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
        if (taskType == RatchetConstants.ToolEnum.ODI.value ||
            taskType == RatchetConstants.ToolEnum.NDI.value ||
            taskType == RatchetConstants.ToolEnum.KOOS.value ||
            taskType == RatchetConstants.ToolEnum.HOOS.value) {
            errors = [];
        } else {
            errors = validateChoice(taskType, choices, optionals)
        }

        if (errors.size() > 0) {
            def view = session["questionnaireView${code}"]

            def resp = getQuestionnaire(opts)

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)

                render view: view,
                    model: [
                        client       : JSON.parse(session?.client),
                        isInClinic   : opts?.isInClinic,
                        Task         : result,
                        taskTitle    : opts?.taskTitle,
                        taskCode     : code,
                        choices      : choices,
                        itemIndex    : (itemIndex - 1),
                        tasksList    : tasksListRecord,
                        treatmentCode: opts?.treatmentCode,
                        tasksLength  : tasksListRecord?.size(),
                        errors       : errors,
                        emailStatus  : opts?.emailStatus
                    ]
            }
        } else {
            answer.each {
                it.choices = convertChoice(taskType, it.choices)
            }

            opts.answer = answer

            def resp = submitQuestionnaire(opts)

            successHandler.call(resp)
        }
    }

    def getQuestionnaire(opts) {
        return taskService.getQuestionnaire(opts?.token, opts?.treatmentCode, opts?.code)
    }

    def submitQuestionnaire(opts) {
        return taskService.submitQuestionnaire(opts?.token, opts?.code, opts?.answer, opts?.accountId)
    }

    def convertChoice(type, choices) {
        if (type == RatchetConstants.ToolEnum.NRS_BACK.value ||
            type == RatchetConstants.ToolEnum.NRS_NECK.value) {
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

    def validateChoice(type, choices, optionals) {
        def errors = [:]

        if (type == RatchetConstants.ToolEnum.NRS_BACK.value) {
            // 4.NRS-BACK
            if (choices?.back == null) {
                errors[0] = 1
            }
            if (choices?.leg == null) {
                errors[1] = 1
            }
        } else if (type == RatchetConstants.ToolEnum.NRS_NECK.value) {
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
}
