node-externals = require 'webpack-node-externals'


module.exports =

  target: \node


  externals: [
    node-externals!
  ]


  resolve: extensions: [
    ''
    '.ls'
    '.js'
  ]


  module: loaders: [
    * test: /\.ls$/
      loader: \livescript
  ]
