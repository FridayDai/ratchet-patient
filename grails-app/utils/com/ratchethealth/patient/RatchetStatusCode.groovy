package com.ratchethealth.patient


class RatchetStatusCode {

    //task optional rules
    public static final Integer[] choicesLimit= [0,0,0,0,0 ,4,5,9,3,2 ,3,5,9,2,2]

    //KOOS and HOOS scores

    public static final Map TASK_OOS_SCORE = [
            "SYMPTOMS": "Symptoms",
            "PAIN": "Pain",
            "ADL": "ADL",
            "SPORT_REC": "Sport/Rec",
            "QOL": "QOL"
    ]

    //patient email status
    public static final String[] emailStatus = ['UNDEFINED', 'UNINVITED', 'INVITED', 'VERIFIED', 'NO_EMAIL', 'BOUNCED']

    //task status
    public static final String[] TASK_STATUS =
            ["undefined", "new", "overdue", "schedule", "pending", "complete", "expired"]
}
