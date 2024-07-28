const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

// Bootstrap導入で下記追記
  // jQuery導入でも下記追記になる
    // jQueryとjquery記載で大文字でも小文字でも読み込まれる設定
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    jquery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)

module.exports = environment
