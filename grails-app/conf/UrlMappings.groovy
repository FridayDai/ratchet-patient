class UrlMappings {

    static mappings = {
        // Email
        "/patient/email/confirmation/$code"(controller: "email", action: "confirmPatientEmail")
        "/emergency_contact/email/confirmation/$code"(controller: "email", action: "confirmEmergencyContactEmail")

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

        // Agreement
        "/terms_of_service"(controller: "agreement", action: "termOfService")
        "/privacy_policy"(controller: "agreement", action: "privacyPolicy")

        // Errors
        "404"(view: '/error/404')
    }
}
