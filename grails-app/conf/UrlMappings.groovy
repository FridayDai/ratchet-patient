class UrlMappings {

    static mappings = {

        "/"(controller: "authentication", action: "index")

        "/login"(controller: "authentication", action: "login")

        "/home"(controller: 'home', action: "index")

        "/logout"(controller: "authentication") {
            action = [GET: 'logout']
        }

        "/patient"(controller: "patient", action: "index")

        "/task"(controller: "task", action: "index")

        "/taskContent"(controller: "task", action: "getContent")

        "/resultHasAccount"(controller: "task", action:"getResultWithAccount")

        "/resultNoAccount"(controller: "task", action:"getResultWithoutAccount")

        "/account"(controller: "account", action: "index")

        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }

        "403"(view: "/error403")
        "500"(view: "/error")

    }
}
