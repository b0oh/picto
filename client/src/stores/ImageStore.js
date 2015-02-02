var AppDispatcher = require('../dispatcher/AppDispatcher'),
    EventEmitter  = require('events').EventEmitter,
    Constants     = require('../constants/ImageConstants'),
    assign        = require('object-assign');

var _images = [];

function loadImagesData(data) {
  _images = data.images;
}

var ImageStore = assign({}, EventEmitter.prototype, {
  getAll: function() {
    return _images;
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
      loadImagesData(action.data);
      break;

    default:
      return true;
  }

  ImageStore.emitChange();

  return true;
});

module.exports = ImageStore;
