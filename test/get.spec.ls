{expect} = require 'chai'


describe '__get__' ->

  describe 'modules that export supported types' ->

    <[array function object]>.for-each (type) -> context type, ->

      before-each ->
        @module = require "..!./fixtures/#{type}"
        @get-updated-value = switch type
        | \array    => @module[0]
        | \function => @module
        | \object   => @module.get-value

      specify 'adds a __get__ method to the object' ->
        expect(@module.__get__).to.be.a \function

      specify 'calling __get__ without a variable name throws an error' ->
        expect(~> @module.__get__!).to.throw /variable name is required/

      specify 'calling __get__ with a bad variable name type throws an error' ->
        expect(~> @module.__get__ {}).to.throw /variable name must be a string/

      specify 'getting an original value' ->
        expect(@module.__get__ 'foo').to.equal 'original value'

      specify 'getting an overridden value' ->
        @module.__set__ 'foo' 'new value'
        expect(@module.__get__ 'foo').to.equal 'new value'


  describe 'modules that export unsupported types' ->

    <[null number undefined]>.for-each (type) -> context type, ->

      specify 'throws an error' ->
        expect ->
          require "..?get-cache-bust!./fixtures/#{type}"
        .to.throw /rewire-loader can only be used on modules that export an object or function/
