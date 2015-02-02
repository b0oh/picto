var React       = require('react'),
    ConfigStore = require('../stores/ConfigStore');

function getHeaderState() {
  return {
    mail: ConfigStore.getConfig().mail
  };
}

var Header = React.createClass({
  getInitialState: function () {
    return getHeaderState();
  },

  componentDidMount: function () {
    ConfigStore.addChangeListener(this._onChange);
  },

  componentWillUnmount: function () {
    ConfigStore.removeChangeListener(this._onChange);
  },

  render: function () {
    return (
      <header>
        <h1>Picto</h1>
        <p>Send <a href={'mailto:' + this.state.mail}>me</a> your pics</p>
      </header>
    );
  },

  _onChange: function () {
    this.setState(getHeaderState());
  }
});

module.exports = Header;
