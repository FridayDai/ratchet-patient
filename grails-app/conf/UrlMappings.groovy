class UrlMappings {

    static mappings = {

        "/in-clinic"(controller: "multiTask") {
            action = [GET: "index", POST: "checkPath"]
        }

        //Health check
        "/healthcheck"(controller: "healthCheck", action: "index")

        // Email
        "/patient/email/confirmation/$code"(controller: "email", action: "confirmPatientEmail")
        "/emergency_contact/email/confirmation/$code"(controller: "email", action: "confirmEmergencyContactEmail")

        "/patients/check-email"(controller: "email", action: "checkPatientEmailExist")

        // Task
        name taskIndex: "/$patientName/tasks/$taskTitle/$code"(controller: "task") {
            action = [GET: "index", POST: "phoneNumberValidate"]
        }
        name taskStart: "/$patientName/tasks/$taskTitle/$code/start"(controller: "task") {
            action = [GET: "start", POST: "submit"]
        }
        name taskComplete: "/$patientName/tasks/$taskTitle/$code/complete"(controller: "task") {
            action = [GET: "complete"]
        }

        "/tasks/$treatmentCode"(controller: "multiTask") {
            action = [GET: "getTreatmentTasks", POST: "checkPath"]
        }

        "/tasks/$taskId/save-draft-answer"(controller: "multiTask") {
            action = [POST: "saveDraftAnswer"]
        }

        //SingleTask
        "/$accountId/tasks/$title/$code"(controller: "singleTask") {
            action = [GET: "singleTask", POST: "submitSingleTask"]
        }
     /*   //SingleTask
        "/$accountId/tasks/$title/$code"(controller: "task", action: "index")*/


        // Help
        "/patient/assist/$patientId"(controller: "assist", action: "index")
        "/care-giver/assist/$careGiverId"(controller: "assist", action: "assistCareGiver")
        "/addAssist"(controller: "assist", action: "addAssist")

        // Announcement
        "/announcement/close"(controller: "announcement", action: "close")

        "404"(view: '/error/404')

    }
}
