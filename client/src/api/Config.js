var $             = require('jquery'),
    ConfigActions = require('../actions/ConfigActions');

module.exports = {
  getConfig: function () {
    $.getJSON('/api/config').done(ConfigActions.receiveConfig);
  }
};
