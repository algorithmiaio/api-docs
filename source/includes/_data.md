# Data

You may create and mangage data connectors via the Algorithmia web client. Take a look at our [documentation on data connectors](/developers/data) to learn more.

## Create a directory

```shell
curl https://api.algorithmia.com/v1/connector/data/demo \
  -X POST \
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

## Get path contents

`GET /v1/connector/:connector_id/:connector_path`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`connector_id`|String|The ID of the specific connector you wish to create directory within.|
|`connector_path`|String|The connector path for which you wish to retrieve contents.|

## Upload a file

`PUT /v1/connector/:connector_id/:connector_path`

## Verify file existence

`HEAD /v1/connector/:connector_id/:connector_path`

## Delete a file or folder

...
