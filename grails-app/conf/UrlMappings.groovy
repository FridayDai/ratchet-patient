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

        // Errors
        "404"(view: '/error/404')
    }
}
