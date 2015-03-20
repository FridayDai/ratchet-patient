class UrlMappings {

    static mappings = {

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
        "/$patientName/tasks/$taskTitle/$code"(controller: "task") {
            action = [GET: "index"]
        }
        "/$patientName/tasks/$taskTitle/$code/start"(controller: "task") {
            action = [GET:"index", POST: "start"]
        }
        "/$patientName/tasks/$taskTitle/$code/complete"(controller: "task") {
            action = [GET: "hasComplete", POST: "done"]
        }

        // Help
        "/assist/$patientId"(controller: "assist", action: "index")
        "/addAssist"(controller: "assist", action: "addAssist")

        // Agreement
//        "/terms_of_service"(controller: "agreement", action: "termOfService")
//        "/privacy_policy"(controller: "agreement", action: "privacyPolicy")

        // Announcement
        "/announcement/close"(controller: "announcement", action: "close")

        "404"(view: '/error/404')
    }
}
