function ValidationHandlers() {
    this.checkTextareaValid = this.checkTextValid = function ($item) {
        if (!!$item.val()) {
            return true;
        } else {
            $item
                .addClass('error-field')
                .closest('.error-notice-field')
                .addClass('error-field');
            return false;
        }
    };

    this.checkRadioValid = function ($item) {
        if ($item.filter(':checked').length > 0) {
            return true;
        } else {
            $item
                .next()
                .addClass('error-field')
                .closest('.error-notice-field')
                .addClass('error-field');
            return false;
        }
    };

    this.checkSelectValid = function ($item) {
        if (!$item.data('isDefault')) {
            return true;
        } else {
            $item
                .selectmenu('widget')
                .addClass('error-field')
                .closest('.error-notice-field')
                .addClass('error-field');
            return false;
        }
    };

    this.checkMultipleDateValid = function ($item) {
        if (!!$item.val()) {
            return true;
        } else {
            $item
                .parent()
                .find('.multi-date-container')
                .addClass('error-field');
            return false;
        }
    };

    this.clearTextareaError = this.clearTextError = function ($item) {
        $item
            .removeClass('error-field')
            .closest('.error-notice-field')
            .removeClass('error-field');
    };

    this.clearRadioError = function ($item) {
        $item
            .next()
            .removeClass('error-field')
            .closest('.error-notice-field')
            .removeClass('error-field');
    };

    this.clearSelectError = function ($item) {
        $item
            .selectmenu('widget')
            .removeClass('error-field')
            .closest('.error-notice-field')
            .removeClass('error-field');
    };

    this.clearMultipleDateError = function ($item) {
        $item
            .parent()
            .find('.multi-date-container')
            .removeClass('error-field');
    };
}

module.exports = ValidationHandlers;
