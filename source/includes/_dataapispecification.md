# Data API Specification

## Directories

#### Listing a directory
> Listing a directory response body:

```
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

> Success response:

```
{
    "folders": [
        {"name":"collection1"},
        {"name":"collection2"}
    ]
}
```

> Failure response:

```
{
    "duration": 0.001,
    "error": {
        "message": "there was a problem"
    }
}
```

To list a directory through the Algorithmia Data API, use the following methods:

`GET @apiUrl/data/:owner`

`GET @apiUrl/data/:owner/:collection_name?marker=123abc`

Query parameters:

  * `acl=true` displays the ACL of a Collection.  Will only display if the Collection owner initiates the call and the path is to a collection.

  * `marker=12-4s4` returns the page of results starting at marker "12-4s4", only valid for markers previously returned by this API.  If this parameter is omitted then the first page of results is provided.

Output:

Response headers:

`X-Data-Type: directory`

ACL Strings:

  * `user://*`: Readable by anyone (public)

  * `algo://my/*`: Readable by your algorithms (default)

  * Fully private is represented as an empty list

  * No other ACL strings are currently supported


###### Example requests:

`GET https://api.algorithmia.com/v1/algo/@username/`

`GET https://api.algorithmia.com/v1/algo/@username/**?marker=12-4s4`

`GET https://api.algorithmia.com/v1/algo/@username/collection**?acl=true`


#### Creating a directory

> Creating a directory input:

```
{
    "name": String,
    "acl": {
        "read": [
            String
        ]
    } /* Optional */
}
```

To create a directory through the Algorithmia Data API, use the following method:

`POST https://api.algorithmia.com/v1/data/:owner`

The Content-Type header is required:

`"application/json"` or `"text/json"`

Output:

`[NONE]`

#### Updating a directory

> Updating a directory input:

```
{
    "acl": {
        "read": [
            String
        ]
    } /* Optional */
}
```

To update a directory through the Algorithmia Data API, use the following method:

`PATCH https://api.algorithmia.com/v1/data/:owner/:collection_name`

The Content-Type header is required:

`"application/json"` or `"text/json"`

Output:

`[NONE]`

#### Deleting a directory

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

To delete a directory through the Algorithmia Data API, use the following method:

`DELETE https://api.algorithmia.com/v1/data/:owner/:collection_name`

Input:

`[NONE]`

Query parameters:

*  `"force=true"` enables recursive delete of a non-empty directory

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
