package com.ratchethealth.patient.exceptions

class ApiAccessException extends Exception {

    public ApiAccessException() {
        super();
    }

    public ApiAccessException(String message) {
        super(message);
    }
}
