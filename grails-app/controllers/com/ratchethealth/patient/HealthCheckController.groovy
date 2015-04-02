package com.ratchethealth.patient

class HealthCheckController {

    def index() {
            render status: 200, text: "OK"
    }
}
