# Data API Specification

## Directories

#### Listing a directory

```
GET @apiUrl/data/:owner
GET @apiUrl/data/:owner/:collection_name
GET @apiUrl/data/:owner/:collection_name?marker=123abc
```

Query-parameters:

  * `acl=true` displays the acl of a Collection.  Will only display if the Collection owner initiates the call and the path is to a collection.

  * `marker=12-4s4` returns the page of results starting at marker "12-4s4", only valid for markers previously returned by this API.  If this parameter is omitted then the first page of results is provided.

Output:

Response headers:

`X-Data-Type: directory`

Response body:
```javascript
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

* acl strings:

    * "user://*" - Readable by anyone (aka: public)

    * "algo://my/*" - Readable by your algorithms (default)

    * Fully private is represented as an empty list

    * No other acl strings are currently supported

###### Example requests:

---

GET @apiUrl/algo/@username/

---

GET @apiUrl/algo/@username/**?marker=12-4s4**

---

GET @apiUrl/algo/@username/collection**?acl=true**

---

##### Success responses:

```json
{
    "folders": [
        {"name":"collection1"},
        {"name":"collection2"}
    ]
}
```

```json
{
    "files": [
        {"filename":"file1.csv","last_modified":"2015-01-01T23:01:01.000Z","size":51118296},
        {"filename":"file2.txt","last_modified":"2015-01-01T23:01:02.000Z","size":64}
    ],
    "marker": "12-4s4",
    "acl": {
        "read":["algo://my/*"]
    }
}
```

##### Failure response:

```json
{
    "duration": 0.001,
    "error": {
        "message": "there was a problem"
    }
}
```

#### Creating a directory

```nohighlight
POST @apiUrl/data/:owner
```

Input:

```javascript
{
    "name": String,
    "acl": {
        "read": [
            String
        ]
    } /* Optional */
}
```

* Content-Type header is required

    * "application/json" | "text/json"

Output:

```nohighlight
[NONE]
```

#### Updating a directory

```nohighlight
PATCH @apiUrl/data/:owner/:collection_name
```

Input:

```javascript
{
    "acl": {
        "read": [
            String
        ]
    } /* Optional */
}
```

* Content-Type header is required

    * "application/json" | "text/json"

Output:

```nohighlight
[NONE]
```

#### Deleting a directory

```nohighlight
DELETE @apiUrl/data/:owner/:collection_name
```

Input:

```nohighlight
[NONE]
```

* Query-parameters:

    * "force=true" enables recursive delete of a non-empty directory

Output:

```javascript
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

### Files

#### Getting files

To retieve files through the Algorithmia Data API, use the following methods:

`HEAD https://api.algorithmia.com/v1/data/:owner/:collection_name/:file_name`
`GET https://api.algorithmia.com/v1/data/:owner/:collection_name/:file_name`

Input:

`[NONE]`

<aside class="notice">
  `HEAD` request error messages are returned on the "X-Error-Message" response header
</aside>

<aside class="notice">
  `GET` requests return the "X-Data-Type" response header with a value of "file"
</aside>


##### Uploading files

To upload files through the Algorithmia Data API, simple send a `PUT` request with the filename:

`PUT https://api.algorithmia.com/v1/data/:owner/:collection_name/:file_name`

Input:

`[Body of the request is the content of the file that will be created]`

#### Deleting files

> DELETE Output:

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

To delete files through the Algorithmia Data API, simple send a `DELETE` request with the filename:

` DELETE https://api.algorithmia.com/v1/data/:owner/:collection_name/:file_name`

Input:

`[NONE]`


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

Algorithm API calls defined with unversioned routes are depricated. They will be supported until 2015-12-31.

An unversioned route appears as such:

`[ANY] api.algorithmia.com/api/:route`

`[ANY] api.algorithmia.com/data/:route`
