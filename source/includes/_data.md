# Data

### Connectors

Connectors offer you a convenient API by which to access data stored across multiple storage providers, from Algorithmia's built-in data store to Amazon S3. You can learn more about the connectors Algorithmia supports [in our documentation](/developers/data). The various connector types are identified as follows:

`data`: Algorithmia's built-in data storage solution.

`azureblob`: Microsoft Azure Blob Storage

`dropbox`: Dropbox

`gs`: Google Cloud Storage

`s3`: Amazon S3

With the exception of `data`, connectors may also be identified by a *label*, or no label if a specific connector is the default for its connector type. These options can be configured for a given connector in your [data portal](/data).

For example, if you create an S3 data connector with the label `test`, you would identify it to the API as `s3+test`. If you set your S3 data connector as the default S3 connector for your account, you would not need to supply this label.

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

Paths are contextual to the data connector you are interacting with. For example, paths for the `data` connector must begin first with the username of user who owns the collection you wish to interact with (or `.my` to refer to the calling user), then the collection name, then the file (`data` does not support directories within collections). However, when interacting with an `s3` connector, you must supply the name of the bucket as the first component of the data. Ensure you carefully read [the documentation](https://algorithmia.com/developers/data/) for the connector you are working with.

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
    "name": "example-folder",
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

client = Algorithmia.client('YOUR_API_KEY')

robots = client.dir("data://.my/robots")

robots.create(ReadAcl.public)
```

`POST /v1/connector/:connector_id/:connector_path`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`connector_id`|String|The ID of the specific connector you wish to create directory within. |
|`connector_path`|String|The path under which you wish to create the directory. Note that this path is contextual to the type of connector you are interacting with.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`name`|String|*Required*. The name of the directory you wish to create at the location specified by `connector_path`.|
|`acl.read`|Array|Used to set the ACL for [hosted data collections](/developers/data/hosted) only. There are three potential configurations for this field: |

### Returns

An empty response upon success, or an error otherwise.

## Get a file or folder

```shell
curl https://api.algorithmia.com/v1/connector/data/demo/example.png \
  -H 'Authorization: Simple API_KEY' \
  -H 'Content-Type: application/json' \
```

`GET /v1/connector/:connector_id/:connector_path`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`connector_id`|String|The ID of the specific connector you wish to retrieve data from.|
|`connector_path`|String|The connector path for which you wish to retrieve contents.|

### Returns

If the `connector_path` identifies a file, the file's contents will be returned to you if you have sufficient access.

If the `connector_path` identifies a folder, the folder's contents will be described in a JSON response.

|Attribute|Type|Description|
|-|-|-|
|`folders`|String|A list of zero or more folder stored at this path.|
|`files`|String|A list of zero or more files stored at this path.|

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

client = Algorithmia.client('YOUR_API_KEY')

# Uploading a local file
client.file("data://.my/robots/Optimus_Prime.png").putFile("/path/to/Optimus_Prime.png")

# Upload text
client.file("data://.my/robots/Optimus_Prime.txt").put("Leader of the Autobots")

# Uploading a dict as JSON
client.file("data://.my/robots/Optimus_Prime.json").putJson({"faction": "Autobots"})
```

`PUT /v1/connector/:connector_id/:connector_path`

### Payload Parameters

The body of the request will become the contents of the file that is created.

### Returns

```json
{
  "result": "data://demo/example_collection/example.png"
}
```

Returns the following JSON payload upon successful upload, otherwise an error.

|Attribute|Type|Description|
|-|-|-|
|`result`|String|The data URI of the resulting file.|

## Verify file existence

`HEAD /v1/connector/:connector_id/:connector_path`

## Delete a file or folder

...
