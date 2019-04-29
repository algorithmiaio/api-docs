# Algorithm Management API

Using the Algorithm Management APIs, you can create, publish, update, and inspect individual algorithms. At present, these are only available in Python.

To try out a complete training-to-deployment pipeline, get the [runnable Jupyter Notebook](https://github.com/algorithmiaio/model-deployment).

IMPORTANT:

1. Before using these functions, update to the latest Python client: `pip install -U Algorithmia`

2. Create a *NEW* API Key at https://algorithmia.com/user#credentials or in your own Algorithmia cluster, with the option "Allow this key to manage my algorithms" turned on. Do not use this key for other purposes.  

## Create an Algorithm

First, define an algo using `client.algo('USERNAME/ALGONAME')`, making sure that "USERNAME/ALGONAME" is *not* the name of an existing Algorithm.

Then, call `algo.create(details, settings)` -- the parameters are dictionaries with the following keys:

*details:*

- "label": "\<string>" #user-readable name of the algorithm
- "tagline": "\<string>" #(optional) one-liner summarizing the Algorithm's purpose
- "summary": "\<string>" #(optional)markdown describing the Algorithm, for the "docs" tab

*settings:*

- "language": "\<string>" #java, javascript, python2-langpack, python3-1, r, ruby, rust, scala
- "source_visibility": "\<string>" #open, closed
- "license": "\<string>" #apl, apache2, gpl3, mit
- "network_access": "\<string>" #isolated, full
- "pipeline_enabled": \<boolean> #can this algo call other algos?
- "environment": "\<string>" #cpu, gpu
- "royalty_microcredits": \<integer> #(optional) 0 for none
</pre>

Once this has been done, your algorithm will be visible at https://algorithmia.com/algorithms/USERNAME/ALGONAME ... but it doesn't have any code yet. You'll need to `git clone https://git.algorithmia.com/git/USERNAME/ALGONAME.git`, then add and commit code, before continuing on to the Publishing step.

```python
client=Algorithmia.client('MANAGEMENT_API_KEY')
algo = client.algo('demo/Hello')
algo.create(
    details = {
        "label": "Hello World",
    },
    settings = {
        "language": "python3-1",
        "source_visibility": "closed",
        "license": "apl",
        "network_access": "full",
        "pipeline_enabled": True,
        "environment": "cpu"
    }
)
```

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

## Optional: Update an Algorithm

If you need to change an Algorithm's settings after it cas been created, this can be done with a call to `algo.update(details, settings)` which takes these parameters:

*details:*

- "label": "\<string>" #user-readable name of the algorithm
- "tagline": "\<string>" #(optional) one-liner summarizing the Algorithm's purpose
- "summary": "\<string>" #(optional) markdown describing the Algorithm, for the "docs" tab

*settings:*

- "source_visibility": "\<string>" #open, closed
- "license": "\<string>" #apl, apache2, gpl3, mit
- "network_access": "\<string>" #isolated, full
- "pipeline_enabled": \<boolean> #can this algo call other algos?
- "environment": "\<string>" #cpu, gpu

```python
algo.update(
    details = {
        "label": "Echo", #user-readable name of the algorithm
    },
    settings = {
        "source_visibility": "open",
        "license": "apl",
        "network_access": "full",
        "pipeline_enabled": True,
        "environment": "cpu"
    }
)
```

## Optional: Recompile your Algorithm

Any `git push` to your Algorithm's repo implicitly causes a compile to run on Algorithmia's servers. However, you can also manually force a compile if desired, using `algo.compile()`

```python
algo.compile()
```

## Publish an Algorithm

Once you've committed code, you can use `algo.publish(details, settings, version_info)` to make the Algorithm callable. All parameters are optional, and will overwrite those specified in the initial create() call if they conflict.

Note the addition of "algorithm_callability" to the settings parameter: if this is set to "public", your Algorithm will be published publicly, allowing any registered user to call it.

Under version_info, even if your sample_input is a dictionary, it must be encapsulated as a string, such as `"sample_input": "{\"text\": \"This is a very positive review for the movie. I absolutely loved it!\"}"`

*details:*

- "summary": "\<string>" #markdown describing the Algorithm, for the "docs" tab
- "tagline": "\<string>" #one-liner summarizing the Algorithm's purpose

*settings:*

- "algorithm_callability": "\<string>" #private, public
- "source_visibility": "\<string>" #open, closed
- "license": "\<string>" #apl, apache2, gpl3, mit
- "royalty_microcredits": \<integer> #0 for none

*version_info:*

- "sample_input": "\<string>" #example input visible to end-user

```python
algo.publish(
    version_info = {
        "sample_input": "world"
    }
)
```

## Get info about an an Algorithm

To inspect a previously created Algorithm, call `algo.info()` on it to obtain details similar to those specified at create(), as well as additional info such as the hash value of the latest compile (available in version_info.git_hash only if code has been pushed) or the last published version number (version_info.semantic_version only if it has been published).

```python
algo.info() #optional params: algo_hash
```

## List Versions of an Algorithm

To get info about every individual published version of your Algorithm, use `algo.versions()`

```python
algo.versions() #optional params: limit (<int>), marker (<string>), published (<boolean>), callable (<boolean>)
```