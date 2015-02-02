var AppDispatcher = require('../dispatcher/AppDispatcher'),
    EventEmitter  = require('events').EventEmitter,
    Constants     = require('../constants/ConfigConstants'),
    assign        = require('object-assign');

var _config = {};

function loadConfigData(data) {
  _config = data.config;
}

var ConfigStore = assign({}, EventEmitter.prototype, {
  getConfig: function() {
    return _config;
  },

  emitChange: function() {
    this.emit('change');
  },

  addChangeListener: function(callback) {
    this.on('change', callback);
  },

  removeChangeListener: function(callback) {
    this.removeListener('change', callback);
  }
});

AppDispatcher.register(function(payload) {
  var action = payload.action;
  var text;

  switch(action.actionType) {
    case Constants.RECEIVE_DATA:
      loadConfigData(action.data);
      break;

    default:
      return true;
  }

  ConfigStore.emitChange();

  return true;
});

module.exports = ConfigStore;
