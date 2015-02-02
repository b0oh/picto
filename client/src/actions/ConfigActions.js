var AppDispatcher = require('../dispatcher/AppDispatcher'),
    Constants     = require('../constants/ConfigConstants');

module.exports = {
  receiveConfig: function(data) {
    AppDispatcher.handleAction({
      actionType: Constants.RECEIVE_DATA,
      data: data
    });
  }
};
