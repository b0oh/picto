var AppDispatcher = require('../dispatcher/AppDispatcher'),
    Constants     = require('../constants/ImageConstants');

module.exports = {
  receiveImages: function(data) {
    AppDispatcher.handleAction({
      actionType: Constants.RECEIVE_DATA,
      data: data
    });
  }
};
