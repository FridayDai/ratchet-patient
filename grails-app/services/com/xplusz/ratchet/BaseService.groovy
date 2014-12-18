package com.xplusz.ratchet

import com.mashape.unirest.http.Unirest


class BaseService {

    /** dependency injection for grailsApplication */
    def grailsApplication

    /**
     * Check if the sessionId in local was matched with session that stored in the ratchet-v2-server.
     * @param sessionId in local.
     *
     */
    def validateSession(sessionId) {

        def url = grailsApplication.config.ratchetv2.server.validateSessionId.url
        def resp = Unirest.get(url)
                .queryString("sessionId", "${sessionId}")
                .asString()

        if (resp?.status == 200) {
            return true
        } else {
            return false
        }
    }

}
