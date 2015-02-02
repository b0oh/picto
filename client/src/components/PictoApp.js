var React     = require('react'),
    Header    = require('./Header'),
    ImageList = require('./ImageList');

var PictoApp = React.createClass({
  render: function () {
    return (
      <div>
        <Header />
        <ImageList />
      </div>
    );
  },
});

module.exports = PictoApp;
