# Data

### Connectors

Connectors offer you a convenient API by which to access data stored across multiple storage providers, from Algorithmia's built-in data store to Amazon S3. You can learn more about the connectors Algorithmia supports [in our documentation](/developers/data). The various connector types are identified as follows:

- `data`: Algorithmia's built-in data storage solution.
- `azureblob`: Microsoft Azure Blob Storage
- `dropbox`: Dropbox
- `gs`: Google Cloud Storage
- `s3`: Amazon S3

With the exception of `data`, connectors may also be identified by a *label*, or no label if a specific connector is the default for its connector type. These options can be configured for a given connector in your [data portal](/data).

For example, if you create an S3 data connector with the label `test`, you would identify it to the API as `s3+test`. However, if a specific connector is the default for its type, you can omit the label and simply use the connector's type instead. Thus, your default S3 connector would be identified to the API as simply `s3`.

### Data URIs

```yaml
# Identifies a file housed by Algorithmia's internal storage provider (data://),
# which belongs to the user "demo" within their "example" collection.
data://demo/example/test.png

# Identifies a file housed in S3 (connected to via an S3 connector labeled "test"),
# which resides in the "my_bucket" bucket and "example" directory.
s3+test://my_bucket/example/test.png

# Identifies a file housed in a user's default Azure Blob data connector,
# which resides under the "example" directory within the relevant blob container.
azureblob://example/test.png
```

Algorithmia supports a *data URI* notation for identifying files and directories across connectors. To construct a data URI, take the unique identifer of a given connector (such as `data`, `azureblob`, or `s3+test`) and supply that as the URI's protocol. Then append the path to the file or directory you wish to act on. See examples to the right.

Algorithmia will return data URIs to you identifying new files or directories you may create, and you can use these in any of our client libraries (including our Python client library) to act on those resources.

Paths are contextual to the data connector you are interacting with. For example, paths for the `data` connector must begin first with the username of user who owns the collection you wish to interact with (or `.my` to refer to the calling user), then the collection name, then the file (`data` does not support directories within collections). However, when interacting with an `s3` connector, you must supply the name of the bucket as the first component of the data. Ensure you carefully read [the documentation](/developers/data) for the connector you are working with.

#### 
 
## The file object

```json
{
  "filename": "example.txt",
  "last_modified": "2020-03-18T17:00:33.000Z",
  "size": 20002
}
```

|Attribute|Type|Description|
|-|-|-|
|`filename`|String|The name of the file.|
|`last_modified`|String|The ISO 8601 datetime at which the file was last modified.|
|`size`|Number|The size of the file in bytes.|

## The folder object

```json
{
  "name": "example_folder"
}
```

|Attribute|Type|Description|
|-|-|-|
|`name`|String|The name of the folder.|

## Create a directory

```shell
curl https://api.algorithmia.com/v1/connector/data/demo \
  -X POST \
  -H 'Authorization: Simple API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "example_collection",
    "acl": {
      "read": [
        "user://*"
      ]
    }
  }'
```

```python
import Algorithmia
from Algorithmia.acl import ReadAcl

client = Algorithmia.client('API_KEY')

example_collection = client.dir("data://demo/example_collection")

example_collection.create(ReadAcl.public)
```

`POST /connector/:connector_id/:connector_path`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`connector_id`|String|The ID of the specific connector you wish to create directory within. Learn more in the [connectors section](#connectors) above.|
|`connector_path`|String|The path under which you wish to create the directory. Note that this path is contextual to the type of connector you are interacting with.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`name`|String|*Required*. The name of the directory you wish to create at the location specified by `connector_path`.|
|`acl.read`|Array|Used to set the ACL for [hosted data collections](/developers/data/hosted) only. Choose from `[]` (only you may access), `["algo://.my/*"]` (only your algorithms may access), and `["user://*"]` (any user may access).|

### Returns

```json
{
  "result": "data://demo/example_collection"
}
```

Returns the following JSON payload upon successful directory creation, otherwise an [error](#errors).

|Attribute|Type|Description|
|-|-|-|
|`result`|String|The data URI of the resulting directory.|

## Get a file or directory

```shell
curl https://api.algorithmia.com/v1/connector/data/demo/example.png \
  -H 'Authorization: Simple API_KEY'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

# Download file and get the file handle
exampleFile = client.file("data://demo/example_collection/example.png").getFile()

# Get file's contents as a string
exampleText = client.file("data://demo/example_collection/example.txt").getString()

# Get local file's contents as a string
exampleText = client.file("file://example.txt").getString()

# Get file's contents as JSON
exampleJson =  client.file("data://demo/example_collection/example.txt").getJson()

# Get file's contents as a byte array
exampleBytes = client.file("data://demo/example_collection/example.png").getBytes()
```

`GET /connector/:connector_id/:connector_path`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`connector_id`|String|The ID of the specific connector you wish to retrieve data from. Learn more in the [connectors section](#connectors) above.|
|`connector_path`|String|The connector path for which you wish to retrieve contents.|

### Returns

If the `connector_path` identifies a file, the file's contents will be returned to you, and a `X-Data-Type` response header will be returned with the value `file`.

If the `connector_path` identifies a folder, the folder's contents will be described by the following JSON structure, and a `X-Data-Type` response header will be returned with the value `directory`.

|Attribute|Type|Description|
|-|-|-|
|`folders`|String|A list of zero or more [folders](#the-folder-object) stored at this path.|
|`files`|String|A list of zero or more [files](#the-file-object) stored at this path.|

Otherwise, an [error object](#errors) will be returned to you.

## Update collection ACL

```shell
curl https://api.algorithmia.com/v1/connector/data/demo/example_collection \
  -X PATCH \
  -H 'Authorization: Simple API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "acl": {
      "read": []
    }
  }'
```

```python
import Algorithmia
from Algorithmia.acl import ReadAcl

client = Algorithmia.client('API_KEY')

example_collection = client.dir("data://demo/example_collection")

example_collection.update_permissions(ReadAcl.private)
```

`POST /connector/data/:username/:collection`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|The unique ID of the user or organization who owns the collection you wish to update.|
|`collection`|String|The name of the hosted data collection you wish to update.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`acl.read`|Array|*Required*. Choose from `[]` (only you may access), `["algo://.my/*"]` (only your algorithms may access), and `["user://*"]` (any user may access).|

### Returns

An empty response upon success, accompanied by a `200` status code, otherwise an [error](#errors).

## Upload a file

```shell
# Uploading text
curl https://api.algorithmia.com/v1/connector/data/demo/example_collection/example.txt \
  -X PUT \
  -H 'Authorization: Simple API_KEY' \
  -d 'Leader of the Autobots'

# Uploading a local file
curl https://api.algorithmia.com/v1/connector/data/demo/example_collection/example.png \
  -X PUT \
  -H 'Authorization: Simple API_KEY' \
  --data-binary @example.png
```

```python
import Algorithmia
from Algorithmia.acl import ReadAcl

client = Algorithmia.client('API_KEY')

# Uploading a local file
client.file("data://demo/example_collection/example.png").putFile("/my/local/path")

# Uploading text
client.file("data://demo/example_collection/example.txt").put("Hello world!")

# Uploading a dict as JSON
client.file("data://demo/example_collection/example.json").putJson({"hello": "world"})
```

`PUT /connector/:connector_id/:connector_path`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`connector_id`|String|The ID of the specific connector you wish to create interact with. Learn more in the [connectors section](#connectors) above.|
|`connector_path`|String|The path at which your new file should exist. Note that this path is contextual to the type of connector you are interacting with.|

### Payload Parameters

The body of the request will become the contents of the file that is created.

### Returns

```json
{
  "result": "data://demo/example_collection/example.png"
}
```

Returns the following JSON payload upon successful upload, otherwise an [error](#errors).

|Attribute|Type|Description|
|-|-|-|
|`result`|String|The data URI of the resulting file.|

## Verify file existence

```shell
curl https://api.algorithmia.com/v1/connector/data/demo/example.png \
  -I \
  -H 'Authorization: Simple API_KEY'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

if client.file("data://demo/example_collection/example.png").exists():
  print("File exists!")
```

`HEAD /connector/:connector_id/:connector_path`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`connector_id`|String|The ID of the specific connector you wish to create interact with. Learn more in the [connectors section](#connectors) above.|
|`connector_path`|String|The path to the file or directory you wish to verify. Note that this path is contextual to the type of connector you are interacting with.|

### Returns

Returns an affirmative response if the file exists (such as a 200 status code), otherwise an [error](#errors).

## Delete a file or directory

```shell
curl https://api.algorithmia.com/v1/connector/data/demo/example_collection/example.txt \
  -X DELETE \
  -H 'Authorization: Simple API_KEY'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')

exampleFile = client.file("data://demo/example_collection/example.png")

exampleFile.delete()
```

`DELETE /connector/:connector_id/:connector_path`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`connector_id`|String|The ID of the specific connector you wish to create interact with. Learn more in the [connectors section](#connectors) above.|
|`connector_path`|String|The path to the file or directory you wish to delete. Note that this path is contextual to the type of connector you are interacting with.|

### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`force`|Boolean|If attempting to delete a non-empty directory, forces deletion. Defaults to `false`.|

### Returns

A JSON payload of the following structure if the request succeeds (or succeeds partially), otherwise an [error](#errors).

|Attribute|Type|Description|
|-|-|-|
|`result.deleted`|Number|If the deletion is successful, the total number of files deleted.|
|`error.deleted`|Number|If an error occurred during deletion, this property indicates how many files were deleted before the error occurred.|

