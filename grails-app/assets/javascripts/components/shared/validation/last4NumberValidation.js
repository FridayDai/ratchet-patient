require('../../../libs/jquery-validation/jquery.validate.js');

var STRINGs = require('../../../constants/Strings');

module.exports = {
    get: function () {
        return {
            rules: {
                last4Number: {
                    number: true
                }
            },
            messages: {
                last4Number: {
                    number: STRINGs.phoneNumberTypeError
                }
            }
        };
    }
};
