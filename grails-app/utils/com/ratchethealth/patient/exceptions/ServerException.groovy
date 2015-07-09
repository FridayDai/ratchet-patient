package com.ratchethealth.patient.exceptions

class ServerException extends Exception {

    private Integer statusId;

    public ServerException() {
        super();
    }

    public ServerException(String message) {
        super(message);
    }

    public ServerException(String message, Integer status) {
        super(message);
        this.statusId = status;
    }
}
