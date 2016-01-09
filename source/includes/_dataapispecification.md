# Data API Specification

```javascript
/*
  The Javascript client does not currently have support for the Data API.
  Contact us if you need this feature and we'll prioritize it right away:
  https://algorithmia.com/contact

  Note: The NodeJS client does currently support the Data API.
*/
```

## Directories

Directories are a collection of files or other directories.

<aside class="notice">
  It is very common to use the <code>.my</code> pseudonym as the owner of a directory to indicate the authenticated user.
</aside>

### Listing a directory

> Listing a directory:

```shell
# List top-level user directory
curl -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/data/.my

-> {
    "folders": [
        { "name": "robots" },
        { "name": "cats" }
    ]
}

# List a directory with ACLs
curl -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/data/.my/robots?acl=true

-> {
    "files": [
        {
            "filename": "R2-D2.txt",
            "last_modified": "2016-01-06T00:52:34.000Z"
            "size": 48
        },
        {
            "filename": "T-800.txt",
            "last_modified": "2016-01-06T00:52:34.000Z"
            "size": 36
        }
    ],
    "acl": {
        "read": [ "algo://.my/*" ]
    },
    "marker": "12-abcdefgj9ao72LHhjglh3AcRtCuf7T1FeSoZTA1gycqRHaDrdp254LV9S1LjKgQZ"
}
```
```python
# Support for listing directories from the python client is planned.
# Contact us if you need this feature, and we'll prioritize it right away:
# https://algorithmia.com/contact
```

```java
import com.algorithmia.*;
import com.algorithmia.data.*;

// List top level directories
DataDirectory myRoot = client.dir("data://.my");
for(DataDirectory dir : myRoot.getDirIter()) {
    System.out.println("Directory " + dir.toString() + " at URL " + dir.url());
}

// List files in the 'robots' directory
DataDirectory robots = client.dir("data://.my/robots");
for(DataFile file : robots.getFileIter()) {
    System.out.println("File " + file.toString() + " at URL: " + file.url());
}
```

```scala
import com.algorithmia._
import com.algorithmia.data._

// List top level directories
val myRoot = client.dir("data://.my")
for(dir <- myRoot.getDirIter) {
  println(s"Directory ${dir.toString} at URL: ${dir.url}")
}

// List files in the 'robots' directory
val robots = client.dir("data://.my/robots")
for(file <- robots.getFileIter) {
  println(s"File ${file.toString} at URL: ${file.url}")
}
```

```nodejs
// List top level directories
client.dir("data://.my").forEachDir(function(err, dir) {
    if(err) {
        return console.log("Error: " + JSON.stringify(err));
    }

    console.log(dir.data_path);
}).then(function() {
    console.log("Finished listing directory");
});


// List files in the 'robots' directory
client.dir("data://.my/robots").forEachFile(function(err, file) {
    if(err) {
        return console.log("Error: " + JSON.stringify(err));
    }

    console.log(file.data_path);
}).then(function() {
    console.log("Finished listing directory");
});


```

To list contents of a directory through the Algorithmia Data API, use the following endpoints:

`GET https://api.algorithmia.com/api/v1/data/:owner`

`GET https://api.algorithmia.com/api/v1/data/:owner/:directory`

#### Query Parameters
Parameters | Description
---------------- | -----------
marker | Indicates the page of results to return. Only valid when using markers previously returned by this API. If this parameter is omited then the first page is returned
acl | Include the directory ACL in the response (Default = false)

#### Response

> Listing a directory output:

```json
{
    "folders": [
        {
            "name": String
        }
    ], /* Optional */
    "files": [
        {
            "filename": String,
            "last_modified": String, /* ISO-8601 */
            "size": Long /* Number of bytes */
        }
    ], /* Optional */
    "marker": String, /* Optional */
    "acl": {
        "read": [
            String
        ]
    } /* Optional */
}
```

Attribute | Description
--------- | -----------
folders | [Optional] array of subdirectories
files | [Optional] array of files in directory. `last_modified` is an ISO-8601 timestamp and `size` is measured in bytes
marker | [Optional] string that indicates there are more files or folders within this directory that can be queried for using the marker query parameter
acl.read | [Optional] array of ACL strings defining who has read permissions to this directory. Explanation of ACL strings provided below.

<aside class="notice">
  Most of the clients opt to abstract directory listing into an iterator over files and folders within the directory while hiding the marker-based pagination that happens in the background.
</aside>

**ACL Strings:**

  * `user://*`: Readable by anyone (public)
  * `algo://.my/*`: Readable by your algorithms (default)
  * Fully private is represented as an empty list
  * No other ACL strings are currently supported

**Response Headers:**

`X-Data-Type: directory`


### Creating a directory

> Creating a directory:

```shell
# Create a directory named 'robots'
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -H 'Content-Type: application/json' \
    -d '{"name": "robots"}' \
    https://api.algorithmia.com/v1/data/.my
# Empty 200 response on success

# Create a publicly accessible directory named 'public_robots'
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -H 'Content-Type: application/json' \
    -d '{"name": "public_robots", "acl": {"read": ["user://*"]}}' \
    https://api.algorithmia.com/v1/data/.my
# Empty 200 response on success
```

```python
# Support for creating directories from the python client is planned.
# Contact us if you need this feature, and we'll prioritize it right away:
# https://algorithmia.com/contact
```

```java
DataDirectory robots = client.dir("data://.my/robots");
robots.create();
```

```scala
let robots = client.dir("data://.my/robots")
robots.create()
```

```nodejs
var robots = client.dir("data://.my/robots");
robots.create(function(response) {
    if(response.error) {
        return console.log("Failed to create dir: " + response.error.message);
    }
    console.log("Created directory: " + robots.data_path);
});
```

To create a directory through the Algorithmia Data API, use the following endpoint:

`POST https://api.algorithmia.com/v1/data/:owner`

#### JSON Input
Attribute | Description
--------- | -----------
name      | Name of the directory to create
acl       | [Optional] JSON object specifying permissions of the directory

<aside class="notice">
    Currently directories may only be created within the top-level user directory.
</aside>

**Required Header:** `Content-Type: application/json`

**ACL Attribute:**

Permission for a directory are determined by setting `acl.read` to an array of ACL strings:

  * `user://*`: Readable by anyone (public)
  * `algo://.my/*`: Readable by your algorithms (default)
  * Fully private is represented as an empty list
  * No other ACL strings are currently supported

Example: `"acl": {"read": []}` implies the directory is fully private

<aside class="notice">
    Write ACLs are not currently configurable. Only the directory owner has write access to a directory.
</aside>

#### Response:

Empty 200 response on success


### Updating a directory

> Updating a directory:

```shell
curl -X PATCH -H 'Authorization: Simple YOUR_API_KEY' \
    -H 'Content-Type: application/json' \
    -d '{"acl": {"read": ["user://*"]}}' \
    https://api.algorithmia.com/v1/data/.my
# Empty 200 response on success
```

To update a directory, use the following API:

`PATCH https://api.algorithmia.com/v1/data/:owner/:directory`

#### Input:
Input is JSON and requires the Content-Type header: `"application/json"`

Attribute | Description
--------- | -----------
acl       | [Optional] JSON object specifying permissions of the directory

**ACL Attribute:**

Permission for a directory are determined by setting `acl.read` to an array of ACL strings:

  * `user://*`: Readable by anyone (public)
  * `algo://.my/*`: Readable by your algorithms (default)
  * Fully private is represented as an empty list
  * No other ACL strings are currently supported

Example: `"acl": {"read": []}` implies the directory is fully private

#### Output:

Empty 200 response on success

### Deleting a directory

> Deleting a directory

```shell
# Delete the empty directory data://.my/public_robots
curl -X DELETE -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/data/.my/public_robots

-> { "result": { "deleted": 0 }}

# Force delete the directory data://.my/robots even if it contains files
curl -X DELETE -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/data/.my/robots?force=true

-> { "result": { "deleted": 25 }}
```

```python
# Support for deleting directories from the python client is planned.
# Contact us if you need this feature, and we'll prioritize it right away:
# https://algorithmia.com/contact
```

```java
DataDirectory robots = client.dir("data://.my/robots");
robots.delete(false);
// use `true` to force deletion even if dir contains files
```

```scala
let robots = client.dir("data://.my/robots")
robots.delete(false)
// use `true` to force deletion even if dir contains files
```

```nodejs
var robots = client.dir("data://.my/robots");
robots.delete(false, function(response) {
    if(response.error) {
        return console.log("Failed to delete dir: " + response.error.message);
    }
    console.log("Deleted directory: " + robots.data_path);
});
/*
  Use `robots.delete(true, callback)`
  to force deletion even if dir contains files
*/
```

To delete a directory, use the following endpoint:

`DELETE https://api.algorithmia.com/v1/data/:owner/:directory`

#### Query Paramters

Parameters | Description
---------------- | -----------
force            | if true, enables recursive delete of a non-empty directory


#### Response

> Deleting a directory output:

```
{
    "result": {
        "deleted": Long /* Number of files successfully deleted */
    }, /* Optional */
    "error": {
        "message": String,
        "deleted": Long /* Number of files successfully deleted */
    } /* Optional */
}
```

Attribute | Description
--------- | -----------
result.deleted  | The number of files successfully deleted
error.deleted   | The number of files successfully deleted if an error encountered during deletion


## Files

### Getting a file

> Getting a file:

```shell
curl -O -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/data/.my/robots/T-800.png
# Downloaded to `T-800.png` in local working directory
```

```python
# Download file and get the file handle
t800File = client.file("data://.my/robots/T-800.png").getFile()

# Get file's contents as a string
t800Text = client.file("data://.my/robots/T-800.txt").getString()

# Get file's contents as JSON
t800Json =  client.file("data://.my/robots/T-800.txt").getJson()

# Get file's contents as a byte array
t800Bytes = client.file("data://.my/robots/T-800.png").getBytes()
```

```java
DataDirectory robots = client.dir("data://.my/robots");

// Download file and get the file handle
File t800File = robots.file("T-800.png").getFile();

// Get the file's contents as a string
String t800Text = robots.file("T-800.txt").getString();

// Get the file's contents as a byte array
byte[] t800Bytes = robots.file("T-800.png").getBytes();
```

```scala
let robots = client.dir("data://.my/robots")

// Download file and get the file handle
let t800File = robots.file("T-800.png").getFile()

// Get the file's contents as a string
let t800Text = robots.file("T-800.txt").getString()

// Get the file's contents as a byte array
let t800Bytes = robots.file("T-800.png").getBytes()
```

```nodejs
var robots = client.dir("data://.my/robots");

// Get the file's contents as a string
robots.file("T-800.txt").getString(function(response) {
	console.log(response);
});

// Get a JSON file's contents as a JS object
robots.file("T-800.json").getJson(function(response) {
	console.log(response);
});
```

To retieve a file through the Algorithmia Data API, use the following endpoint:

`GET https://api.algorithmia.com/v1/data/:owner/:directory/:file_name`

#### Response

Upon 200 success, response body is the content of the file.

**Response Headers:**

`X-Data-Type: file`


### Check if file exists

> Checking if a file exists:

```shell
curl -I -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/data/.my/robots/HAL9000.png

->
HTTP/1.1 200 OK
Content-Length: 0
ETag: d41d8cd98f00b204e9800998ecf8427e
Strict-Transport-Security: max-age=0; includeSubDomains; preload
X-Data-Type: file
X-Frame-Options: DENY
Connection: keep-alive
```

```python
if client.file("data://.my/robots/T-800.png").exists()
    print("HAL 9000 exists")
```

```java
if(client.file("data://.my/robots/HAL_9000.png")){
    System.out.println("HAL 9000 exists");
}
```

```scala
if(client.file("data://.my/robots/HAL_9000.png")){
    System.out.println("HAL 9000 exists")
}
```

```nodejs
var hal = client.file("data://.my/robots/HAL_9000.png");

hal.exists(function(exists) {
    if(exists) {
        console.log("HAL 9000 exists");
    }
});
```

To check if a file exists without downloading it, use the following endpoint:

`HEAD https://api.algorithmia.com/v1/data/:owner/:directory/:file_name`


#### Response

200 success indicates the file exists

**Response Headers:**

* `X-Data-Type: file`
* `X-Error-Message: <Error message if error occurs>`

### Upload a file

> Uploading a file:

```shell
# Write a text file
curl -X PUT -H 'Authorization: Simple YOUR_API_KEY' \
    -d 'Leader of the Autobots' \
    https://api.algorithmia.com/v1/data/.my/robots/Optimus_Prime.txt

-> { "result": "data://.my/robots/Optimus_Prime.txt" }

# Upload local file
curl -X PUT -H 'Authorization: Simple YOUR_API_KEY' \
    --data-binary @Optimus_Prime.png \
    https://api.algorithmia.com/v1/data/.my/robots/Optimus_Prime.png

-> { "result": "data://.my/robots/Optimus_Prime.png" }
```

```python
# Upload local file
client.file("data://.my/robots/Optimus_Prime.png").putFile("/path/to/Optimus_Prime.png")
# Write a text file
client.file("data://.my/robots/Optimus_Prime.txt").put("Leader of the Autobots")
# Write a dict to a JSON file
client.file("data://.my/robots/Optimus_Prime.json").putJson({"faction": "Autobots"})
```

```java
DataDirectory robots = client.dir("data://.my/robots");

// Upload local file
robots.putFile(new File("/path/to/Optimus_Prime.png"));
// Write a text file
robots.file("Optimus_Prime.txt").put("Leader of the Autobots");
// Write a binary file
robots.file("Optimus_Prime.key").put(new byte[] { (byte)0xe0, 0x4f, (byte)0xd0, 0x20 });
```

```scala
let robots = client.dir("data://.my/robots")

// Upload local file
robots.putFile(new File("/path/to/Optimus_Prime.png"))
// Write a text file
robots.file("Optimus_Prime.txt").put("Leader of the Autobots")
// Write a binary file
robots.file("Optimus_Prime.key").put(new byte[] { (byte)0xe0, 0x4f, (byte)0xd0, 0x20 })
```

```nodejs
var robots = client.dir("data://.my/robots");

// Write a plain text file
robots.file("Optimus_Prime.txt").putString("Leader of the Autobots");
// Write an JS object to a JSON file
robots.file("Optimus_Prime.json").putJson({"faction": "Autobots"});
```


To upload a file through the Algorithmia Data API, use the following endpoint:

`PUT https://api.algorithmia.com/v1/data/:owner/:directory/:file_name`

Input:

`[Body of the request is the content of the file that will be created]`

#### Response

Attribute | Description
--------- | -----------
result    | The full Data URI of resulting file

### Deleting a file

> Deleting a file:

```shell
curl -X DELETE -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/data/.my/robots/C-3PO.txt

-> { "result": { "deleted": 1 }}
```

```python
c3po = client.file("data://.my/robots/C-3PO.txt")
c3po.delete()
```

```java
DataFile c3po = client.file("data://.my/robots/C-3PO.txt")
c3po.delete();
```

```scala
let c3po = client.file("data://.my/robots/C-3PO.txt")
c3po.delete()
```

```nodejs
var c3po = client.file("data://.my/robots/C-3PO.txt");
c3po.delete(function(response) {
    if(response.error) {
        return console.log("Failed to delete file: " + response.error.message);
    }
    console.log("Deleted file: " + c3po.data_path);
});
```

To delete a file through the Algorithmia Data API, use the following endpoint:

`DELETE https://api.algorithmia.com/v1/data/:owner/:directory/:file_name`

#### Response

> Deleting a file output:

```
{
    "result": {
        "deleted": Long /* Number of files successfully deleted (0 or 1 for single file delete) */
    }, /* Optional */
    "error": {
        "message": String,
        "deleted": Long /* Number of files successfully deleted (0 or 1 for single file delete) */
    } /* Optional */
}
```

Attribute | Description
--------- | -----------
result.deleted  | The number of files successfully deleted
error.deleted   | The number of files successfully deleted if an error encountered during deletion


#### Versioning

Algorithmia API is versioned with the version specified on the URL route:

`[ANY] api.algorithmia.com/:version/:route`

For example:

`[ANY] api.algorithmia.com/v1/:route`

`[ANY] api.algorithmia.com/v2/:route`

`[ANY] api.algorithmia.com/v3/:route`

Each version will be supported for 18 months after the version is marked as deprecated.

#### Deprecated Versions

##### v0 (Unversioned routes)

Algorithm API calls defined with unversioned routes are deprecated. They will be supported until 2015-12-31.

An unversioned route appears as such:

`[ANY] api.algorithmia.com/api/:route`

`[ANY] api.algorithmia.com/data/:route`
