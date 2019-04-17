# Algorithm Management

Using the Algorithm Management APIs, you can create, publish, update, and inspect individual algorithms.

[Preliminary Specification](https://algorithmia.com/developers/algorithm-development/algorithm-management-api)

```javascript
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```shell
  # This client does not currently support Algorithm Management.
  # Use Python or the OpenAPI spec instead:
  # https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```cli
  # This client does not currently support Algorithm Management.
  # Use Python or the OpenAPI spec instead:
  # https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```r
  # This client does not currently support Algorithm Management.
  # Use Python or the OpenAPI spec instead:
  # https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```ruby
  # This client does not currently support Algorithm Management.
  # Use Python or the OpenAPI spec instead:
  # https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```


```java
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```scala
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```rust
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```nodejs
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```php
<?
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
?>
```


## Parameter definitions

* [details](https://github.com/algorithmiaio/algorithmia-api-client/blob/eb9d99f9317d0a4969e4d30a0ae40d159bcd58f5/python/algorithmia_api_client/models/details.py)
* [settings](https://github.com/algorithmiaio/algorithmia-api-client/blob/eb9d99f9317d0a4969e4d30a0ae40d159bcd58f5/python/algorithmia_api_client/models/settings.py)
* [version_info](https://github.com/algorithmiaio/algorithmia-api-client/blob/eb9d99f9317d0a4969e4d30a0ae40d159bcd58f5/python/algorithmia_api_client/models/version_info.py)

(Some dictionary entries may be optional; see the [OpenAPI spec](https://algorithmia.com/v1/openapispec) for info)

## Create an Algorithm

First, define an algo using client.algo('USERNAME/ALGONAME'), making sure that "USERNAME/ALGONAME" is *not* the name of an existing Algorithm

Then, call .create() on that algo, setting the details, settings, and version info as shown in the codesample.

Once this has been done, your algorithm will be visible at https://algorithmia.com/algorithms/USERNAME/ALGONAME -- but it doesn't have any code yet. You'll need to `git clone https://git.algorithmia.com/git/USERNAME/ALGONAME.git`, then add and commit code, before continuing on to the Publishing step.

Note: even if your sample_input is a dictionary, it must be encapsulated as a string, such as

`"sample_input": "{\"text\": \"This is a very positive review for the movie. I absolutely loved it!\"}"`

```python
algo = client.algo('demo/Hello/')
details = {
    "label": "<string>", #user-readable name of the algorithm
    "summary": "<string>", #markdown describing the Algorithm, for the "docs" tab
    "tagline": "<string>" #one-liner summarizing the Algorithm's purpose
}
settings = {
    "algorithm_callability": "<string>", #private, public
    "source_visibility": "<string>", #open, closed
    "license": "<string>", #apl, apache2, gpl3, mit
    "network_access": "<string>", #isolated, full
    "pipeline_enabled": <boolean>, #can this algo call other algos?
    "language": "<string>", #java, javascript, python2-langpack, python3-1, r, ruby, rust, scala
    "environment": "<string>", #cpu, gpu
    "royalty_microcredits": <integer> #0 for none
}
version_info = {
    "sample_input": "<string>" #example input visible to end-user
}
algo.create(details, settings, version_info)
```

## Optional: Update an Algorithm

If you need to change an Algorithm's settings after it cas been created, this can be done with a call to .update(), which takes the same parameters as .create()

```python
algo.update(details, settings, version_info)
```

## Optional: Recompile your Algorithm

Any `git push` to your Algorithm's repo implicitly causes a compile to run on Algorithmia's servers. However, you can also manually force a compile if desired, using algo.compile()

```python
algo.compile()
```

## Publish an Algorithm

Once you've committed code, you can use .publish() to make the Algorithm callable. Ymu can optionally include details, settings, and version_info to overwrite those specified in the initial create() call

```python
algo.publish() #optional params: details, settings, version_info
```

## Get info about an an Algorithm

To inspect a previously created Algorithm, call .info() on it to obtain details similar to those specified at create(), as well as assidional info such as the hash value of the latest compile (available in version_info.git_hash only if code has been pushed) or the last published version number (version_info.semantic_version only if it has been published)

```python
algo.info() #optional params: algo_hash
```

## List Versions of an Algorithm

To get info about every individual published version of your Algorithm, use .versions()

```python
algo.versions() $optional params: limit (<int>), marker (<string>), published (<boolean>), callable (<boolean>)
```