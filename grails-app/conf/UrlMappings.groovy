class UrlMappings {

    static mappings = {

        "/"(controller: "task", action: "index")

        "/intro"(controller: "task", action: "index")

        "/task"(controller: "task", action: "getContent")

        "/task/result"(controller: "task", action:"getResult")
    }
}
