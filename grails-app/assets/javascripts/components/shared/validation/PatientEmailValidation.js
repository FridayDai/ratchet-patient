require('../../../libs/jquery.validate.js');

var STRINGs = require('../../../constants/Strings');
var URLs = require('../../../constants/Urls');

module.exports = {
    get: function () {
        return {
            rules: {
                email: {
                    email: true,
                    remote: {
                        url: URLs.CHECK_PATIENT_EMAIL,
                        dropProcess: true,
                        dataFilter: function (responseString) {
                            if (responseString === "false") {
                                return "\"" + STRINGs.EMAIL_EXISTING_INVALID + "\"";
                            } else {
                                return '"true"';
                            }
                        }
                    }
                }
            }
        };
    }
};
