package com.xplusz.ratchet

/**
 * Created by Brittany on 1/15/15.
 * mock data model for outcome
 */
public class Outcome {
    String question
    String answer_one
    String answer_two
    String answer_three
    String answer_four
    String answer_five

    def Outcome(question, answer_one, answer_two, answer_three, answer_four, answer_five) {
        this.question = question;
        this.answer_one = answer_one;
        this.answer_two = answer_two;
        this.answer_three = answer_three;
        this.answer_four = answer_four;
        this.answer_five = answer_five;
    }
}
