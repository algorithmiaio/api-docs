# Algorithm Versions

## The algorithm version object

```json
{
  "build": {
    "build_id": "j85f8087db281388d79fb224853864da73bff865",
    "commit_sha": "j85f8087db281388d79fb224853864da73bff865",
    "finished_at": "2019-05-07T21:16:43.121Z",
    "resource_type": "algorithm_build",
    "started_at": "2019-05-07T21:16:40.148Z",
    "status": "succeeded",
    "version_info": {
      "semantic_version": "0.1.0"
    }
  },
  "compilation": {
    "output": "Algorithm building...",
    "successful": true
  },
  "details": {
    "label": "Greeting Algorithm"
  },
  "name": "Hello",
  "resource_type": "algorithm",
  "settings": {
    "algorithm_callability": "public",
    "source_visibility": "closed",
    "language": "python3-1",
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
  "version_info": {
    "git_hash": "j85f8087db281388d79fb224853864da73bff865",
    "release_notes": "A few bug fixes",
    "sample_input": "testing",
    "semantic_version": "0.1.0"
  }
}
```

Algorithm version objects are identical to [algorithm objects](#the-algorithm-object), with the sole difference being that algorithm versions must return values for the `build`, `compilation`, `self_link`, and `version_info` properties, given that they represent compiled, call-able instances of the algorithm.

## Publish an algorithm version

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname/versions \
  -X POST \
  -H 'Authorization: Simple API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "settings": {
      "algorithm_callability": "private"
    },
    "version_info": {
      "version_type": "minor",
      "release_notes": "A few bug fixes.",
      "sample_input": "42"
    }
  }'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

algo = client.algo(':username/:algoname')

algo.publish(
  settings = {
    "algorithm_callability": "private"
  },
  version_info = {
    "release_notes": "A few bug fixes.",
    "sample_input": "testing",
    "version_type": "minor"
  }
)
```

`POST /algorithms/:username/:algoname/versions`

<aside class="notice">
You may only publish the most recent compiled version of an algorithm. If the most recent compiled version has already been published, you will need to <a href="#compile-an-algorithm">recompile your algorithm</a> in order to publish a new version. 
</aside>

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to publish.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`settings.algorithm_callability`|String|*Required*. Whether this algorithm version will remain call-able by only the owner of the algorithm (either organization members or individual user), or whether it will be freely call-able by all Algorithmia platform users. Choose from `public` or `private`.|
|`version_info.release_notes`|String|Describes any changes introduced by this version.|
|`version_info.sample_input`|String|An example of a valid text input to the algorithm.|
|`version_info.version_type`|String|*Required*. The increase in semantic version you would like to be attributable to the version. Choose from `major`, `minor`, or `patch`. Note that, depending on changes you've made recently to algorithm, you may be required to choose `minor` or `major`. Read our [algorithm versioning docs](/developers/platform/versioning) to learn more.|

### Returns

```json
{
  "build": {
    "build_id": "j85f8087db281388d79fb224853864da73bff865",
    "commit_sha": "j85f8087db281388d79fb224853864da73bff865",
    "finished_at": "2019-05-07T21:16:43.121Z",
    "resource_type": "algorithm_build",
    "started_at": "2019-05-07T21:16:40.148Z",
    "status": "succeeded",
    "version_info": {
      "semantic_version": "0.1.0"
    }
  },
  "compilation": {
    "output": "Algorithm building...",
    "successful": true
  },
  "details": {
    "label": "Greeting Algorithm"
  },
  "name": "Hello",
  "resource_type": "algorithm",
  "settings": {
    "algorithm_callability": "public",
    "source_visibility": "closed",
    "language": "python3-1",
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
  "version_info": {
    "git_hash": "j85f8087db281388d79fb224853864da73bff865",
    "release_notes": "A few bug fixes",
    "sample_input": "testing",
    "semantic_version": "0.1.0"
  }
}
```

Returns an [algorithm object](#the-algorithm-object) representing the published version, with its `version_info.semantic_version` property having been incremented appropriately from the previous published version (if any). If the request was unsuccessful, and [error](#errors) will be returned.

## List algorithm versions

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname/versions \
  -H 'Authorization: Simple API_KEY'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

algo = client.algo(':username/:algoname')

# Query parameters may be passed as options.
# Prints the last ten versions of the algorithm.
print(algo.versions(limit=10))
```

`GET /algorithms/:username/:algoname/versions`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to retrieve versions for.|

### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`callable`|Boolean|Whether to return only public or private algorithm versions. `true` maps to algorithm versions with `algorithm_callability` set to `public`, whereas `false` maps to `private`. Omitting this parameter results in versions with both `public` and `private` being returned.|
|`limit`|Number|The maximum number of items to return in the response. Defaults to 50.|
|`published`|Boolean|Whether to return only versions that have been published (e.g. have an associated semantic version). `true` will return only published versions, and `false` will return only unpublished versions. Omitting this parameter results in both published and unpublished versions being returned.|
|`marker`|String|Used for paginating results from previous queries. See the [versioning section](#versioning) above.|

### Returns

```json
{
  "marker": null,
  "next_link": null,
  "results": [{
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
      "output": "Algorithm building...",
      "successful": true
    },
    "details": {
      "label": "Greeting Algorithm"
    },
    "name": "Hello",
    "resource_type": "algorithm",
    "settings": {
      "algorithm_callability": "public",
      "source_visibility": "closed",
      "language": "python3-1",
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
    "version_info": {
      "git_hash": "j85f8087db281388d79fb224853864da73bff865",
      "release_notes": "A few bug fixes",
      "sample_input": "testing",
      "semantic_version": "0.1.0"
    }
  }]
}
```

A collection of [algorithm](#the-algorithm-build-object) objects, otherwise an [error](#errors).

|Attribute|Type|Description|
|-|-|-|
|`marker`|String|If more results are available than can be shown based on the supplied `limit`, this value can be used to paginate results. See the [versioning section](#versioning) above.|
|`next_link`|String|A link to the next page of results, if more results exist.|
|`results`|Array|A list of [algorithm](#the-algorithm-build-object) objects representing versions of the algorithm.|

## Get algorithm version

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname/versions/:git_hash \
  -H "Authorization: Simple API_KEY"
```

```python
# Querying information about a single build is not currently supported in our Python client library.
```

`GET /algorithms/:username/:algoname/versions/:git_hash`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to retrieve a version for.|
|`git_sha`|String|*Required*. The Git hash of the specific version you to retrieve (e.g. `version_info.git_hash`).|

### Returns

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
    "output": "Algorithm building...",
    "successful": true
  },
  "details": {
    "label": "Greeting Algorithm"
  },
  "name": "Hello",
  "resource_type": "algorithm",
  "settings": {
    "algorithm_callability": "public",
    "source_visibility": "closed",
    "language": "python3-1",
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
  "version_info": {
    "git_hash": "j85f8087db281388d79fb224853864da73bff865",
    "release_notes": "A few bug fixes",
    "sample_input": "testing",
    "semantic_version": "0.1.0"
  }
}
```

A single [algorithm object](#the-algorithm-object) representing the specific version you wished to retrieve, otherwise an [error](#errors).
