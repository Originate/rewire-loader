__check_type__ = (exports) ->
  unless exports? and typeof exports in <[object function]>
    throw Error 'rewire-loader can only be used on modules that export an object or function'


function __set__ var-name, value
  switch
  | not var-name?                => throw Error '__set__: variable name is required'
  | typeof var-name isnt \string => throw Error '__set__: variable name must be a string'
  eval("(function(v){#{var-name}=v})") value


function __get__ var-name
  switch
  | not var-name?                => throw Error '__set__: variable name is required'
  | typeof var-name isnt \string => throw Error '__set__: variable name must be a string'
  eval(var-name)


module.exports = (src) ->
  @cacheable?!

  """
  #{src}

  /* rewire-loader injection */
  (#{__check_type__})(module.exports);
  module.exports.__set__ = #{__set__};
  module.exports.__get__ = #{__get__};
  """
