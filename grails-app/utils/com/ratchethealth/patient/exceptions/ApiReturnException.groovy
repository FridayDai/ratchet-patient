package com.ratchethealth.patient.exceptions

class ApiReturnException extends Exception {

    private Integer statusId;

    public ApiReturnException() {
        super();
    }

    public ApiReturnException(String message) {
        super(message);
    }

    public ApiReturnException(String message, Integer status) {
        super(message);
        this.statusId = status;
    }
}
