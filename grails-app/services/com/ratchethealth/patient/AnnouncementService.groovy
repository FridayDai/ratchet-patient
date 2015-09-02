package com.ratchethealth.patient

import grails.converters.JSON
import grails.plugin.cache.Cacheable

class AnnouncementService extends RatchetAPIService {

    def grailsApplication

    @Cacheable('announcement')
    def checkAnnouncement() {
        String announcementsUrl = grailsApplication.config.ratchetv2.server.url.announcements

        withGet(announcementsUrl) { req ->
            def resp = req
                    .queryString("latest", true)
                    .asString()

            if (resp.status == 200) {
                def result = JSON.parse(resp.body)
                log.info("Get announcement success")
                result?.items[0];
            } else {
                handleError(resp)
            }
        }
    }
}
