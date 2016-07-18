# Data API Specification

```javascript
/*
  The Javascript client does not currently have support for the Data API.
  Contact us if you need this feature and we'll prioritize it right away:
  https://algorithmia.com/contact

  Note: The NodeJS client does currently support the Data API.
*/
```

The Algorithmia Data API provides a way of getting data into and out of algorithms
with support for Algorithmia Hosted Data as well as working directly with data
in your Dropbox account or Amazon S3 buckets.
For an introduction to working with data from these different data sources,
see the data portal guides [for Algorithm Developers](http://developers.algorithmia.com/algorithm-development/data-sources/)
or [for Application Developers](http://developers.algorithmia.com/application-development/data-sources/).

## Data URI

A Data URI uniquely identifies files and directories. A Data URI is composed of a protocol and a path (e.g. `data://.my/photos`).
Each connected data source has has a unique protocol. Supported protocols include:

Protocol         | Description
---------------- | -----------
`data://`        | Algorithmia hosted data
`dropbox://`     | Dropbox default connected account
`s3://`          | Amazon S3 default connected account

Additionally, if you connect multiple accounts from the same source,
they can be uniquely identified by their label, e.g. `dropbox+mylabel://`.

The path part of a Data URI is understood in the context of each source:

URI               | Description
----------------- | -----------
`data://.my/foo`  | The `foo` collection of your Algorithmia hosted data
`dropbox://foo`   | The `foo` file or directory in the root of your default Dropbox connected account
`s3://foo`        | The `foo` bucket of your S3 account


<aside class="notice">
  It is very common to use <code>data://.my</code> to refer to the hosted data collections belonging to the authenticated user.
</aside>


The remainder of this documentation provides the specification for working with directories and files
regardless of what data source they come from.

## Directories

Directories are a collection of files or other directories.


### Listing a directory

> Listing a directory:

```shell
# List top-level user directory
curl -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/connector/data/.my

-> {
    "folders": [
        { "name": "robots" },
        { "name": "cats" }
    ]
}

# List a directory with ACLs
curl -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/connector/data/.my/robots?acl=true

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

```cli
$ algo ls data://.my
robots  cats

$ algo ls -l data://.my/robots
2016-01-06 00:52:34    48 R2-D2.txt
2016-01-06 00:52:34    36 T-800.txt
```

```python
# List top level directories
import Algorithmia

client = Algorithmia.client()

for dir in client.dir("data://.my").dirs():
    print "Directory " + dir.path + " at URL " + dir.url

# List files in the 'robots' directory
dir = client.dir("data://.my/robots")
for file in dir.files():
    print "File " + file.path + " at URL " + file.url + " last modified " + file.last_modified
```

```ruby
# List top level directories
client.dir("data://.my").each_dir do |dir|
    puts "Directory " + dir.data_uri
end

# List files in the 'robots' directory
client.dir("data://.my/robots").each_file do |file|
    puts "File " + file.data_uri
end
```


```java
import com.algorithmia.*;
import com.algorithmia.data.*;

// List top level directories
DataDirectory myRoot = client.dir("data://.my");
for(DataDirectory dir : myRoot.dirs()) {
    System.out.println("Directory " + dir.toString() + " at URL " + dir.url());
}

// List files in the 'robots' directory
DataDirectory robots = client.dir("data://.my/robots");
for(DataFile file : robots.files()) {
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

```rust
use algorithmia::*;
use algorithmia::data::*;

let my_robots = client.dir("data://.my/robots");
for entry in my_robots.list() {
    match entry {
        Ok(DirEntry::Dir(dir)) => println!("Directory {}", dir.to_data_uri()),
        Ok(DirEntry::File(file)) => println!("File {}", file.to_data_uri()),
        Err(err) => println!("Error listing my robots: {}", err),
    }
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

List the contents of a directory with this HTTP endpoint:

`GET https://api.algorithmia.com/api/v1/connector/:connector/*path`

- `:connector` is the data source: `data`, `dropbox`, `s3`, or a labeled variant (e.g. `dropbox+mylabel`).
- `*path` is relative to the root of a given data source.

<aside class="notice">
Each client SDK provides a way to iterate through contents of a directory using its <a href="#data-uri">Data URI</a>.
These iterators manage the marker-based pagination and fetch additional contents for large directories as needed.
See the language-specific examples to the right.
</aside>

<aside class="warning">
  This endpoint overlaps with the endpoint for fetching a file. If you aren't sure if a path refers to a file or directory,
  you should first check if it exists. The `exists` methods make a `HEAD` request that check the `X-Data-Type` response header.
</aside>

##### Query Parameters

Parameters | Description
---------------- | -----------
marker | Indicates the page of results to return. Only valid when using markers previously returned by this API. If this parameter is omited then the first page is returned
acl | Include the directory ACL in the response. (Default = false)

##### HTTP Response

The response JSON contains the following attributes:

Attribute | Description
--------- | -----------
folders | [Optional] array of subdirectories
files | [Optional] array of files in directory. `last_modified` is an ISO-8601 timestamp and `size` is measured in bytes
marker | [Optional] string that indicates there are more files or folders within this directory that can be queried for using the marker query parameter
acl.read | [Optional] array of ACL strings defining who has read permissions to this directory. Explanation of ACL strings provided below.

The API is limited to returning 1000 folders or files at a time, so listing
all contents of a directory may require multiple paginated requests.

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
    https://api.algorithmia.com/v1/connector/data/.my
# Empty 200 response on success

# Create a publicly accessible directory named 'public_robots'
curl -X POST -H 'Authorization: Simple YOUR_API_KEY' \
    -H 'Content-Type: application/json' \
    -d '{"name": "public_robots", "acl": {"read": ["user://*"]}}' \
    https://api.algorithmia.com/v1/connector/data/.my
# Empty 200 response on success
```

```cli
$ algo mkdir data://.my/robots
Created directory: data://.my/robots
```

```python
robots = client.dir("data://.my/robots")
robots.create()

# You can also create a directory with different permissions
from Algorithmia.acl import ReadAcl
# Supports: ReadAcl.public, ReadAcl.private, ReadAcl.my_algos
robots.create(ReadAcl.public)
```

```ruby
robots = client.dir("data://.my/robots")
robots.create
```

```java
DataDirectory robots = client.dir("data://.my/robots");
robots.create();
```

```scala
val robots = client.dir("data://.my/robots")
robots.create()
```

```rust
let robots = client.dir("data://.my/robots");
robots.create(DataAcl::default())
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

`POST https://api.algorithmia.com/v1/connector/:connector/*path`

- `:connector` is the data source: `data`, `dropbox`, `s3`, or a labeled variant (e.g. `dropbox+mylabel`).
- `*path` refers to the path of the existing parent directory of the directory that should be created.

<aside class="notice">
Each client SDK provides a method for creading a directory using its <a href="#data-uri">Data URI</a>.
See the language-specific examples to the right.
</aside>

<aside class="warning">
  Algorithmia hosted directories are currently only supported as top-level directories under your user (e.g. <code>data://.my</code>).
  Additionally, directories cannot be created in the S3 root namespace (e.g. <code>s3://</code>) as creating S3 buckets is not supported.
  If you configured path restrictions when connecting an external data source, then additional limitations may exist.
</aside>

##### Input
Input is JSON and requires the header: `Content-Type: application/json`

Attribute | Description
--------- | -----------
name      | Name of the directory to create
acl       | [Optional] JSON object specifying permissions of the directory


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

##### Response:

Empty 200 response on success


### Updating a directory

> Updating a directory:

```shell
curl -X PATCH -H 'Authorization: Simple YOUR_API_KEY' \
    -H 'Content-Type: application/json' \
    -d '{"acl": {"read": ["user://*"]}}' \
    https://api.algorithmia.com/v1/connector/data/.my
# Empty 200 response on success
```

```python
from Algorithmia.acl import ReadAcl, AclType
robots = client.dir("data://.my/robots")
robots.create()
print robots.get_permissions().read_acl == AclType.my_algos #  True
# Supports: ReadAcl.public, ReadAcl.private, ReadAcl.my_algos
robots.update_permissions(ReadAcl.private)  # True if update succeeded
```

To update a directory, use the following API:

`PATCH https://api.algorithmia.com/v1/connector/*path`

- `:connector` is the data source: `data`, `dropbox`, `s3`, or a labeled variant (e.g. `dropbox+mylabel`).
- `*path` is relative to the root of a given data source.


##### Input:
Input is JSON and requires the header: `Content-Type: application/json`

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

##### Output:

Empty 200 response on success

### Deleting a directory

> Deleting a directory

```shell
# Delete the empty directory data://.my/public_robots
curl -X DELETE -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/connector/data/.my/public_robots

-> { "result": { "deleted": 0 }}

# Force delete the directory data://.my/robots even if it contains files
curl -X DELETE -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/connector/data/.my/robots?force=true

-> { "result": { "deleted": 25 }}
```

```cli
$ algo rmdir data://.my/public_robots
Deleted directory: data://.my/public_robots

$ algo rmdir -f data://.my/robots
Deleted directory: data://.my/robots
```

```python
robots = client.dir("data://.my/robots")
if robots.exists():
	robots.delete()
```

```ruby
robots = client.dir("data://.my/robots")
robots.delete
# to force deletion even if dir contains file, use:
# robots.delete(true)
```


```java
DataDirectory robots = client.dir("data://.my/robots");
robots.delete(false);
// use `true` to force deletion even if dir contains files
```

```scala
val robots = client.dir("data://.my/robots")
robots.delete(false)
// use `true` to force deletion even if dir contains files
```

```rust
let robots = client.dir("data://.my/robots");
robots.delete(false);
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

`DELETE https://api.algorithmia.com/v1/connector/:connector/*path`

- `:connector` is the data source: `data`, `dropbox`, `s3`, or a labeled variant (e.g. `dropbox+mylabel`).
- `*path` is relative to the root of a given data source.

<aside class="notice">
Each client SDK provides a method for deleting a directory using its <a href="#data-uri">Data URI</a>.
The method for deleting a directory may take a boolean argument that specifies if the directory should
be forcibly deleting even if the directory has contents.
See the language-specific examples to the right.
</aside>


##### Query Parameters

Parameters | Description
---------------- | -----------
force            | if true, enables recursive delete of a non-empty directory

##### Response

Attribute | Description
--------- | -----------
result.deleted  | The number of files successfully deleted
error.deleted   | The number of files successfully deleted if an error encountered during deletion


## Files

Files can be any type of data and are uniquely identified by a <a href="#data-uri">Data URI</a>

### Getting a file

> Getting a file:

```shell
curl -O -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/connector/data/.my/robots/T-800.png
# Downloaded to `T-800.png` in local working directory
```

```cli
# Download file to current directory with 'algo cp'
$ algo cp data://.my/robots/T-800.png .
Downloaded data://.my/robots/T-800.png (657kB)
Finished downloading 1 file(s)

# Echo file contents to STDOUT with 'algo cat'
$ algo cat data://.my/robots/T-800.txt
Cyberdyne Systems Series 800 Terminator
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

```ruby
# Download file and get the file handle
t800File = client.file("data://.my/robots/T-800.png").get_file

# Get file's contents as a string
t800Text = client.file("data://.my/robots/T-800.txt").get

# Get file's contents as JSON
t800JsonString = client.file("data://.my/robots/T-800.txt").get
t800Json =  JSON.parse(t800JsonString)

# Get file's contents as a byte array
t800Bytes = client.file("data://.my/robots/T-800.png").get
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
val robots = client.dir("data://.my/robots")

// Download file and get the file handle
val t800File = robots.file("T-800.png").getFile()

// Get the file's contents as a string
val t800Text = robots.file("T-800.txt").getString()

// Get the file's contents as a byte array
val t800Bytes = robots.file("T-800.png").getBytes()
```

```rust
// Download and locally save file
let mut t800_png_reader = client.file("data://.my/robots/T-800.png").get().unwrap();
let mut t800_png = File::create("/path/to/save/t800.png").unwrap();
std::io::copy(&mut t800_png_reader, &mut t800_png);

// Get the file's contents as a string
let mut t800_text_reader = robots.file("data://.my/robots/T-800.txt").get().unwrap();
let mut t800_text = String::new();
t800_text_reader.read_to_string(&mut t800_text);

// Get the file's contents as a byte array
let mut t800_png_reader = robots.file("data://.my/robots/T-800.png").get().unwrap();
let mut t800_bytes = Vec::new();
t800_png_reader.read_to_end(&mut t800_bytes);
```

```nodejs
var robots = client.dir("data://.my/robots");

// Get the file's contents
robots.file("T-800.txt").get(function(err, data) {
  // on success, data will be string or Buffer
  console.log(response);
});

// Get a file and write it to a local file
robots.file("T-800.jpg").get(function(err, data) {
  console.log("Read " + data.length + " bytes");
  fs.writeFileSync("/path/to/save/T-800.jpg", data);
});
```

To retieve a file through the Algorithmia Data API, use the following endpoint:

`GET https://api.algorithmia.com/v1/connector/:connector/*path`

- `:connector` is the data source: `data`, `dropbox`, `s3`, or a labeled variant (e.g. `dropbox+mylabel`).
- `*path` is relative to the root of a given data source.

<aside class="notice">
  Each client SDK provides one or more methods for downloading a file using its <a href="#data-uri">Data URI</a>.
  In general, these clients make it easy retrieve into common data structure ranging from strings, to byte streams, to temporary files.
  See the language-specific examples to the right.
</aside>

<aside class="warning">
  This endpoint overlaps with the endpoint for listing a directory. If you aren't sure if a path refers to a file or directory,
  you should first check if it exists. The `exists` methods make a `HEAD` request that check the `X-Data-Type` response header.
</aside>

##### Response

Upon 200 success, response body is the content of the file.

**Response Headers:**

`X-Data-Type: file`


### Check if file exists

> Checking if a file exists:

```shell
curl -I -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/connector/data/.my/robots/HAL9000.png

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

```ruby
if client.file("data://.my/robots/T-800.png").exists?
    puts "HAL 9000 exists"
```

```java
if(client.file("data://.my/robots/HAL_9000.png").exists()){
    System.out.println("HAL 9000 exists");
}
```

```scala
if(client.file("data://.my/robots/HAL_9000.png").exists()){
    System.out.println("HAL 9000 exists")
}
```

```rust
if client.file("data://.my/robots/HAL_9000.png").exists().unwrap() {
    println!("HAL 9000 exists");
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

`HEAD https://api.algorithmia.com/v1/connector/:connector/*path`

- `:connector` is the data source: `data`, `dropbox`, `s3`, or a labeled variant (e.g. `dropbox+mylabel`).
- `*path` is relative to the root of a given data source.

<aside class="notice">
  Each client SDK provides one or more methods for downloading a file using its <a href="#data-uri">Data URI</a>.
  In general, these clients make it easy retrieve into common data structure ranging from strings, to byte streams, to temporary files.
  See the language-specific examples to the right.
</aside>

<aside class="warning">
  This endpoint overlaps with the endpoint for checking if a directory exists. Verify the `X-Data-Type` response header on success.
  The client SDKs will verify this automatically.
</aside>

##### Response

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
    https://api.algorithmia.com/v1/connector/data/.my/robots/Optimus_Prime.txt

-> { "result": "data://.my/robots/Optimus_Prime.txt" }

# Upload local file
curl -X PUT -H 'Authorization: Simple YOUR_API_KEY' \
    --data-binary @Optimus_Prime.png \
    https://api.algorithmia.com/v1/connector/data/.my/robots/Optimus_Prime.png

-> { "result": "data://.my/robots/Optimus_Prime.png" }
```

```cli
# Upload files with 'algo cp'
$ algo cp Optimus_Prime.png data://.my/robots
Uploaded data://.my/robots/Optimus_Prime.png
Finished uploading 1 file(s)
```

```python
# Upload local file
client.file("data://.my/robots/Optimus_Prime.png").putFile("/path/to/Optimus_Prime.png")
# Write a text file
client.file("data://.my/robots/Optimus_Prime.txt").put("Leader of the Autobots")
# Write a dict to a JSON file
client.file("data://.my/robots/Optimus_Prime.json").putJson({"faction": "Autobots"})
```

```ruby
robots = client.dir("data://.my/robots")

# Upload local file
robots.put_file("/path/to/Optimus_Prime.png")
# Write a text file
robots.file("Optimus_Prime.txt").put("Leader of the Autobots")
# Write a binary file
robots.file("Optimus_Prime.key").put([71, 101, 101, 107].pack('C*'))
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
val robots = client.dir("data://.my/robots")

// Upload local file
robots.putFile(new File("/path/to/Optimus_Prime.png"))
// Write a text file
robots.file("Optimus_Prime.txt").put("Leader of the Autobots")
// Write a binary file
robots.file("Optimus_Prime.key").put(new byte[] { (byte)0xe0, 0x4f, (byte)0xd0, 0x20 })
```

```rust
let robots = client.dir("data://.my/robots");

// Upload local file
robots.put_file("/path/to/Optimus_Prime.png");
// Write a text file
robots.child::<DataFile>("Optimus_Prime.txt").put("Leader of the Autobots");
// Write a binary file
robots.child::<DataFile>("Optimus_Prime.key").put(b"transform");
```


```nodejs
var robots = client.dir("data://.my/robots");

// Upload a file from a local path
robots.putFile("/path/to/Optimus_Prime.jpg", function(response) {
  if(response.error) {
    return console.log("Error: " + response.error.message);
  }
  console.log("Success");
});

// Write string or Buffer to a file
robots.file("Optimus_Prime.txt").put("Leader of the Autobots", function(response) {
    /* check for error or success */
);
```


To upload a file through the Algorithmia Data API, use the following endpoint:

`PUT https://api.algorithmia.com/v1/connector/data/:owner/*path`

- `:connector` is the data source: `data`, `dropbox`, `s3`, or a labeled variant (e.g. `dropbox+mylabel`).
- `*path` is relative to the root of a given data source.

<aside class="notice">
  Each client SDK provides one or more methods for uploading a file using its <a href="#data-uri">Data URI</a>.
  In general, these clients make it easy upload data from common data structures ranging from strings, to byte streams, to files.
  See the language-specific examples to the right.
</aside>

<aside class="warning">
  This endpoint will replace a file if it already exists.
  If you wish to avoid replacing a file, <a href="#check-if-file-exists">check if the file exists</a> before using this endpoint.
</aside>


##### Input

Body of the request is the content of the file that will be created.

##### Response

Attribute | Description
--------- | -----------
result    | The full Data URI of resulting file

### Deleting a file

> Deleting a file:

```shell
curl -X DELETE -H 'Authorization: Simple YOUR_API_KEY' \
    https://api.algorithmia.com/v1/connector/data/.my/robots/C-3PO.txt

-> { "result": { "deleted": 1 }}
```

```cli
$ algo rm data://.my/robots/C-3PO.txt
Deleted file data://.my/robots/C-3PO.txt
```

```python
c3po = client.file("data://.my/robots/C-3PO.txt")
c3po.delete()
```

```ruby
c3po = client.file("data://.my/robots/C-3PO.txt")
c3po.delete
```

```java
DataFile c3po = client.file("data://.my/robots/C-3PO.txt")
c3po.delete();
```

```scala
val c3po = client.file("data://.my/robots/C-3PO.txt")
c3po.delete()
```

```rust
let c3po = client.file("data://.my/robots/C-3PO.txt");
c3po.delete();
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

`DELETE https://api.algorithmia.com/v1/connector/data/*path`

- `:connector` is the data source: `data`, `dropbox`, `s3`, or a labeled variant (e.g. `dropbox+mylabel`).
- `*path` is relative to the root of a given data source.

<aside class="notice">
  Each client SDK provides a method for deleting a file using its <a href="#data-uri">Data URI</a>.
  See the language-specific examples to the right.
</aside>

##### Response

Attribute | Description
--------- | -----------
result.deleted  | The number of files successfully deleted
error.deleted   | The number of files successfully deleted if an error encountered during deletion


# API Versioning

Algorithmia API is versioned with the version specified on the URL route:

`[ANY] api.algorithmia.com/:version/:route`

The current supported API version is `v1` (i.e. `api.algorithmia.com/v1/:route`)


##### Deprecated Versions

Algorithm API calls defined with unversioned routes are deprecated. Planned support for them ended 2015-12-31.

Unversioned routes are routes that use the following format:

`[ANY] api.algorithmia.com/api/:route`

`[ANY] api.algorithmia.com/data/:route`
