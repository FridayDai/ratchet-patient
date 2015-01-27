package com.xplusz.ratchet

class TaskController extends BaseController{

    def index() {
        render view: "/task/intro"
    }

    def getContent() {
        def outcomes = [];
        def outcome_one = new Outcome("1. Do you have swelling in your knee?", "No difficulty", "Mid difficulty", "Moderate difficulty", "Severe difficulty", "Unable");
        def outcome_two = new Outcome("2. Do you feel grinding, hear clicking or any other type of noise when your knee moves?", "No difficulty", "Mid difficulty", "Moderate difficulty", "Severe difficulty", "Unable");
        def outcome_three = new Outcome("3. Does your knee catch or hang up when moving?", "No difficulty", "Mid difficulty", "Moderate difficulty", "Severe difficulty", "Unable");
        def outcome_four = new Outcome("4. Do you have swelling in your knee?", "No difficulty", "Mid difficulty", "Moderate difficulty", "Severe difficulty", "Unable");
        def outcome_five = new Outcome("5. Do you have swelling in your knee?", "No difficulty", "Mid difficulty", "Moderate difficulty", "Severe difficulty", "Unable");
        def outcome_six = new Outcome("6. Do you have swelling in your knee?", "No difficulty", "Mid difficulty", "Moderate difficulty", "Severe difficulty", "Unable");

        outcomes.add(outcome_one);
        outcomes.add(outcome_two);
        outcomes.add(outcome_three);
        outcomes.add(outcome_four);
        outcomes.add(outcome_five);
        outcomes.add(outcome_six);

        render (view: '/task/content',model: [contents:outcomes])
    }

    def getResultWithAccount() {
        render view: "/task/resultWithAccount"
    }

    def getResultWithoutAccount() {
        render view: "/task/resultWithoutAccount"
    }
}
