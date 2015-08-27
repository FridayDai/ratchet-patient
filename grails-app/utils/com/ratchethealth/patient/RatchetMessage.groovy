package com.ratchethealth.patient

class RatchetMessage {
	// Task
	public static final TASK_INTRO_WRONG_PHONE_NUMBER = "The number you entered is incorrect.";
	public static final TASK_INTRO_INVALID_PHONE_NUMBER = "Invalid input.";
	public static final IN_CLINIC_INCORRECT_TREATMENT_CODE = "The treatment code you entered is incorrect."
	
    //task optional rules
    public static final Integer[] choicesLimit= [0,0,0,0,0 ,4,5,9,3,2 ,3,5,9,2,2]

    //KOOS and HOOS scores

    public static final String[] scoreNames = ["Symptoms", "Pain", "ADL", "Sport/Rec", "QOL"]


}
