class UrlMappings {

    static mappings = {
        // Email
        "/patient/email/confirmation/$code"(controller: "email", action: "confirmPatientEmail")
        "/emergency_contact/email/confirmation/$code"(controller: "email", action: "confirmEmergencyContactEmail")

        // Task
        "/$patientName/tasks/$taskTitle/$code"(controller: "task") {
            action = [GET: "index", POST: "start"]
        }
        "/$patientName/tasks/$taskTitle/complete"(controller: "task") {
            action = [POST: "done"]
        }

        // Errors
        "404"(view: '/error/404')
    }
}
