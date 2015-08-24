class UrlMappings {

    static mappings = {

        "/"(controller: "clinicTestPath", action: "index")

        "/in_clinic"(controller: "clinicTestPath", action: "getTreatmentTasks")

        //Health check
        "/healthcheck"(controller: "healthCheck", action: "index")

        // Email
        "/patient/email/confirmation/$code"(controller: "email", action: "confirmPatientEmail")
        "/emergency_contact/email/confirmation/$code"(controller: "email", action: "confirmEmergencyContactEmail")
        "/mail_setting/$id"(controller: "email") {
            action = [GET: "emailSetting", POST: "emailSettingCheck"]
        }
        "/mail_setting/$id/subscription"(controller: "email") {
            action = [POST: 'subscription']
        }

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

        // Help
        "/patient/assist/$patientId"(controller: "assist", action: "index")
        "/care-giver/assist/$careGiverId"(controller: "assist", action: "assistCareGiver")
        "/addAssist"(controller: "assist", action: "addAssist")

        // Agreement
//        "/terms_of_service"(controller: "agreement", action: "termOfService")
//        "/privacy_policy"(controller: "agreement", action: "privacyPolicy")

        // Announcement
        "/announcement/close"(controller: "announcement", action: "close")

        "404"(view: '/error/404')

    }
}
