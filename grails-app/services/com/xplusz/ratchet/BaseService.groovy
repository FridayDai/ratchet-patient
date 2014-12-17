package com.xplusz.ratchet

import com.mashape.unirest.http.Unirest


class BaseService {

    def grailsApplication

    def validateSession(sessionId) {
        def url = grailsApplication.config.ratchetv2.server.validateSessionId.url
        return  Unirest.get(url)
                .queryString("sessionId", "${sessionId}")
                .asString()
    }

}
