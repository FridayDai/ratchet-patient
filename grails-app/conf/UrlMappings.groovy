class UrlMappings {

	static mappings = {



        "/"(controller: "authentication", action: "index")

        "/login"(view:'/authentication/login')

        "/home"(controller: 'home', action: 'index')

        "/logout"(controller: "authentication") {
            action = [GET: 'logout']
        }

        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

//        "/"(view:"/index")
        "500"(view:'/error')

	}
}
