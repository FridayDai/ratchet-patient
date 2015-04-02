package com.ratchethealth.patient

class ClientFilters {

    def clientService

    def filters = {
        all(controller: 'email|task|agreement|assist') {
            before = {
                log.info("${request.requestURI}, ip: ${request.getRemoteAddr()}")
                if (!session.client) {
                    def hostname = request.getServerName()

                    def clientName = hostname.replaceAll(/\.?(x|qa|stable)?\.ratchethealth\.com$/, '')

                    try {
                        def result = clientService.getClient(request, response, clientName)
                        if (result) {
                            log.info("Client found, Server Name: ${request.getServerName()}, Client Domain: ${clientName}")

                            session.client = result
                        }
                    } catch (Exception e) {
                        log.error("Client not found, " +
                                "Server Name: ${request.getServerName()}, " +
                                "Client Domain: ${clientName} \n" +
                                "Message: ${e.message} \n" +
                                "Exception trace: \n${e.stackTrace}"
                        )

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
