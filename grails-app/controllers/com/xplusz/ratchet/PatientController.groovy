package com.xplusz.ratchet

class PatientController extends BaseController{

    def index() {
        render view: "/patient/patientNav"
    }
}
