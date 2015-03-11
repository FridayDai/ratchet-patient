package com.xplusz.ratchet

class ClientFilters {

    def clientService

    def filters = {
        all(controller: 'email|task|agreement') {
            before = {
                log.info("${request.requestURI} params: ${params}, session: ${session.token}, ip: ${request.getRemoteAddr()}")
                if (!session.client) {
                    def hostname = request.getServerName()

                    def clientName = hostname.replaceAll(/\.(qa|stable)?\.ratchethealth\.com$/, '')

                    def result = clientService.getClient(request, response, clientName)

                    if (!(result instanceof Integer)) {
                        session.client = result
                    } else {
                        render view: '/error/404', status: 404
                        return false
                    }
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
