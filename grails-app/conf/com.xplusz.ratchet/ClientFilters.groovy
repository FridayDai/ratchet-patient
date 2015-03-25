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

                        forward(controller: 'error', action: 'notFound')
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
