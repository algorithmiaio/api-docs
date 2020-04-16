# Algorithms

## The algorithm object

```json
{
  "build": {
    "build_id": "j85f8087db281388d79fb224853864da73bff865",
    "commit_sha": "j85f8087db281388d79fb224853864da73bff865",
    "finished_at": "2019-05-07T21:16:43.121Z",
    "started_at": "2019-05-07T21:16:40.148Z",
    "status": "succeeded",
    "version_info": {
      "semantic_version": "0.1.0"
    }
  },
  "compilation": {
    "output": "Building algorithm...\nSuccess!",
    "successful": true
  },
  "details": {
    "label": "Greeting Algorithm",
    "summary": "This algorithm accepts text and returns a string of the form 'Hello ${text}!'",
    "tagline": "Returns a greeting"
  },
  "name": "Hello",
  "resource_type": "algorithm",
  "settings": {
    "algorithm_callability": "private",
    "environment": "cpu",
    "language": "java",
    "license": "apl",
    "network_access": "full",
    "pipeline_enabled": true,
    "source_visibility": "closed"
  },
  "self_link": "https://api.algorithmia.com/v1/algorithms/algorithmiahq/Hello/versions/a501ed74fd91548dedd50dffa59e9f0e53ce49a3",
  "source": {
    "repository_https_url": "https://github.com/algorithmiahq/hello",
    "repository_name": "hello",
    "repository_owner": "algorithmiahq",
    "repository_ssh_url": "ssh://git@github.com:algorithmiahq/hello.git", 
    "scm": {
      "id": "1d48d16c-18cb-4336-8d0c-03a36f3120e1",
      "provider": "github",
      "default": false,
      "enabled": true,
      "oauth": {
        "client_id": "a727e54cb1fb30cde4b6"
      },
      "urls": {
        "api": "https://api.github.com",
        "ssh": "ssh://git@github.com",
        "web": "https://github.com"
      }
    }
  },
  "version_info": {
    "git_hash": "a501ed74fd91548dedd50dffa59e9f0e53ce49a3",
    "release_notes": "Fixed a bug that resulted in overly-enthusiastic greetings.",
    "sample_input": "Mia",
    "sample_output": "Hello Mia!",
    "semantic_version": "0.1.0"
  }
}
```

|Attribute|Type|Description|
|-|-|-|
|`build`|Object|The [algorithm build](#the-algorithm-build-object) which resulted in the present algorithm version.|
|`compilation.output`|String|The logs for the algorithm's most recent build.|
|`compilation.successful`|Boolean|Whether the algorithm's most recent build succeeded or failed.|
|`details.label`|String|The human-readable name for an algorithm.|
|`details.summary`|String|A full description of an algorithm's capabilitities. Can contain HTML for rendering in an algorithm's "Docs" tab. Note that, if an algorithm's `README.md` file is updated, this value will be overwritten with the HTML equivalent of that file.|
|`details.tagline`|String|A short description of an algorithm for display under an algorithm's label.|
|`name`|String|The unique ID for an algorithm.|
|`resource_type`|String|Set to `algorithm` for algorithm objects.
|`self_link`|String|A URL that can be used to retrieve the present algorithm version.|
|`settings.algorithm_callability`|String|Whether the latest version of an algorithm can be called by users other than the algorithm's owner (or if the algorithm's owner is an organization, the organization's members). One of `public` or `private`. Is initially set to `private`, even if an algorithm has no versions.|
|`settings.environment`|String|The hardware your algorithm will run on. One of `cpu` or `gpu`. Not set if `settings.package_set` is specified.|
|`settings.language`|String|The language an algorithm is authored in. One of `java`, `javascript`, `python2-lackpack` (Python 2), `python3-1` (Python 3), `r`, `ruby`, `rust`, or `scala`. Not set if `settings.package_set` is specified.|
|`settings.license`|String|The license for an algorithm's source code. One of [`apl`](https://algorithmia.com/api_dev_terms), [`apache2`](https://www.apache.org/licenses/LICENSE-2.0), [`gpl3`](https://www.gnu.org/licenses/gpl-3.0.en.html) or [`mit`](https://opensource.org/licenses/MIT). Only [`apl`](https://algorithmia.com/api_dev_terms) supports closed-source algorithms.|
|`settings.network_access`|String|Specifies whether an algorithm has access to the public internet upon execution. One of `full` or `isolated`.|
|`settings.package_set`|String|Specifies the package set that defines an algorithm's build and runtime environments. Not set if `settings.language` is specified.|
|`settings.pipeline_enabled`|Boolean|Specifies whether this algorithm is allowed to call other algorithms on the platform.|
|`settings.source_visbility`|String|Specifies whether the source code for this algorithm will be viewable by any user of the platform. One of `open` or `closed`. Must be set to `open` unless license chosen is [`apl`](https://algorithmia.com/api_dev_terms).|
|`source.repository_https_url`|String|The HTTPS URL of the algorithm's Git repository (if the repository is hosted externally to the Algorithmia platform).|
|`source.repository_name`|String|The name of the Git repository that was created for the algorithm's source code (if the repository is hosted externally to the Algorithmia platform).|
|`source.repository_owner`|String|The username of the SCM user that owns the Git repository for this algorithm (if the repository is hosted externally to the Algorithmia platform).|
|`source.repository_ssh_url`|String|The SSH URL of the algorithm's Git repository (if the repository is hosted externally to the Algorithmia platform).|
|`source.scm`|Object|The [SCM object](#the-scm-object) representing the repository host for this algorithm.|
|`version_info.git_hash`|String|The Git SHA of the algorithm's most recent version.|
|`version_info.release_notes`|String|If this version of the algorithm has been published, this field informs consumers of any new changes in the algorithm that accompany the published version.|
|`version_info.sample_input`|String|An example of a valid text input to the algorithm. Only configurable for algorithm versions that have been published publicly or privately.|
|`version_info.sample_output`|String|An example of what the algorithm's output would be given the text provided in `version_info.sample_input`.|
|`version_info.semantic_version`|String|If this version of the algorithm has been published publicly or privately, this is semantic version that can be used to call said published version.|

## Create an algorithm

```shell
curl https://api.algorithmia.com/v1/algorithms/:username \
  -H 'Authorization: Simple API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "details": {
      "label": "My First Algorithm"
    },
    "name": "my_first_algorithm",
    "settings": {
      "environment": "cpu",
      "language": "java",
      "license": "apl",
      "network_access": "full",
      "pipeline_enabled": true,
      "source_visibility": "closed" 
    }
  }'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

algo = client.algo(':username/my_first_algorithm')

algo.create(
  details = {
    "label": "My First Algorithm"
  },
  settings = {
    "language": "java",
    "source_visibility": "closed",
    "license": "apl",
    "network_access": "full",
    "pipeline_enabled": True,
    "environment": "cpu"
  }
)
```

`POST /v1/algorithms/:username`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|username|String|*Required*. The username of the user or organization that will own this algorithm.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`details.label`|String|*Required*. The human-readable name for your algorithm.|
|`details.summary`|String|A full description of your algorithm's capabilitities. HTML is accepted for rendering in the algorithm's "Docs" tab.|
|`details.tagline`|String|A short description of your algorithm for display under the algorithm's label.|
|`name`|String|*Required*. The unique ID for your algorithm. Only alphanumeric characters and underscores are permitted. Must begin with a letter.|
|`settings.environment`|String|*Required if `language` specified*. The hardware your algorithm will run on. Choose from `cpu` or `gpu`.|
|`settings.language`|String|*Required if `package_set` not specified*. The language you wish to develop your algorithm in. Choose from `java`, `javascript`, `python2-lackpack` (Python 2), `python3-1` (Python 3), `r`, `ruby`, `rust`, or `scala`. |
|`settings.license`|String|*Required*. The license for your algorithm's source code. Choose from [`apl`](https://algorithmia.com/api_dev_terms), [`apache2`](https://www.apache.org/licenses/LICENSE-2.0), [`gpl3`](https://www.gnu.org/licenses/gpl-3.0.en.html) or [`mit`](https://opensource.org/licenses/MIT). Select `apl` if you wish for your algorithm's source code to be closed-source.|
|`settings.network_access`|String|*Required*. Specifies whether the algorithm will have access to the public internet upon execution. Choose from `full` or `isolated`.|
|`settings.package_set`|String|*Required if `language` not specified*. Specifies the package set that should define the algorithm's build and runtime environments.|
|`settings.pipeline_enabled`|Boolean|*Required*. Specifies whether this algorithm is allowed to call other algorithms on the platform.|
|`settings.source_visbility`|String|*Required*. Specifies whether the source code for this algorithm will be viewable by any user of the platform. If creating an algorithm with an external repository host, such as GitHub, determines whether the repo is created as public or private. Choose from `open` or `closed`.|
|`source.repository_name`|String|Specifies the name of the Git repository that will be created for your algorithm's source code (if using an external SCM). Defaults to your algorithm's `name` property.|
|`source.repository_owner`|String|The username of the SCM user you wish to own your algorithm. Defaults to the user you performed SCM authorization with.|
|`source.scm`|String|The ID of the SCM you wish to host your algorithm's source code. Defaults to the default SCM for your Algorithmia instance.|

```json
{
  "name": "my_first_algorithm",
  "details": {
    "label": "My First Algorithm"
  },
  "settings": {
    "algorithm_callability": "private",
    "source_visibility": "closed",
    "language": "java",
    "environment": "cpu",
    "license": "apl",
    "network_access": "full",
    "pipeline_enabled": true
  },
  "source": {
    "scm": {
      "id": "internal",
      "provider": "internal",
      "default": true,
      "enabled": true
    }
  },
  "resource_type": "algorithm"
}
```

### Returns

If the request is successful, an [algorithm object](#the-algorithm-object) representing the created algorithm will be returned to you, otherwise an [error](#errors).

## Invoke an algorithm

```shell
curl https://api.algorithmia.com/v1/algo/demo/Hello \
  -X POST \
  -H 'Authorization: Simple API_KEY' \
  -H 'Content-Type: text/plain' \
  -d 'Neo'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')
algo = client.algo('demo/Hello')

# Query parameters can be set via set_options.
algo.set_options(timeout=60, stdout=False)

result = algo.pipe("Neo")

print(result.result)    # Hello Neo
print(result.metadata)  # Metadata(content_type='text',duration=0.0002127)
```

`POST /v1/algo/:username/:algoname/[:version]`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to invoke.|
|`version`|String|The specific version of the algorithm you wish to invoke. The following are valid values for this parameter:<br><br>- `latestPrivate`: Resolves to the latest version you have published privately.<br>-`<Git SHA>`: Resolves to the built version of your algorithm for a specific Git SHA. Useful for testing an unpublished algorithm build.<br>- `1.1.1`: Fully specified semantic version.<br>- `1.2.*`: Specified to the minor level. Will resolve to the latest publicly published version with a minor version of 1.2<br>- `1.*`: Specified to a major version. Will resolve to the latest publicly published version with major version `1`.<br><br>Defaults to latest publicly published version of your algorithm.|

### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`output`|String|Determines how the algorithm's response is handled. Choose from `raw` (response is returned without a JSON wrapper) or `void` (algorithm call is made asynchronously and no output is returned).|
|`stdout`|Boolean|Whether the `stdout` of the algorithm should be returned in the response. Only available to the owner of the algorithm (or, if the algorithm is owned by an organization, the organization's members). Defaults to `false`.|
|`timeout`|Number|Duration, in seconds, that should pass before the invocation should timeout. Defaults to `300` (5 minutes). Maximum value is `3000` (50 minutes).|

### Payload Parameters

Both binary data and text may be passed as algorithm input data. To ensure your algorithm is passed the input data correctly, supply one of the following values for the `Content-Type` header when calling your algorithm (client libraries handle this automatically):

|Content-Type|Description|
|-|-|
|`application/json`|body specifies JSON input data (UTF-8 encoded)|
|`application/text`|body specifies text input data (UTF-8 encoded)|
|`application/octet-stream`|body specifies binary input data (raw bytes)|

<aside class="notice">
The maximum request size for an algorithm invocation is 10MiB.
</aside>

### Returns

```json
{
  "result": "Hello Neo",
  "metadata": {
    "content_type": "text",
    "duration": 0.0002127,
    "stdout": "Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF8"
  }
}
```

Depending on the configuration of the `output` query parameter, you may either receive an invocation result object or the raw output of the algorithm.

#### Invocation Result Object

|Attribute|Type|Description|
|-|-|-|
|`async`|Boolean|Specifies whether the invocation was run asynchronously, e.g. if the `output` query parameter was set to `void`.|
|`error.message`|String|A human-readable message describing the error encountered while running the algorithm, if any.|
|`error.stacktrace`|String|The stacktrace of the error encountered while running the algorithm, if any. Only returned if the caller has access to the algorithm's source code.|
|`metadata.content_type`|String|One of `binary`, `json`, `text`, or `void` (if the algorithm provided no response).|
|`metadata.duration`|Number|The duration of the algorithm invocation, in seconds.|
|`metadata.stdout`|String|The data piped to the algorithms `stdout` stream during execution. Only provided if the `stdout` query parameter was set to `true` and the caller is the algorithm's owner.|
|`request_id`|String|The unique ID for the invocation request.|
|`result`|String or Object|The result of the algorithm invocation if `output` was not set to either `void` or `raw`. Returned as an object if `metadata.content_type` is set to `json`, or as a Base64-encoded string if `metadata.content_type` is set to `binary`.|

## Get an algorithm

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname \
  -H 'Authorization: Simple API_KEY'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

algo = client.algo(':username/:algoname')

print(algo.info()) # Prints an algorithm object
```

`GET /v1/algorithms/:username/:algoname`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to retrieve.|

### Returns 

```json
{
  "name": "my_first_algorithm",
  "details": {
    "label": "My First Algorithm"
  },
  "settings": {
    "algorithm_callability": "private",
    "source_visibility": "closed",
    "language": "java",
    "environment": "cpu",
    "license": "apl",
    "network_access": "full",
    "pipeline_enabled": true
  },
  "source": {
    "scm": {
      "id": "internal",
      "provider": "internal",
      "default": true,
      "enabled": true
    }
  },
  "resource_type": "algorithm"
}
```

An [algorithm object](#the-algorithm-object) upon success, otherwise an [error](#errors).

## Update an algorithm

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname \
  -X PUT
  -H 'Authorization: Simple API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "details": {
      "label": "My Updated Algorithm"
    },
    "settings": {
      "environment": "gpu",
      "license": "apl",
      "network_access": "full",
      "pipeline_enabled": true,
      "source_visibility": "closed"
    }
  }'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

algo = client.algo(':username/:algoname')

algo.update(
  details = {
    "label": "My Updated Algorithm"
  },
  settings = {
    "environment": "gpu",
    "license": "apl",
    "network_access": "full",
    "pipeline_enabled": True,
    "source_visibility": "closed"
  }
)
```

`PUT /v1/algorithms/:username/:algoname`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to update.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`details.label`|String|The human-readable name for your algorithm.|
|`details.summary`|String|A full description of your algorithm's capabilitities. HTML is accepted for rendering in the algorithm's "Docs" tab.|
|`details.tagline`|String|A short description of your algorithm for display under the algorithm's label.|
|`settings.environment`|String|*Required if `settings.language` is specified.* The hardware your algorithm will run on. Choose from `cpu` or `gpu`.|
|`settings.license`|String|*Required*. The license for your algorithm's source code. Choose from [`apl`](https://algorithmia.com/api_dev_terms), [`apache2`](https://www.apache.org/licenses/LICENSE-2.0), [`gpl3`](https://www.gnu.org/licenses/gpl-3.0.en.html) or [`mit`](https://opensource.org/licenses/MIT). Select `apl` if you wish for your algorithm's source code to be closed-source.|
|`settings.network_access`|String|*Required*. Specifies whether the algorithm will have access to the public internet upon execution. Choose from `full` or `isolated`.|
|`settings.package_set`|String|*Required if `settings.package_set` was previously specified.* Specifies the package set that should define the algorithm's build and runtime environments.|
|`settings.pipeline_enabled`|Boolean|*Required*. Specifies whether this algorithm is allowed to call other algorithms on the platform.|
|`settings.source_visibility`|String|*Required*. Specifies whether the source code for this algorithm will be viewable by any user of the platform. If creating an algorithm with an external repository host, such as GitHub, determines whether the repo is created as public or private. Choose from `open` or `closed`.|

### Returns

```json
{
  "name": "my_algorithm",
  "details": {
    "label": "My Updated Algorithm"
  },
  "settings": {
    "algorithm_callability": "private",
    "source_visibility": "closed",
    "language": "java",
    "environment": "gpu",
    "license": "apl",
    "network_access": "full",
    "pipeline_enabled": true
  },
  "source": {
    "scm": {
      "id": "internal",
      "provider": "internal",
      "default": true,
      "enabled": true
    }
  },
  "resource_type": "algorithm"
}
```

The updated [algorithm object](#the-algorithm-object) upon success, otherwise an [error](#errors).

## Compile an algorithm

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname/compile \
  -X POST
  -H 'Authorization: Simple API_KEY'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

algo = client.algo(':username/:algoname')

algo.compile() # Returns an algorithm object upon successful compilation.
```

`POST /v1/algorithms/:username/:algoname/compile`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to compile.|

### Returns 

```json
{
    "name": "Hello",
    "details": {
      "label": "Greeting Algorithm"
    },
    "settings": {
      "algorithm_callability": "public",
      "source_visibility": "closed",
      "language": "python3-1",
      "environment": "gpu",
      "license": "apl",
      "network_access": "full",
      "pipeline_enabled": true
    },
    "version_info": {
      "git_hash": "6d50c89cb1d9eef506f9339af0c47f384ba71258"
    },
    "source": {
      "scm": {
        "id": "internal",
        "provider": "internal",
        "default": true,
        "enabled": true
      }
    },
    "compilation": {
      "successful": true,
      "output": "Building algorithm ..."
    },
    "self_link": "http://api.algorithmia.com/v1/algorithms/demo/Hello/versions/6d50c72cb1d9eef507f9339af0c47f484ba71258",
    "resource_type": "algorithm"
}
```

An [algorithm object](#the-algorithm-object) upon successful compilation, otherwise an [error](#errors). Note that the values contained within the `compilation` object will have been updated.

## Delete an algorithm

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname \
  -X DELETE \
  -H 'Authorization: Simple API_KEY'
```

```python
# Deleting an algorithm is not yet supported by our Python client library.
```

`DELETE /v1/algorithms/:username/:algoname`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to delete.|

### Returns 

An empty response upon success, otherwise an [error](#errors).

## Get algorithm SCM status

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname/scm/status \
  -H 'Authorization: Simple API_KEY'
```

```python
# Obtaining an algorithm's SCM status is not yet supported via our Python client library.
```

`GET /v1/algorithms/:username/:algoname/scm/status`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to check the SCM status for.|

### Returns

```json
{
    "scm_connection_status": "active",
    "repository_public_deploy_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCr2Hmsh5aTeHab+zMARTWpfUGk8Dfff0IicY7L8wMuQETyTSHcphN7CdJtCl3/nk45cz+DqH3tn1lOPXGPJghXYajtWJwwsGt5JS1y/gRiYvx67yYEy6RrSVV6JeMpbWasdfhjMdS533fjOnsFSkZPKv3GeVT5uOM4r29pjpTfQbZxC//iA0sv4Y/wECGOYnJWCmc6eU1faOaocsXW4pasdtAfC9D//eDfVbryBKisaStWPO5a5x1y45H1+0Ne4Rq5NV5BLaiISAP7L3i9A9O9mgddW3SufEZ+dt8cP8QmDgl2K39G7zfqD2TNhAHd7ToU8/7n9dp",
    "repository_webhook_secret": "8f63faa1-8e61-4272-8335-1aafb4a2b9289",
    "repository_webhook_url": "http://api.algorithmia.com/v1/algorithms/:username/:algoname/scm/webhook"
}
```

An object describing the algorithm's connection to its repository host, otherwise an [error](#errors). Be advised that, if your algorithm's repository is hosted externally, this payload will contain sensitive data about your algorithm's connection (such as the `repository_webhook_secret`).

|Attribute|Type|Description|
|-|-|-|
|`scm_connection_status`|String|The health of the algorithm's connection to its repository host. One of `active` (healthy), `deploy_key_error` (deploy key removed), or `provider_internal_error` (unknown error).|
|`repository_public_deploy_key`|String|The public deploy key used to establish secure SSH connections with the algorithm's external Git repository. Only present for algorithms with externally hosted Git repositories. Useful for reestablishing Algorithmia's ability to pull source code if the deploy key is accidentally deleted. [Click here](/developers/algorithm-development/source-code-management#your-repositorys-deploy-key-was-removed) to learn more.|
|`repository_webhook_secret`|String|The secret used to verify webhook payload generated by an external repository host. [Click here](/developers/algorithm-development/source-code-management#your-repositorys-webhook-needs-to-be-restored) to learn more.|
|`repository_webhook_url`|String|The URL called by an external repository host in the case that a change occurs to the repository (such as a commit or change to the default branch). [Click here](/developers/algorithm-development/source-code-management#your-repositorys-webhook-needs-to-be-restored) to learn more.|
