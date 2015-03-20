package com.xplusz.ratchet

class ClientFilters {

    def clientService

    def filters = {
        all(controller: 'email|task|agreement') {
            before = {
                log.info("${request.requestURI} params: ${params}, ip: ${request.getRemoteAddr()}")
                if (!session.client) {
                    def hostname = request.getServerName()

                    def clientName = hostname.replaceAll(/\.(x|qa|stable)?\.ratchethealth\.com$/, '')

                    try {
                        def result = clientService.getClient(request, response, clientName)
                        if (result) {
							log.info("Client found, Server Name: ${request.getServerName()}")

                            session.client = result
                        }
                    } catch (Exception e) {
                        log.error("Client not found, Server Name: ${request.getServerName()}")

                        if (request.isXhr()) {
                            render status: 404, text: e.message
                        } else {
                            render view: '/error/404', status: 404
                        }
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
