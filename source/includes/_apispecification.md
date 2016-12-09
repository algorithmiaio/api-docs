# API Specification

The Algorithmia API gives developers the ability to build applications that interact with and use all the features of Algorithmia in an automated fashion. Tasks can be generated, work can be ordered, and your application can be notified as data is processed by Algorithmia.

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
# Pass in the unique algoUrl path found on each algorithm description page.
algo = client.algo('demo/Hello/0.1.1')
# Calls an algorithm with the input provided.
result = algo.pipe(input)

# If you are using the 1.0+ client you can access both the output and the metadata.
print result.result    # Hello YOUR_NAME
print result.metadata  # Metadata(content_type='text',duration=0.0002127)

# If you are using 0.9.x you can only get the algorithm output
print result   # Hello YOUR_NAME

# There are many other features missing in 0.9.x, to upgrade see the github docs.
```

```r
library(algorithmia)

input <- "YOUR_NAME"
client <- Algorithmia$client('YOUR_API_KEY')
algo <- client$algo('demo/Hello/0.1.1')
result <- algo$pipe(input)$result
print(result)
```

```ruby
require 'algorithmia'

client = Algorithmia.client('YOUR_API_KEY')
algo = client.algo('demo/Hello/0.1.1')
response = algo.pipe('YOUR_NAME')
puts response.result
```

```java
import com.algorithmia.*;
import com.algorithmia.algo.*;

String input = "\"YOUR_NAME\"";
AlgorithmiaClient client = Algorithmia.client("YOUR_API_KEY");
Algorithm algo = client.algo("algo://demo/Hello/0.1.1");
AlgoResponse result = algo.pipeJson(input);
System.out.println(result.asJsonString());
```

```scala
import com.algorithmia._
import com.algorithmia.algo._

val input = "YOUR_NAME"
val client = Algorithmia.client("YOUR_API_KEY")
val algo = client.algo("algo://demo/Hello/0.1.1")
val result = algo.pipeJson(input)
System.out.println(result.asJsonString)
```

```rust
use algorithmia::*;
use algorithmia::algo::*;

let input = "YOUR_NAME";
let client = Algorithmia::client("YOUR_API_KEY");
let algo = client.algo("algo://demo/Hello/0.1.1");
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

For each algorithm on the marketplace, you'll find an owner (the user who created the algorithm), an algorithm name, and a version number.
Algorithms are called using this HTTP endpoint:

`POST https://api.algorithmia.com/v1/algo/:owner/:algoname/[:version]`

Specifying a version is recommended, but optional. If not specified, the latest publicly published version will be used.
When explicitly specifying a version, the following following formats are accepted:

Version         | Description
--------------  | --------------
`1.1.1`         | Fully specified version
`1.2.*`         | Specified to the minor level. Will resolve to the latest publicly published version with a minor version of 1.2
`1.*`           | Specified to a major version. Will resolve to the latest publicly published version with major version 1

<aside class="notice">
To call private versions of an algorithm you own, you must use a fully specified semantic version or a version hash
</aside>

## Input/Output

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
print algo.pipe("HAL 9000").result
# -> Hello HAL 9000
```

```r
algo <- client$algo('demo/Hello/0.1.1')
print(algo$pipe("HAL 9000")$result)
# -> Hello HAL 9000
```

```ruby
algo = client.algo('demo/Hello/0.1.1')
puts algo.pipe('HAL 9000').result
# -> Hello HAL 900
```

```java
Algorithm algo = client.algo("algo://demo/Hello/0.1.1");
AlgoResponse result = algo.pipe("HAL 9000");
System.out.println(result.asString());
// -> Hello HAL 9000
```

```scala
val algo = client.algo("algo://demo/Hello/0.1.1")
val result = algo.pipe("HAL 9000")
System.out.println(result.asString)
// -> Hello HAL 9000
```

```rust
let algo = client.algo("algo://demo/Hello/0.1.1");
let response = algo.pipe("HAL 9000").unwrap();
println!("{}", response.as_string().unwrap());
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
result = algo.pipe(["transformer", "terraforms", "retransform"]).result
# -> ["transformer","retransform"]
```

```r
algo <- client$algo('WebPredict/ListAnagrams/0.1.0')
result <- algo$pipe(["transformer", "terraforms", "retransform"])$result
# Returns a list in R
[[1]]
[1] "transformer"

[[2]]
[1] "retransform"
```

```ruby
algo = client.algo('WebPredict/ListAnagrams/0.1.0')
result = algo.pipe(["transformer", "terraforms", "retransform"]).result
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
AlgoResponse result2 = algo.pipeJson(jsonWords);
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
String anagrams = result.asJsonString();
// -> "[\"transformer\", \"retransform\"]"
```

```rust
let algo = client.algo("algo://WebPredict/ListAnagrams/0.1.0");
let response = algo.pipe(vec!["transformer", "terraforms", "retransform"]).unwrap();
let output: Vec<String> = response.decode().unwrap();
// -> ["transformer", "retransform"] as Vec<String>

// Or working with raw JSON
let response2 = algo.pipe_json(r#"["transformer", "terraforms", "retransform"]"#).unwrap();
let output = response2.as_json().unwrap().to_string();
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
result = client.algo("opencv/SmartThumbnail/0.1").pipe(input).result
# -> [binary byte sequence]
```

```r
algo <- client$algo("opencv/SmartThumbnail/0.1")
response <- algo$pipe(input)$result
# -> [raw vector]
```

```ruby
input = File.binread("/path/to/bender.png")
result = client.algo("opencv/SmartThumbnail/0.1").pipe(input).result
# -> [ASCII-8BIT string of binary data]
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

```rust
let mut input = Vec::new();
File::open("/path/to/bender.jpg").read_to_end(&mut input);
let response = client.algo("opencv/SmartThumbnail/0.1").pipe(&input).unwrap();
let output = response.as_bytes().unwrap();
// -> Vec<u8>
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

Algorithmia supports calling algorithms that use any combination of text, JSON, or binary as their input and output.

Each client SDK provides idiomatic abstractions for calling algorithms
using common native types and automatic serializization and deserialization where reasonable.
See the code samples to the right for examples in the language of your choice.

#### HTTP input specification

To specify input when making a raw HTTP request, the body of the request is the input to the algorithm you are calling.
To specify the input type, set the `Content-Type` header accordingly. These are

Content-Type          | Description
-------------------   | --------------
`application/json`    | body specifies JSON input data (UTF-8 encoded)
`application/text`    | body specifies text input data (UTF-8 encoded)
`application/octet-stream` | body specifies binary input data (raw bytes)

#### HTTP output specification

The `metadata.content_type` specifies which type of encoding the result element is in.

Content-Type | Description
--------------  | --------------
void | The result element is null
text | The result element is a JSON string using UTF-8 encoding
json | The result element is any valid JSON type
binary | The result element is a Base64 encoded binary data in a JSON String

## Query Parameters

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
algo = client.algo('demo/Hello/0.1.1').set_options(timeout=10, stdout=True)
result = algo.pipe("HAL 9000")

from Algorithmia.algorithm import OutputType
algo = client.algo('demo/Hello/0.1.1').set_options(output=OutputType.raw)
```

```r
algo <- client$algo('util/echo')
algo$setOptions(timeout=40, stdout=FALSE)
result <- algo$pipe('HAL 9000')$result
```

```ruby
algo = client.algo('demo/Hello/0.1.1').set_timeout(10).enable_stdout
result = algo.pipe('HAL 9000').result
```

```java
Algorithm algo = client.algo("algo://demo/Hello/0.1.1?timeout=10");
AlgoResponse result = algo.pipe("HAL 9000");
```

```scala
val algo = client.algo("algo://demo/Hello/0.1.1?timeout=10")
val result = algo.pipe(input)
```

```rust
let mut algo = client.algo("algo://demo/Hello/0.1.1");
let algo = algo.timeout(10).enable_stdout();
let response = algo.pipe(input).unwrap();
if let Some(ref stdout) = response.metadata.stdout {
      println!("{}", stdout);
}
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

The API also provides the following configurable parameters when calling an algorithm:

Parameter             | Description
-------------------   | --------------
timeout               | number: Specifies a timeout for the call in seconds. default=300 (5min), max=3000 (50min)
stdout                | boolean: Indicates algorithm stdout should be returned in the response metadata (ignored unless you are the algorithm owner)
output                | raw|void: Indicates the algorithm


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


## Error Handling

> Error Handling

```shell
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -d '[]' -H 'Content-Type: application/json' \
    https://api.algorithmia.com/v1/algo/demo/Hello/0.1.1

-> {
    "error":{
      "message":"apply() functions do not match input data",
      "stacktrace":"apply() functions do not match input data"
    },
    "metadata":{"duration":0.046542354}}
}
```

```cli
$ algo run demo/Hello/0.1.1 -d '[]'
API error: apply() functions do not match input data
apply() functions do not match input data
```

```python
algo = client.algo('demo/Hello/0.1.1')
print algo.pipe([]).error.message
# -> API error: apply() functions do not match input data
```

```r
algo <- client$algo('demo/Hello/0.1.1')
algo$pipe(list())$error$message
# -> API error: apply() functions do not match input data
```

```ruby
algo = client.algo('demo/Hello/0.1.1')
puts algo.pipe([]).error.message
# -> API error: apply() functions do not match input data
```

```java
Algorithm algo = client.algo("algo://demo/Hello/0.1.1");
AlgoResponse result = algo.pipe([]);
try {
  result.asString();
} catch (AlgorithmException ex) {
  System.out.println(ex.getMessage());
}
// -> API error: apply() functions do not match input data
```

```scala
val algo = client.algo("algo://demo/Hello/0.1.1")
val result = algo.pipe("HAL 9000")
try {
  result.asString();
} catch {
  case ex: AlgorithmException => System.out.println(ex.getMessage)
}
// -> API error: apply() functions do not match input data
```

```rust
let algo = client.algo("algo://demo/Hello/0.1.1");
match algo.pipe(&[]) {
    Ok(response) => { /* success */ },
    Err(err) => println!("error calling demo/Hello: {}", err),
}
// -> error calling demo/Hello: apply() functions do not match input data
```

```javascript
client.algo("algo://demo/Hello/0.1.1")
      .pipe("HAL 9000")
      .then(function(output) {
        if(output.error) {
          console.log(output.error.message);
        }
      });
// -> API error: apply() functions do not match input data
```

```nodejs
client.algo("algo://demo/Hello/0.1.1")
      .pipe("HAL 9000")
      .then(function(response) {
        if(response.error) {
          console.log(response.error.message);
        }
      });
// -> API error: apply() functions do not match input data
```

If an error occurs, the response will contain the following fields:

Field            | Description
--------------   | --------------
error.message    | The error message
error.stacktrace | (Optional) a stacktrace if the error occurred within the algorithm (only if caller has access to algorithm source)

Each client provides a language-specific solution for error handling. The examples on the right
come from calling an algorithm that expects text input in it's implementation of the `apply` entrypoint,
but instead receives a JSON array as input.

