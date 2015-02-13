class UrlMappings {

    static mappings = {
        // Email
        "/patient/email/confirmation/$code"(controller: "email", action: "confirmEmail")
        "/emergency_contact/email/confirmation/$code"(controller: "email", action: "confirmEmail")

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
