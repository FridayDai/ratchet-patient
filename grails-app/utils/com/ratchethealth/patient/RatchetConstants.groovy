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
        RETURN_PATIENT_QUESTIONNAIRE(17)

        int value

        ToolEnum(int value) {
            this.value = value
        }
    }
}
