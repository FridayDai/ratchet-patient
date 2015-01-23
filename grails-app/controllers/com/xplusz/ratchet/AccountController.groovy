package com.xplusz.ratchet

class AccountController extends BaseController{

    def index() {
        render view: "/authentication/account"
    }
}
