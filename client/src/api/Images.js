var $            = require('jquery'),
    ImageActions = require('../actions/ImageActions');

module.exports = {
  getImages: function () {
    $.getJSON('/api/images').done(ImageActions.receiveImages);
  }
};
