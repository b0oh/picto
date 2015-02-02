var React      = require('react'),
    ImageStore = require('../stores/ImageStore');

function getImageListState() {
  return {
    images: ImageStore.getAll()
  };
}

var ImageList = React.createClass({
  getInitialState: function () {
    return getImageListState();
  },

  componentDidMount: function () {
    ImageStore.addChangeListener(this._onChange);
  },

  componentWillUnmount: function () {
    ImageStore.removeChangeListener(this._onChange);
  },

  render: function () {
    return (
      <ul>
        {this.state.images.map(function (image) {
           return (
             <li>
               <img src={image.url} width={image.width} height={image.height} />
               <p>by {image.user.email}</p>
             </li>
           );
        })}
      </ul>
    );
  },

  _onChange: function () {
    this.setState(getImageListState());
  }
});

module.exports = ImageList;
