# Algorithm Builds

## The algorithm build object

```json
{
  "build_id": "132298b7-8ca4-40ca-bd2a-84254fd67a81",
  "commit_sha": "d2f4112966eb5bcc2a54693249d634372d8b788a",
  "finished_at": "2020-04-07T16:45:10.096Z",
  "resource_type": "algorithm_build",
  "started_at": "2020-04-07T16:45:10.096Z",
  "status": "succeeded",
  "version_info": {
    "semantic_version": "1.0.0"
  }
}
```

|Attribute|Type|Description|
|-|-|-|
|`build_id`|String|The unique identifier for this algorithm build.|
|`commit_sha`|String|The specific Git commit SHA that was built for this algorithm.|
|`finished_at`|String|The ISO 8601 datetime at which the build completed.|
|`resource_type`|String|Set to `algorithm_build` for algorithm build objects.|
|`started_at`|String|The ISO 8601 datetime at which the build began.|
|`status`|String|One of `failed`, `in-progress`, or `succeeded`.|
|`version_info.semantic_version`|String|The semantic version that this build was published as. Absent unless the build has been published as a public or private version.|

## List algorithm builds

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname/builds \
  -H 'Authorization: Simple API_KEY'
```

```python
# Listing algorithm builds is not yet supported via our Python client library.
```

`GET /algorithms/:username/:algoname/builds`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to retrieve builds for.|

### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`limit`|Number|The maximum number of items to return in the response. Defaults to 50.|
|`marker`|String|Used for paginating results from previous queries. See the [pagination section](#pagination) above.|

### Returns

```json
{
  "marker": null,
  "next_link": null,
  "results": [{
    "build_id": "132298b7-8ca4-40ca-bd2a-84254fd67a81",
    "commit_sha": "d2f4112966eb5bcc2a54693249d634372d8b788a",
    "finished_at": "2020-04-07T16:45:10.096Z",
    "resource_type": "algorithm_build",
    "started_at": "2020-04-07T16:45:10.096Z",
    "status": "succeeded",
    "version_info": {
      "semantic_version": "1.0.0"
    }
  }]
}
```

A collection of zero or more [algorithm builds](#the-algorithm-build-object), otherwise an [error](#errors).

|Attribute|Type|Description|
|-|-|-|
|`marker`|String|If more results are available than can be shown based on the supplied `limit`, this value can be used to paginate results. See the [pagination section](#pagination) above.|
|`next_link`|String|A link to the next page of results, if more results exist.|
|`results`|Array|A list of zero or more [algorithm build](#the-algorithm-build-object) objects for the algorithm.|

## Get an algorithm build

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname/builds/:build_id \
  -H 'Authorization: Simple API_KEY'
```

```python
# Obtaining an algorithm build is not yet supported via our Python client library.
```

`GET /algorithms/:username/:algoname/builds/:build_id`

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to retrieve a build for.|
|`build_id`|String|*Required*. The ID of the specific build you wish to retrieve.|

### Returns

```json
{
  "build_id": "132298b7-8ca4-40ca-bd2a-84254fd67a81",
  "commit_sha": "d2f4112966eb5bcc2a54693249d634372d8b788a",
  "finished_at": "2020-04-07T16:45:10.096Z",
  "resource_type": "algorithm_build",
  "started_at": "2020-04-07T16:45:10.096Z",
  "status": "succeeded",
  "version_info": {
    "semantic_version": "1.0.0"
  }
}
```

An [algorithm build](#the-algorithm-build-object) object, otherwise an [error](#errors).

## Get algorithm build logs

```shell
curl https://api.algorithmia.com/v1/algorithms/:username/:algoname/builds/:build_id/logs \
  -H 'Authorization: Simple API_KEY'
```

```python
# Obtaining an algorithm build's logs is not yet supported via our Python client library.
```

`GET /algorithms/:username/:algoname/builds/:build_id/logs`

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to retrieve a build for.|
|`build_id`|String|*Required*. The ID of the specific build you wish to retrieve logs for.|

### Returns

```json
{
  "logs": "Building algorithm..."
}
```

An object containing the logs for an algorithm build, otherwise an [error](#errors). Note that, until a build's `status` attribute transitions to either `succeeded` or `failed`, logs will not be available, and requesting logs for a build will result in a 404 response.

|Attribute|Type|Description|
|-|-|-|
|`logs`|String|The logs for the algorithm build.|

## List algorithm builds by algorithm UUID

```shell
curl https://api.algorithmia.com/v1/algorithms/:algorithmId/builds \
  -H 'Authorization: Simple API_KEY'
```

```python
# Listing algorithm builds is not yet supported via our Python client library.
```

`GET /algorithms/:algorithmId/builds`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`algorithmId`|String|*Required*. Algorithm UUID to assign a collection to.|


### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`limit`|Number|The maximum number of items to return in the response. Defaults to 50.|
|`marker`|String|Used for paginating results from previous queries. See the [pagination section](#pagination) above.|

### Returns

```json
{
  "marker": null,
  "next_link": null,
  "results": [{
    "build_id": "132298b7-8ca4-40ca-bd2a-84254fd67a81",
    "commit_sha": "d2f4112966eb5bcc2a54693249d634372d8b788a",
    "finished_at": "2020-04-07T16:45:10.096Z",
    "resource_type": "algorithm_build",
    "started_at": "2020-04-07T16:45:10.096Z",
    "status": "succeeded",
    "version_info": {
      "semantic_version": "1.0.0"
    }
  }]
}
```

A collection of zero or more [algorithm builds](#the-algorithm-build-object), otherwise an [error](#errors).

|Attribute|Type|Description|
|-|-|-|
|`marker`|String|If more results are available than can be shown based on the supplied `limit`, this value can be used to paginate results. See the [pagination section](#pagination) above.|
|`next_link`|String|A link to the next page of results, if more results exist.|
|`results`|Array|A list of zero or more [algorithm build](#the-algorithm-build-object) objects for the algorithm.|

## Get an algorithm build by algorithm UUID

```shell
curl https://api.algorithmia.com/v1/algorithms/:algorithmId/builds/:build_id \
  -H 'Authorization: Simple API_KEY'
```

```python
# Obtaining an algorithm build is not yet supported via our Python client library.
```

`GET /algorithms/:algorithmId/builds/:build_id`

|Parameter|Type|Description|
|-|-|-|
|`algorithmId`|String|*Required*. Algorithm UUID to assign a collection to.|
for.|
|`build_id`|String|*Required*. The ID of the specific build you wish to retrieve.|

### Returns

```json
{
  "build_id": "132298b7-8ca4-40ca-bd2a-84254fd67a81",
  "commit_sha": "d2f4112966eb5bcc2a54693249d634372d8b788a",
  "finished_at": "2020-04-07T16:45:10.096Z",
  "resource_type": "algorithm_build",
  "started_at": "2020-04-07T16:45:10.096Z",
  "status": "succeeded",
  "version_info": {
    "semantic_version": "1.0.0"
  }
}
```

An [algorithm build](#the-algorithm-build-object) object, otherwise an [error](#errors).

## Get algorithm build logs by algorithm UUID

```shell
curl https://api.algorithmia.com/v1/algorithms/:algorithmId/builds/:build_id/logs \
  -H 'Authorization: Simple API_KEY'
```

```python
# Obtaining an algorithm build's logs is not yet supported via our Python client library.
```

`GET /algorithms/:algorithmId/builds/:build_id/logs`

|Parameter|Type|Description|
|-|-|-|
|`algorithmId`|String|*Required*. Algorithm UUID to assign a collection to.|
for.|
|`build_id`|String|*Required*. The ID of the specific build you wish to retrieve logs for.|

### Returns

```json
{
  "logs": "Building algorithm..."
}
```

An object containing the logs for an algorithm build, otherwise an [error](#errors). Note that, until a build's `status` attribute transitions to either `succeeded` or `failed`, logs will not be available, and requesting logs for a build will result in a 404 response.

|Attribute|Type|Description|
|-|-|-|
|`logs`|String|The logs for the algorithm build.|
