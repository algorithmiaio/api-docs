# API Specification

The Algorithmia API gives developers the ability to build applications that interact with and use all the features of Algorithmia in an automated fashion. Tasks can be generated, work can be ordered, and your application can be notified as data is processed by Algorithmia.

## Requests

Requests to the API must be formatted in JSON. We follow the [JSON-RPC 2.0 spec](http://www.jsonrpc.org/specification).

A properly formatted request will always return the HTTP status code `200 OK`; with either a `result` field (which may be null in some cases) for successes or an `error` field to indicate failure.

The size limit for a request is 10MiB. Check out the [Data API](#the-data-api) for options on how to process larger files.

## Call an Algorithm

```shell
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -d 'YOUR_NAME' -H 'Content-Type: text/plain' \
    https://api.algorithmia.com/v1/algo/demo/Hello/0.1.1
```

```cli
$ algo run -d 'YOUR_NAME' demo/Hello/0.1.1
Hello YOUR_NAME
```

```python
import Algorithmia

input = "YOUR_NAME"
client = Algorithmia.client('YOUR_API_KEY')
algo = client.algo('demo/Hello/0.1.1')
print algo.pipe(input)
```

```java
import com.algorithmia.*;
import com.algorithmia.algo.*;

String input = "\"YOUR_NAME\"";
AlgorithmiaClient client = Algorithmia.client("YOUR_API_KEY");
Algorithm algo = client.algo("algo://demo/Hello/0.1.1");
AlgoResponse result = algo.pipeJson(input);
System.out.println(result.asJson());
```

```scala
import com.algorithmia._
import com.algorithmia.algo._

val input = "YOUR_NAME"
val client = Algorithmia.client("YOUR_API_KEY")
val algo = client.algo("algo://demo/Hello/0.1.1")
val result = algo.pipeJson(input)
System.out.println(result.asJson)
```

```javascript
// include the algorithmia.js library

var input = "YOUR_NAME";
Algorithmia.client("YOUR_API_KEY");

client.algo("algo://demo/Hello/0.1.1")
      .pipe(input)
      .then(function(output) {
        console.log(output);
      });
```

```nodejs
var input = "YOUR_NAME";
var client = Algorithmia.client("YOUR_API_KEY");

client.algo("algo://demo/Hello/0.1.1")
       .pipe(input)
       .then(function(response) {
         console.log(response.get());
       });
```


> Make sure to replace `YOUR_NAME` with your name & `YOUR_API_KEY` with your API key.


For each algorithm on the marketplace, you'll find an owner (the user who created the algorithm), an algorithm name, and a version number. This is the information you need to format a call.

For a given user and algorithm name, API calls are made to the following url:

`POST https://api.algorithmia.com/v1/algo/:owner/:algoname`


## Input

> Text Input/Output

```shell
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -d 'HAL 9000' -H 'Content-Type: text/plain' \
    https://api.algorithmia.com/v1/algo/demo/Hello/0.1.1

-> {
    "result":"Hello HAL 9000",
    "metadata":{"content_type":"text","duration":0.034232617}
}
```

```cli
$ algo run demo/Hello/0.1.1 -d 'HAL 9000'
Hello HAL 9000
```

```python
algo = client.algo('demo/Hello/0.1.1')
print algo.pipe("HAL 9000")
# -> Hello HAL 9000
```

```java
Algorithm algo = client.algo("algo://demo/Hello/0.1.1");
AlgoResponse result = algo.pipe("HAL 9000");
System.out.println(result.asString());
// -> Hello HAL 9000
```

```scala
val algo = client.algo("algo://demo/Hello/0.1.1")
val result = algo.pipe(input)
System.out.println(result.asString)
// -> Hello HAL 9000
```

```javascript
client.algo("algo://demo/Hello/0.1.1")
      .pipe("HAL 9000")
      .then(function(output) {
        console.log(output.result);
      });
// -> Hello HAL 9000
```

```nodejs
client.algo("algo://demo/Hello/0.1.1")
      .pipe("HAL 9000")
      .then(function(response) {
        console.log(response.get());
      });
// -> Hello HAL 9000
```

> JSON Input/Output (including serialized objects/arrays)

```shell
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -H 'Content-Type: application/json' \
    -d '["transformer", "terraforms", "retransform"]' \
    https://api.algorithmia.com/v1/algo/WebPredict/ListAnagrams/0.1

-> {
    "result": ["transformer","retransform"],
    "metadata":{"content_type":"json","duration":0.039351226}
}
```

```cli
# -d automatically detects if input is valid JSON
$ algo run WebPredict/ListAnagrams/0.1 \
    -d '["transformer", "terraforms", "retransform"]'
["transformer","retransform"]
```


```python
algo = client.algo('WebPredict/ListAnagrams/0.1.0')
result = algo.pipe(["transformer", "terraforms", "retransform"])
# -> ["transformer","retransform"]

# Or using raw JSON
result2 = algo.pipeJson('["transformer", "terraforms", "retransform"]')
# -> ["transformer","retransform"]
```

```java
Algorithm algo = client.algo("algo://WebPredict/ListAnagrams/0.1.0");
List<String> words = Arrays.asList(("transformer", "terraforms", "retransform");
AlgoResponse result = algo.pipe(words);
// WebPredict/ListAnagrams returns an array of strings, so cast the result:
List<String> anagrams = result.as(new TypeToken<List<String>>(){});
// -> List("transformer", "retransform")

// Or using raw JSON
String jsonWords = "[\"transformer\", \"terraforms\", \"retransform\"]"
AlgoResponse result2 = algo.pipe(jsonWords);
String anagrams = result2.asJsonString();
// -> "[\"transformer\", \"retransform\"]"
```

```scala
val algo = client.algo("algo://WebPredict/ListAnagrams/0.1.0")
val result = algo.pipe(List("transformer", "terraforms", "retransform"))
// WebPredict/ListAnagrams returns an array of strings, so cast the result:
val anagrams = result.as(new TypeToken<List<String>>(){})
// -> List("transformer", "retransform")

// Or using raw JSON
val result2 = algo.pipeJson("""["transformer", "terraforms", "retransform"]""")
String anagrams =result.asJsonString();
// -> "[\"transformer\", \"retransform\"]"
```

```javascript
client.algo("algo://WebPredict/ListAnagrams/0.1.0")
      .pipe(["transformer", "terraforms", "retransform"])
      .then(function(output) {
        console.log(output.result);
        // -> ["transformer","retransform"]
      });

// Or using raw JSON
client.algo("algo://WebPredict/ListAnagrams/0.1.0")
      .pipeJson('["transformer", "terraforms", "retransform"]')
      .then(function(output) {
        console.log(output.result);
        // -> ["transformer","retransform"]
      });
```

```nodejs
client.algo("algo://WebPredict/ListAnagrams/0.1.0")
      .pipe(["transformer", "terraforms", "retransform"])
      .then(function(response) {
        console.log(response.get());
        // -> ["transformer","retransform"]
      });

// Or using raw JSON
client.algo("algo://WebPredict/ListAnagrams/0.1.0")
      .pipeJson('["transformer", "terraforms", "retransform"]')
      .then(function(response) {
        console.log(response.get());
        // -> ["transformer","retransform"]
      });
```

> Binary Input/Output

```shell
# Save output to bender_thumb.png since consoles don't handle printing binary well
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -H 'Content-Type: application/octet-stream' \
    --data-binary @bender.jpg \
    -o bender_thumb.png \
    https://api.algorithmia.com/v1/algo/opencv/SmartThumbnail/0.1
```

```cli
# -D reads input from a file
# -o saves output to a file since consoles don't print binary well
$ algo run opencv/SmartThumbnail/0.1 -D bender.jpg -o bender_thumb.png
Completed in 1.1 seconds
```

```python
input = bytearray(open("/path/to/bender.png", "rb").read())
result = client.algo("opencv/SmartThumbnail/0.1").pipe(input);
# -> [binary byte sequence]
```

```java
byte[] input = Files.readAllBytes(new File("/path/to/bender.jpg").toPath());
AlgoResponse result = client.algo("opencv/SmartThumbnail/0.1").pipe(input);
byte[] buffer = result.as(new TypeToken<byte[]>(){});
// -> [byte array]
```

```scala
let input = Files.readAllBytes(new File("/path/to/bender.jpg").toPath())
let result = client.algo("opencv/SmartThumbnail/0.1").pipe(input)
let buffer = result.as(new TypeToken<byte[]>(){})
// -> [byte array]
```

```javascript
/*
  Support for binary I/O in the javascript client is planned.
  Contact us if you need this feature, and we'll prioritize it right away:
  https://algorithmia.com/contact

  Note: The NodeJS client does currently support binary I/O.
*/
```

```nodejs
var buffer = fs.readFileSync("/path/to/bender.jpg");
client.algo("opencv/SmartThumbnail")
    .pipe(buffer)
    .then(function(response) {
        var buffer = response.get();
        // -> Buffer(...)
    });
```

The body of the request is the input to the algorithm you are calling.
To specify the type, the Content-Type header is required.

Content-Type Header | Description
------------------- | --------------
application/json    | text/json for passing JSON encoded data (UTF-8 encoded)
application/text    | text/plain for passing a basic String (UTF-8 encoded)
application/octet-stream | binary data

HTTP-multipart is also supported for sending a mixture of data objects. Each multipart part must have a valid Content-Type.

#### Versioning

Specifying the version of an algorithm is optional and can be a partial semantic version.
The format of the call with a specified version is as follows:

`POST https://api.algorithmia.com/v1/algo/:owner/:algoname/:version`


Semantic Number | Description
--------------  | --------------
1.1.1           | Fully specified version
1.2.*           | Specified to the minor level. Will resolce to the latest publicly published version with a minor version of 1.2
1.*             | Specified to a major version. Will resolve to the latest publicly published version with major version 1

<aside class="notice">
To call private versions of an algorithm, you must use a fully specified semantic version or a version hash
</aside>


## Query parameters

> Query Parameters

```shell
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -d 'HAL 9000' -H 'Content-Type: text/plain' \
    https://api.algorithmia.com/v1/algo/demo/Hello/0.1.1?timeout=10
```

```cli
# use --timeout to set the call timeout
$ algo run demo/Hello/0.1.1 -d 'HAL 9000' --timeout 10

# use --debug to print STDOUT if available
$ algo run demo/Hello/0.1.1 -d 'HAL 9000' --debug
```

```python
algo = client.algo('demo/Hello/0.1.1?timeout=10')
result = algo.pipe("HAL 9000")
```

```java
Algorithm algo = client.algo("algo://demo/Hello/0.1.1?timeout=10");
AlgoResponse result = algo.pipe("HAL 9000");
```

```scala
val algo = client.algo("algo://demo/Hello/0.1.1?timeout=10")
val result = algo.pipe(input)
```

```javascript
client.algo("algo://demo/Hello/0.1.1?timeout=10")
      .pipe("HAL 9000")
      .then(function(output) {
        console.log(output);
      });
```

```nodejs
client.algo("algo://demo/Hello/0.1.1?timeout=10")
      .pipe("HAL 9000")
      .then(function(output) {
        console.log(output);
      });
```

The API offers the following query parameters:

* `timeout={seconds}`
  * Specifies a timeout for the call in seconds
  * The default timeout is 5 minutes
  * The maximum configurable timeout is 50 minutes

* `stdout=true`
  * Returns the stdout that the algorithm produced during the call
  * Will only display if the algorithm author initiates the call

* `output=raw`
  * Returns the result of the algorithm call without the JSON-RPC wrapper
  * If the algorithm returned an error then an HTTP 400 status code will be used

* `output=void`
  * Returns immediately and does not wait for the algorithm to run
  * The result of the algorithm will not be accessible; this is useful in some cases where an algorithm outputs to a `data://` file with a long running time (see [The Data API](#the-data-api) for more information)

## Output

> Output Spec

```json
{
    "result": Any, /* Optional */
    "error": {
        "message": String,
        "stacktrace": String /* Optional */
    }, /* Optional */
    "metadata": {
        "duration": Double,
        "content_type": String,
        "stdout": String, /* Optional */
        "alerts": [
            String
        ] /* Optional */
    }
}
```

The `metadata.content_type` specifies which type of encoding the result element is in.

Content-Type | Description
--------------  | --------------
void | The result element is null
text | The result element is a JSON string using UTF-8 encoding
json | The result element is any valid JSON type
binary | The result element is a Base64 encoded binary data in a JSON String

<aside class="notice">
Note that `error.stacktrace` will only display if the Algorithm is open source or if the Algorithm author initiates the call.
</aside>
