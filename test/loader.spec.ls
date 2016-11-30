{expect} = require 'chai'


describe 'rewire-loader' ->

  specify 'each require call returns a unique module' ->
    a = require('..!./fixtures/array')
    b = require('..!./fixtures/array')
    expect(a).to.not.equal b
