package com.ratchethealth.patient

class RatchetConstants {
    enum ToolEnum {
        DASH(1),
        ODI(2),
        NDI(3),
        NRS_BACK(4),
        NRS_NECK(5),
        QUICK_DASH(6),
        KOOS(7),
        HOOS(8),
        HARRIS_HIP_SCORE(9),
        FAIRLEY_NASAL_SYMPTOM(10),
        PAIN_CHART_REFERENCE_NECK(11),
        PAIN_CHART_REFERENCE_BACK(12),
        NEW_PATIENT_QUESTIONNAIRE(13),
        PROMIS(14),
        RETURN_PATIENT_QUESTIONNAIRE(17),
        KOOS_JR(15),
        HOOS_JR(1000),
        RISK_ASSESSMENT_QUESTIONNAIRE(20),
        SURGERY_FOLLOW_UP(21)

        int value

        ToolEnum(int value) {
            this.value = value
        }
    }

    enum questionnaireTypeEnum {
        ALL(1),
        COMPLETED(2),
        ACTIVE(3)

        int value

        questionnaireTypeEnum(int value) {
            this.value = value
        }
    }

    enum taskStatusEnum {
        NEW(1),
        OVERDUE(2),
        SCHEDULE(3),
        PENDING(4),
        COMPLETE(5),
        EXPIRED(6)

        int value

        taskStatusEnum(int value) {
            this.value = value
        }
    }
}
