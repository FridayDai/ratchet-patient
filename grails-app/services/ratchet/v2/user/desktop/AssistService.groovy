package ratchet.v2.user.desktop

import com.mashape.unirest.http.Unirest
import com.mashape.unirest.http.exceptions.UnirestException
import com.xplusz.ratchet.exceptions.ApiAccessException
import com.xplusz.ratchet.exceptions.ApiReturnException
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import java.text.MessageFormat


class AssistService {
    /** dependency injection for grailsApplication */
    def grailsApplication
    def messageSource

    def addAssist(HttpServletRequest request, HttpServletResponse response, params, session)
            throws ApiAccessException, ApiReturnException {

        def title = params?.title
        def desc = params?.desc
        def browser = params?.browser
        def url = params?.url
        
        def patientId = params?.patientId
        def clientId = session.client.id

        def type = 'Patient'

        String addAssistUrl = grailsApplication.config.ratchetv2.server.url.addAssist
        def formattedUrl = String.format(addAssistUrl, clientId)

        try {
            def resp = Unirest.post(formattedUrl)
                    .field("title", title)
                    .field("desc", desc)
                    .field("browser", browser)
                    .field("patientId", patientId)
                    .field("clientId", clientId)
                    .field("url", url)
                    .field("type", type)
                    .asString()
            def result = JSON.parse(resp.body)

            if (resp.status == 201) {
                def map = [:]
                map.put("status", "ok")
                log.info("Add assist success, token: ${request.session.token}.")
                return map
            } else {
                def message = result?.error?.errorMessage
                throw new ApiReturnException(resp.status, message)
            }
        } catch (UnirestException e) {
            throw new ApiAccessException(e.message)
        }
    }
}
