# rewire-loader

Adds [rewire](https://github.com/jhnns/rewire)-like bindings to a webpack loader. Works well with [mocha-webpack](https://github.com/zinserjan/mocha-webpack)


## Usage
Suppose you have a `module.js` file with the content:
```javascript
const SOME_CONSTANT = 15;
var someDependency = require('some-dependency');

module.exports = function() {
  return someDependency();
};
```

You can stub out your dependencies with `__set__`
```javascript
myModule = require('rewire!./module.js');
myModule.__set__('someDependency', mockDependency);
myModule(); // returns mockDependency
```

You can also get values with `__get__`
```javascript
myModule = require('rewire!./module.js');
myModule.__get__('SOME_CONSTANT'); // returns 15
```
