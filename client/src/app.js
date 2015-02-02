var React     = require('react'),
    ConfigApi = require('./api/Config'),
    ImagesApi = require('./api/Images'),
    PictoApp  = require('./components/PictoApp');

ConfigApi.getConfig();
ImagesApi.getImages();

React.render(
  <PictoApp />,
  document.getElementById('content')
);
