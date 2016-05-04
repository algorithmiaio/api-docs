## Javascript Algorithm Development

#### Available APIs

Algorithmia makes a number of libraries available to make algorithm development easier.
The full <a href="https://nodejs.org/api/">Javascript Node language and standard library</a>
is available for you to use in your algorithms. Furthermore, algorithms can call other algorithms and manage data on the Algorithmia platform
via the <a href="http://developers.algorithmia.com/clients/javascript/">Algorithmia Javascript Client</a>.

#### Managing Dependencies

Algorithmia supports adding 3rd party dependencies via the <a href="https://www.npmjs.com/">NPM Javascript package manager</a> using a package.json file. On the algorithm editor page, click Options and select Manage Dependencies.

Add dependencies by including the package name and version to the `package.json` file.

```
"dependencies": {
	"algorithmia": "0.3.x",
 	"lodash": "4.11.2"
 }
 ```

Note that you will still need to import your package to your algorithm file. For example to include your package async add

`lodash = require("lodash")();`

#### Error Handling

```
var error = "Invalid graph structure"
\// Where cb is a callback function passed into your apply  method
cb(error, input)
```

Algorithms can throw any exception, and they will be returned as an error via the Algorithmia API. If you want to throw a generic exception message, use an `AlgorithmException`.


#### I/O for Your Algorithms

> Handling various data types for your inputs and outputs:

```
exports.apply = function(input, cb) {
    cb(null, "A few of the most starred node.js packages: " + input[0] + ", " + input[1] + ", " + input[2]);
};
```

> Here is an example of an array input:

`["express", "gulp", "async"]`


> Which will return:

`"A few of the most starred node.js packages: express, gulp, async"


Note that you can also return any of these data structures in your algorithm.

#### Calling Other Algorithms and Managing Data

To call other algorithms or manage data from your algorithm, use the [Algorithmia Javascript Client](#javascript-client) which is automatically available to any algorithm you create on the Algorithmia platform.

When designing your algorithm, don't forget that there are special data directories, `.session` and `.algo`, that are available only to algorithms to help you manage data over the course of the algorithm execution.

#### Additional Resources

* <a href="http://developers.algorithmia.com/clients/javascript/">Algorithmia Client Javascript Docs <i class="fa fa-external-link"></i></a>
* <a href="https://nodejs.org/api/">Node.js 6.0 Docs</a>


