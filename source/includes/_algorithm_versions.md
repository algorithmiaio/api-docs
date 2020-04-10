# Algorithm Versions

## The algorithm version object

Algorithm version objects are identical to the [algorithm object](#the-algorithm-object), with the sole difference being that algorithm versions must return values for the `build`, `compilation`, `self_link`, and `version_info` properties, given that they represent compiled, call-able instances of the algorithm.

## Publish an algorithm version

`POST /v1/algorithms/:username/:algoname/version`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to publish.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`settings.algorithm_callability`|String|*Required*. Whether this algorithm version will remain call-able by only the owner of the algorithm (either organization members or individual user), or whether it will be freely call-able by all Algorithmia platform users. Choose from `public` or `private`.|
|`version_info.version_type`|String|*Required*. The increase in semantic version you would like to be attributable to the version. Choose from `major`, `minor`, or `patch`.|

### Returns

Returns an [algorithm object](#the-algorithm-object) representing the published version, with its `version_info.semantic_version` property having been incremented appropriately from the previous published version (if any).

## List algorithm versions

`GET /v1/algorithms/:username/:algoname/versions`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to retrieve versions for.|

### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`limit`|Number|The maximum number of items to return in the response. Defaults to 10.|
|`marker`|String|Used for paginating results from previous queries. See the [versioning section](#versioning) above.|

### Returns

|Attribute|Type|Description|
|-|-|-|
|`marker`|String|If more results are available than can be shown based on the supplied `limit`, this value can be used to paginate results. See the [versioning section](#versioning) above.|
|`next_link`|String|A link to the next page of results, if more results exist.|
|`results`|Array|A list of zero or more [algorithm](#the-algorithm-build-object) objects representing versions of the algorithm.|

## Get algorithm version

`GET /v1/algorithms/:username/:algoname/versions/:git_hash`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The username of the user or organization that owns the algorithm.|
|`algoname`|String|*Required*. The name of the algorithm you wish to retrieve a version for.|
|`git_sha`|String|*Required*. The Git hash of the specific version you to retrieve (e.g. `version_info.git_hash`).|

## Returns

A single [algorithm object](#the-algorithm-object) representing the specific version you wished to retrieve.
