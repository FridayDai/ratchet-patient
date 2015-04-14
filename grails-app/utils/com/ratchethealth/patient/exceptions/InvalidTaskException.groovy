package com.ratchethealth.patient.exceptions

class InvalidTaskException extends Exception {

    public InvalidTaskException() {
        super();
    }

    public InvalidTaskException(String message) {
        super(message);
    }
}
