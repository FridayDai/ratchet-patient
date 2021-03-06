class UrlMappings {

    static mappings = {

        "/in-clinic"(controller: "multiTask") {
            action = [GET: "index", POST: "checkPath"]
        }

        //Health check
        "/healthcheck"(controller: "healthCheck", action: "index")

        // Email
        "/patient/email/confirmation/$code"(controller: "email") {
            action = [GET: "confirmPatientEmail", POST: "agreePolicyAndConfirmPatient"]
        }

        "/caregiver/email/confirmation/$code"(controller: "email") {
            action = [GET: "confirmCareGiverEmail", POST: "agreePolicyAndConfirmCareGiver"]
        }

        //Todo: This should be deleted later
        "/emergency_contact/email/confirmation/$code"(controller: "email") {
            action = [GET: "confirmCareGiverEmail", POST: "agreePolicyAndConfirmCareGiver"]
        }

        "/patients/check-email"(controller: "email", action: "checkPatientEmailExist")

        "/tasks/$combinedTasksCode"(controller: "multiTask") {
            action = [GET: "getTasksByEmail", POST: "checkPath"]
        }

        "/tasks/$taskId/save-draft-answer"(controller: "multiTask") {
            action = [POST: "saveDraftAnswer"]
        }

        "/patient/$patientId/unsubscribe/$code"(controller: "email", action: "unsubscribeEmail")

        "/patients/$patientId/caregivers/$careGiverId/unsubscribe/$code"(controller: "email", action: "unsubscribeCaregiverEmail")

        // Direct task
        "/$accountId/tasks/$title/$code"(controller: "directTask") {
            action = [GET: "index", POST: "submit"]
        }

        // Help
        "/patient/assist/$patientId"(controller: "assist", action: "index")
        "/caregiver/assist/$careGiverId"(controller: "assist", action: "assistCareGiver")

        //Todo: This should be deleted later
        "/care-giver/assist/$careGiverId"(controller: "assist", action: "assistCareGiver")

        "/addAssist"(controller: "assist", action: "addAssist")

        // Announcement
        "/announcement/close"(controller: "announcement", action: "close")

        "404"(view: '/error/404')

        "/robots.txt" (view: "/robots")
        "/sitemap.xml" (view: "/sitemap")
    }
}
