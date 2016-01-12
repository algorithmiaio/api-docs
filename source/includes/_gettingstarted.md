# Getting Started

This is a quick guide to get you started using the Algorithmia API. We'll walk through how to get started with an algorithm and make your first API call.

You can follow this guide immediately by making a call on the command line via cURL. You'll find example calls on the right side pane. If you'd like to get up and running with another language, check out our [client guides](#clients) for instructions on how to install a language-specific client.

## Finding an Algorithm

To get started, find an algorithm you'd like to call. You can do this by using the search bar or browsing the marketplace by tags & categories. Each algorithm has an owner and an algorithm name; you'll need both to format your request. This information is listed under the algorithm name on the description page as well as in the format of the algorithm's URL.

For a given user and algorithm name, API calls are made to the following URL:

`POST https://api.algorithmia.com/v1/algo/:owner/:algoname`

<aside class="success">
We recommend that you also append the algorithm version in your API call to ensure that the correct algorithm is called.
</aside>

## Making your first API call

```shell
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -d 'YOUR_NAME' -H 'Content-Type: text/plain' \
    https://api.algorithmia.com/v1/algo/demo/Hello/0.1.1
```

```python
# Install algorithmia from PyPi via:
#   pip install algorithmia

import Algorithmia

input = "YOUR_NAME"
client = Algorithmia.client('YOUR_API_KEY')
algo = client.algo('demo/Hello/0.1.1')
print algo.pipe(input)
```

```java
/*
  Add algorithmia-client dependency from Maven Central:

  <dependency>
    <groupId>com.algorithmia</groupId>
    <artifactId>algorithmia-client</artifactId>
    <version>[,1.1.0)</version>
  </dependency>
*/

import com.algorithmia.*;
import com.algorithmia.algo.*;

String input = "\"YOUR_NAME\"";
AlgorithmiaClient client = Algorithmia.client("YOUR_API_KEY");
Algorithm algo = client.algo("algo://demo/Hello/0.1.1");
AlgoResponse result = algo.pipeJson(input);
System.out.println(result.asJson());
```

```scala
/**
  Add algorithmia-client dependency from Maven Central:

  libraryDependencies ++= Seq(
    "com.algorithmia" % "algorithmia-client" % "1.0.+",
  )
*/

import com.algorithmia._
import com.algorithmia.algo._

val input = "YOUR_NAME"
val client = Algorithmia.client("YOUR_API_KEY")
val algo = client.algo("algo://demo/Hello/0.1.1")
val result = algo.pipeJson(input)
System.out.println(result.asJson)
```

```javascript
/*
  Include the algorithmia.js library:
  <script src="//algorithmia.com/v1/clients/js/algorithmia-0.2.0.js" type="text/javascript"></script>
*/

var input = "YOUR_NAME";
var client = Algorithmia.client("YOUR_API_KEY");

client.algo("algo://demo/Hello/0.1.1")
      .pipe(input)
      .then(function(output) {
          console.log(output);
      });
```

```nodejs
/*
  Add algorithmia to your package.json via:
    npm install --save algorithmia
*/

var algorithmia = require("algorithmia");

var input = "YOUR_NAME";
var client = algorithmia.client("YOUR_API_KEY");

client.algo("algo://demo/Hello/0.1.1")
      .pipe(input)
      .then(function(response) {
          console.log(response.get());
      });
```


> Make sure to replace `YOUR_NAME` with your name & `YOUR_API_KEY` with your API key.

We'll make our first call with the demo algorithm ["Hello"](https://algorithmia.com/algorithms/demo/Hello). This algorithm takes an input of a string (preferably your name!) and returns a greeting addressed to the input.

Calling the algorithm is as simple as making a curl request. For example, to call the demo/Hello algorithm, simply run a cURL request in your terminal:

`curl -X POST -d 'YOUR_NAME' -H 'Content-Type: application/json' -H 'Authorization: Simple YOUR_API_KEY'`

You can also use one of the clients to make your call. Simply pick your language tab on the right side of these docs to see the sample call in another language.


<aside class="notice">
Remember — you'll need to authenticate!
</aside>

## Understanding the response

> curl -X POST -d 'Liz' -H 'Content-Type: application/json' -H 'Authorization: Simple API_KEY' https://api.algorithmia.com/v1/algo/demo/Hello/0.1.1

```
{ "result": "Hello Liz",
  "metadata": {
  	 "content_type": "text",
  	 "duration": 0.000187722
  }
}
```

Each algorithm returns a response in JSON. It will include the `"result"` as well as metadata about the API call you made. The metadata will include the `content_type` as well as a duration.

The duration is the compute time of the API call into the algorithm. This is the time in seconds between the start of the execution of the algorithm and when it produces a response. Because you are charged on the compute time of the API call, this information will help you optimize your use of the API. For more information, see the [Pricing](https://algorithmia.com/docs/platform/pricing/) page.

