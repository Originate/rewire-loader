{expect} = require 'chai'


describe '__set__' ->

  describe 'modules that export supported types' ->

    <[array function object]>.for-each (type) -> context type, ->

      before-each ->
        @module = require "..!./fixtures/#{type}"
        @get-updated-value = switch type
        | \array    => @module[0]
        | \function => @module
        | \object   => @module.get-value

      specify 'adds a __set__ method to the object' ->
        expect(@module.__set__).to.be.a \function

      specify 'calling __set__ without a variable name throws an error' ->
        expect(~> @module.__set__!).to.throw /variable name is required/

      specify 'calling __set__ with a bad variable name type throws an error' ->
        expect(~> @module.__set__ {}).to.throw /variable name must be a string/

      specify 'setting an object gets the exact object back out' ->
        injected = {}
        @module.__set__ 'foo' injected
        expect(@get-updated-value!).to.equal injected


  describe 'modules that export unsupported types' ->

    <[null number undefined]>.for-each (type) -> context type, ->

      specify 'throws an error' ->
        expect ->
          require "..?set-cache-bust!./fixtures/#{type}"
        .to.throw /rewire-loader can only be used on modules that export an object or function/
