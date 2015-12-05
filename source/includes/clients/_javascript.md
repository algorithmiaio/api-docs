## Javascript Client

We offer both a vanilla javascript client as well as a nodejs library for calling algorithms in the marketplace.

You can download the javascript client directly from this page:

[https://algorithmia.com/v1/clients/js/algorithmia-0.2.0.js](https://algorithmia.com/v1/clients/js/algorithmia-0.2.0.js)

<aside class="warning">
	The nodejs library is a work in progress and currently has only partial support for the Data API.
</aside>

### Download

You can download our javascript client from:

[https://algorithmia.com/v1/clients/js/algorithmia-0.2.0.js](https://algorithmia.com/v1/clients/js/algorithmia-0.2.0.js)

#### Call an Algorithm

```
<script>
var input = 41;
var client = Algorithmia.client("YOUR_API_KEY");
client.algo("docs/JavaAddOne").pipe(input).then(function(output) {
  if(output.error) return console.error("error: " + output.error);
  console.log(output.result);
});
</script>
```

You can include the javascript file as a script tag:

`<script src="//algorithmia.com/v1/clients/js/algorithmia-0.2.0.js" type="text/javascript"></script>`

To authenticate with the javascript client, simply set your API key with the following:

`var client = Algorithmia.client("YOUR_API_KEY");`

After setting your API key, you can then use the `client` variable from the above line to call algorithms.

The format for calling an algorithm is `client.algo()` with the algorithm name passed in. To pass input to the algorithm, use the `.pipe` method.

`client.algo("demo/Hello").pipe(input)`

### The Algorithmia NPM Package

You can find the npm package documentation on the official [npm page](https://www.npmjs.com/package/algorithmia).

Simply run `npm install --save algorithmia` in your terminal from the project root folder to get started with the npm package!

Alternatively, you can add the package dependency in your package.json file:

`
{
    "dependencies": {
        "algorithmia": "^0.2.1"
    }
}
`

Then run `npm install` from your project root folder.

The package contains a folder called `examples` where you will find more demonstrations.

### Configure the Algorthmia API Key

> API key passed when invoking a script:

```
ALGORITHMIA_API_KEY=YOUR_API_KEY node your-script.js
```

> Place this at the bottom of `.bashrc`, usually located at `~/.bashrc`:

```
export ALGORITHMIA_API_KEY=YOUR_API_KEY
```

There are two ways to use the API key in your scripts. The first way is to simply pass the API key as an argument when you invoke the Node.js script.

In Unix systems, you may define `ALGORITHMIA_API_KEY` as an environment variable. This means you don't have to pass it to the scripts every time.

When you invoke the Node.js scripts, they will be able to access `process.env.ALGORITHMIA_API_KEY` on their own.

### Node.js Usage

```
var algorithmia = require("algorithmia");

var client = algorithmia(process.env.ALGORITHMIA_API_KEY);
var input = "Liz";

client.algo("demo/Hello").pipe(input).then(function(response) {
    if (response.error) {
        console.log(response.error);
    } else {
        console.log(response.get());
    }
});
```

> Partial Data API support:

```
var algorithmia = require("algorithmia");

var client = algorithmia(process.env.ALGORITHMIA_API_KEY);
var content = "Hello!";

client.file("data://.my/Test/foo.txt").putString(content, function(response) {
    if (response.error) {
        console.log(response.error);
    } else {
        console.log(response.result);
    }
});

```

With the Node.js client, you can call any algorithm in the marketplace. Start by requiring the algorithmia package & authenticating as described in the above section.


There is also partial support for some Data API calls with the Node.js package.

You can currently create and read files (strings and JSON) with the methods `putString`, `getString`, `putJson`, and `getJson`.


For more information, check out the [nodejs client source code](https://github.com/algorithmiaio/algorithmia-nodejs).