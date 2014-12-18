class UrlMappings {

    static mappings = {

        "/"(controller: "authentication", action: "index")

        "/login"(controller: "authentication", action: "login")

        "/home"(controller: 'home', action: 'index')

        "/logout"(controller: "authentication") {
            action = [GET: 'logout']
        }

        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }

//        "/"(view:"/index")
        "403"(view: "/error403")
        "500"(view: '/error')

    }
}
