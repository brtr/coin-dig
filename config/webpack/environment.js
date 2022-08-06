const { environment } = require('@rails/webpacker');
const webpack = require('webpack');

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default']
  })
)
environment.plugins.prepend('env',
  new webpack.DefinePlugin({
    'NODE_ENV': JSON.stringify(process.env)
  })
)
const devtool = process.env.DEVTOOL;
if (devtool) environment.config.merge({ devtool });

module.exports = environment
