---
title: Algorithmia API Documentation
language_tabs:
  # Must be one of https://git.io/vQNgJ
  - shell: cURL
  - python: Python
includes:
  - algorithms
  - algorithm_builds
  - algorithm_versions
  - data
  - organizations
  - organization_members
  - scms
  - users 
search: true
---
# Introduction

Welcome to Algorithmia's API documentation. Here you will find examples of how to manage algorithms, data, and admin resources using Algorithmia's REST API and Python client library.

If this is your first time trying Algorithmia, you might find it useful to start with our [Getting Started guide](/getting-started), which can be found alongside many other resources in the [Algorithmia Developer Center](/developers).

## Base URL

```python
import Algorithmia

# When passing a custom API endpoint to our Python client, you 
# may omit the `v1` path prefix, as it will be supplied automatically.
client = Algorithmia.client('API_KEY', 'https://api.example.com')
```

By default, we provide examples using the `https://api.algorithmia.com/v1` base URL, but if you are using an enterprise version of Algorithmia hosted under a different domain, you should ensure you modify any code samples as necessary.

Per our [versioning scheme](#versioning), ensure that you supply the appropriate version prefix in addition to the REST API endpoint you wish to use. Thus, if your Algorithmia instance was hosted at `example.com`, your base URL would be `https://api.example.com/v1`. If using a client library, ensure you properly pass your custom endpoint as a parameter when initializing the client.

## Authentication

```shell
curl https://api.algorithmia.com/v1/scms
  -H 'Authorization: Simple API_KEY'
```

```python
import Algorithmia

client = Algorithmia.client('API_KEY')
```


If you are interacting directly with Algorithmia's REST API, provide your API key via an `Authorization` header with the prefix `Simple`. If you are using one of our client libraries, follow the instructions specific to that client library. This holds true for both standard and admin API keys. Learn more about API keys [in our devcenter](/developers/platform/customizing-api-keys).

Ensure that you [enable algorithm management capabilities](/developers/algorithm-development/algorithm-management) for your API key if you wish to create, edit, or delete algorithms.

<aside class="notice">
If using code from one of the samples provided in this documentation, ensure that you replace <code>API_KEY</code> with your personal API key.
</aside>

## Errors

```json
{
  "id": "dc7daff0-37e7-549e-b469-d9da822a4092",
  "code": 5005,
  "message": "This feature doesn't exist yet."
}
```

Should an error occur while fulfilling a request, you will be returned an object possessing the following attributes: 

|Attribute|Type|Description|
|-|-|-|
|`id`|String|An optional identifier for the error that can be provided to Algorithmia customer support to aid debugging.|
|`code`|Number|The specific code pertaining to the error. See the expandable section below for details about available error codes.|
|`message`|String|A human-readable explanation of the error's cause.|

The full list of error codes can be viewed by expanding the list below:

<details>
  <summary>Error Codes</summary>
  <table>
    <thead>
      <tr>
        <th>Code</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr><td>1000</td><td>The requested algorithm was not found.</td></tr>
      <tr><td>1001</td><td>An algorithm with the requested name does not exist.</td></tr>
      <tr><td>1002</td><td>An algorithm with the requested name already exists.</td></tr>
      <tr><td>1003</td><td>The package set does not exist.</td></tr>
      <tr><td>1004</td><td>The package set build doest not exist.</td></tr>
      <tr><td>1005</td><td>The package does not exist.</td></tr>
      <tr><td>1006</td><td>Unable to update package set.</td></tr>
      <tr><td>1007</td><td>Version already published. Please compile your algorithm.</td></tr>
      <tr><td>1008</td><td>Failed to create algorithm on backing SCM.</td></tr>
      <tr><td>1009</td><td>An algorithm with the requested ID does not exist.</td></tr>
      <tr><td>2001</td><td>Caller is not authorized to perform the operation.</td></tr>
      <tr><td>2002</td><td>Unknown or invalid API key.</td></tr>
      <tr><td>2011</td><td>A package with that name already exists.</td></tr>
      <tr><td>2012</td><td>Invalid build status.</td></tr>
      <tr><td>2013</td><td>Invalid JSON.</td></tr>
      <tr><td>2014</td><td>Invalid build image.</td></tr>
      <tr><td>2015</td><td>Invalid request.</td></tr>
      <tr><td>2016</td><td>Invalid JSON for package set contents.</td></tr>
      <tr><td>2017</td><td>The status is invalid or the operation is not valid for a package set with its status.</td></tr>
      <tr><td>2018</td><td>Request body is invalid, missing field: 'owner'.</td></tr>
      <tr><td>3000</td><td>The requested user was not found.</td></tr>
      <tr><td>3001</td><td>Malformed user JSON in request.</td></tr>
      <tr><td>3003</td><td>The username is already taken.</td></tr>
      <tr><td>3004</td><td>The email address is already taken by a different username.</td></tr>
      <tr><td>3005</td><td>Not all required fields have been provided.</td></tr>
      <tr><td>3007</td><td>The username in the request body does not match the username in the request path.</td></tr>
      <tr><td>3008</td><td>Updating the email of a user is not allowed.</td></tr>
      <tr><td>3009</td><td>Invalid sign-up form.</td></tr>
      <tr><td>3010</td><td>Invalid JSON to create a package.</td></tr>
      <tr><td>3100</td><td>The requested organization was not found.</td></tr>
      <tr><td>3101</td><td>An organization already exists with this name.</td></tr>
      <tr><td>3102</td><td>Unable to remove the last owner of an organization.</td></tr>
      <tr><td>3104</td><td>Failed to reserve an organization user while adding an organization.</td></tr>
      <tr><td>3103</td><td>Malformed organization JSON in request.</td></tr>
      <tr><td>3105</td><td>Favicon cannot exceed maximum size.</td></tr>
      <tr><td>3106</td><td>Invalid file to upload.</td></tr>
      <tr><td>3107</td><td>Logo cannot exceed maximum size.</td></tr>
      <tr><td>4001</td><td>The request algorithm language is not known.</td></tr>
      <tr><td>4002</td><td>The requested algorithm language does not support this feature.</td></tr>
      <tr><td>4003</td><td>Malformed package set JSON in request.</td></tr>
      <tr><td>4004</td><td>The requested machine type is not supported.</td></tr>
      <tr><td>4005</td><td>A package set with the requested name already exists.</td></tr>
      <tr><td>4006</td><td>A package set with the requested name does not exist.</td></tr>
      <tr><td>4007</td><td>The package set contents contain duplicate items.</td></tr>
      <tr><td>4008</td><td>The SCM OAuth token was not found.</td></tr>
      <tr><td>4009</td><td>The SCM configuration was not found.</td></tr>
      <tr><td>4010</td><td>Required parameter start_date or end_date is missing.</td></tr>
      <tr><td>4011</td><td>Only algorithms backed with the internal SCM can modify code through Algorithmia APIs.</td></tr>
      <tr><td>4012</td><td>Internal SCM does not support webhooks.</td></tr>
      <tr><td>4020</td><td>The provided SCM configuration is invalid.</td></tr>
      <tr><td>4021</td><td>Malformed update SCM payload.</td></tr>
      <tr><td>4040</td><td>Unable to delete SCM configuration.</td></tr>
      <tr><td>4041</td><td>Unable to perform specified action on the default SCM.</td></tr>
      <tr><td>4042</td><td>Unable to perform specified action on a disabled SCM.</td></tr>
      <tr><td>4043</td><td>Unable to delete SCM configuration in use.</td></tr>
      <tr><td>4044</td><td>Duplicate SCM exists that has the same id or matches provider, OAuth client ID, and web URL.</td></tr>
      <tr><td>4045</td><td>Unable to modify the referenced SCM configuration.</td></tr>
      <tr><td>4050</td><td>Unable to start OAuth flow.</td></tr>
      <tr><td>4051</td><td>Unable to finish OAuth flow.</td></tr>
      <tr><td>4070</td><td>Webhook payload malformed.</td></tr>
      <tr><td>4080</td><td>SCM provider is not authorized.</td></tr>
      <tr><td>4084</td><td>Failed communicating with SCM.</td></tr>
      <tr><td>5001</td><td>There was an internal error.</td></tr>
      <tr><td>5002</td><td>Invalid marker used.</td></tr>
      <tr><td>5003</td><td>Limit must be between 1 and the system-configured page size limit.</td></tr>
      <tr><td>5004</td><td>Requested configuration entry could not be found.</td></tr>
      <tr><td>5005</td><td>Feature not implemented.</td></tr>
      <tr><td>6001</td><td>The request is invalid.</td></tr>
      <tr><td>7000</td><td>Request ID was not found.</td></tr>
    </tbody>
  </table>
</details>

## Pagination

```js
{
    "marker": "eyJvcmdOYW1lIjoiQnVnQmFzaE9yZzEifQ",
    "next_link": "http://api.algorithmia.com/v1/organizations?limit=50&marker=eyJvcmdOYW1lIjoiQnVnQmFzaE9yZzEifQ",
    "results": [
      // ...
    ]
}
```

If you are querying a collection of objects, and there are more results available than can be displayed in a single response, you may paginate results with *markers*.

A collection response will contain two properties that allow you to fetch additional pages of results: `marker` and `next_link`. `marker` can be supplied as a query parameter to a subsequent request, informing the API that you wish to obtain the next page of results for your prior query. Conveniently, the `next_link` property contains the preconstructed URL for you to make just such a query.

If there are no additional results for a particular collection query, both the `marker` and `next_link` properties will be `null`.

## Versioning

The latest version of the Algorithmia API is `v1`, and endpoints supported in this version fall under the `/v1` path prefix.

Algorithmia will update this path prefix in the future should we release a new version of the Algorithmia API.

## Client Libraries

Algorithmia offers client libraries in several languages. While nearly all client libraries offer the ability to invoke algorithms and manage data connectors, we recommend using our Python client library as it exposes additional functionality for managing algorithms.

|Language|Client Library|Documentation|
|-|-|-|
|C#/.NET|[algorithmia-c-sharp](https://github.com/algorithmiaio/algorithmia-c-sharp)|[Guide](/developers/clients/c_sharp_net)|
|CLI|[algorithmia-cli](https://github.com/algorithmiaio/algorithmia-cli)|[Guide](/developers/clients/cli)|
|Go|[algorithmia-go](https://github.com/algorithmiaio/algorithmia-go)|[Guide](/developers/clients/go)|
|Java|[algorithmia-java](https://github.com/algorithmiaio/algorithmia-java)|[Guide](/developers/clients/java)|
|JavaScript|[algorithmia-js](https://github.com/algorithmiaio/algorithmia-js)|[Guide](/developers/clients/javascript)|
|Node.js|[algorithmia-nodejs](https://github.com/algorithmiaio/algorithmia-nodejs)|[Guide](/developers/clients/node)|
|PHP|[algorithmia-php](https://github.com/algorithmiaio/algorithmia-php)|[Guide](/developers/clients/php)|
|Python|[algorithmia-python](https://github.com/algorithmiaio/algorithmia-python)|[Guide](/developers/clients/python)|
|R|[algorithmia-r](https://github.com/algorithmiaio/algorithmia-r)|[Guide](/developers/clients/r)|
|Ruby|[algorithmia-ruby](https://github.com/algorithmiaio/algorithmia-ruby)|[Guide](/developers/clients/ruby)|
|Rust|[algorithmia-rust](https://github.com/algorithmiaio/algorithmia-rust)|[Guide](/developers/clients/rust)|
|Scala|[algorithmia-scala](https://github.com/algorithmiaio/algorithmia-scala)|[Guide](/developers/clients/scala)|
|Swift|[algorithmia-swift](https://github.com/algorithmiaio/algorithmia-swift)|[Guide](/developers/clients/swift)|
