package com.ratchethealth.patient.commands

@grails.validation.Validateable
class UserCommand {
	String last4Number

	static constraints = {
		last4Number(matches: "[0-9]{4}", blank: false)
	}
}
