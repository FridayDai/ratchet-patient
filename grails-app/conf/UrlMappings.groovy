class UrlMappings {

    static mappings = {

        "/"(controller: "task", action: "index")

        "/intro"(controller: "task", action: "index")

        "/task"(controller: "task", action: "getContent")

        "/task/resultHasAccount"(controller: "task", action:"getResultWithAccount")

        "/task/resultNoAccount"(controller: "task", action:"getResultWithoutAccount")

    }
}
