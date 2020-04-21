# Users

## The user object

```json
{
  "company_name": "Algorithmia",
  "company_role": "Example User",
  "email": "me@example.com",
  "fullname": "Example User",
  "resource_type": "user",
  "self_link": "https://api.algorithmia.com/v1/users/example_user",
  "username": "example_user"
}
```

|Attribute|Type|Description|
|-|-|-|
|`company_name`|String|The name of the user's employer.|
|`company_role`|String|The user's occupation.|
|`email`|String|The user's email address.|
|`fullname`|String|The user's full name.|
|`resource_type`|String|Always set to `user` for users.
|`self_link`|String|The URL that can be used to retrieve this specific user via the REST API.|
|`username`|String|The unique identifier for this user.|

## Create a user

```shell
curl https://api.algorithmia.com/v1/users \
  -X POST \
  -H 'Authorization: Simple ADMIN_API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "company_name": "Algorithmia",
    "company_role": "Example User",
    "email": "example@example.com",
    "fullname": "Example User",
    "username": "example_user"
  }'
```

```python
# Creating a user is not yet supported by our Python client library.
```

`POST /users`

### Authorization

In order to interact with this endpoint you must provide an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys#admin-api-keys) to learn more.

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`company_name`|String|The name of the user's employer.|
|`company_role`|String|The user's occupation.|
|`email`|String|*Required*. The user's email address. Must not already be in use by another user on the platform.|
|`fullname`|String|*Required*. The user's full name.|
|`username`|String|*Required*. The unique identifier for this user. Only letters, numbers, and underscores are permitted, and must begin with a letter.|

### Returns

```json
{
  "company_name": "Algorithmia",
  "company_role": "Example User",
  "email": "me@example.com",
  "fullname": "Example User",
  "resource_type": "user",
  "self_link": "https://api.algorithmia.com/v1/users/example_user",
  "username": "example_user"
}
```

A single [user object](#the-user-object) if a valid user payload was provided, otherwise an [error](#errors).

## List users

```shell
curl https://api.algorithmia.com/v1/users \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Listing users is not yet supported by our Python client library.
```

`GET /users`

### Authorization

In order to interact with this endpoint you must provide an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys#admin-api-keys) to learn more.

### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`limit`|Number|The maximum number of items to return in the response. Defaults to 50.|
|`marker`|String|Used for paginating results from previous queries. See the [versioning section](#versioning) above.|

### Returns

```json
{
  "marker": null,
  "next_link": null,
  "results": [{
    "company_name": "Algorithmia",
    "company_role": "Example User",
    "email": "me@example.com",
    "fullname": "Example User",
    "resource_type": "user",
    "self_link": "https://api.algorithmia.com/v1/users/example_user",
    "username": "example_user"
  }]
}
```

A collection of [user objects](#the-user-object), otherwise an [error](#errors).

|Attribute|Type|Description|
|-|-|-|
|`marker`|String|If more results are available than can be shown based on the supplied `limit`, this value can be used to paginate results. See the [versioning section](#versioning) above.|
|`next_link`|String|A link to the next page of results, if more results exist.|
|`results`|Array|A list of one or more [user objects](#the-user-object).|

## Get a user

```shell
curl https://api.algorithmia.com/v1/users/:username \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Retrieving a user is not yet supported by our Python client library.
```

`GET /users/:username`

### Authorization

In order to interact with this endpoint you must provide an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys#admin-api-keys) to learn more.

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The the unique `username` for the user you wish to retrieve.|

### Returns

A single [user object](#the-user-object) upon success, otherwise an [error](#errors).

## Update a user

```shell
curl https://api.algorithmia.com/v1/users/example_user \
  -X PUT \
  -H 'Authorization: Simple ADMIN_API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "company_name": "Algorithmia",
    "company_role": "Example User",
    "email": "example@example.com",
    "fullname": "Example User",
    "username": "example_user"
  }'
```

```python
# Updating a user is not yet supported by our Python client library.
```

`PUT /users/:username`

### Authorization

In order to interact with this endpoint you must provide an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys#admin-api-keys) to learn more.

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`username`|String|*Required*. The the unique `username` for the user you wish to update.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`company_name`|String|The name of the user's employer.|
|`company_role`|String|The user's occupation.|
|`email`|String|*Required*. The user's email address. If no change desired, supply the previous value of user's `email` property.|
|`fullname`|String|*Required*. The user's full name. If no change desired, supply the previous value of user's `fullname` property.|
|`username`|String|*Required*. The user's unique identifier for this user. Must be supplied, but cannot be used to change a user's username.|

### Returns

```json
{
  "company_name": "Algorithmia",
  "company_role": "Example User",
  "email": "me@example.com",
  "fullname": "Example User",
  "resource_type": "user",
  "self_link": "https://api.algorithmia.com/v1/users/example_user",
  "username": "example_user"
}
```

The updated [user object](#the-user-object) if a valid user payload was provided, otherwise an [error](#errors).

## Delete a user

```shell
curl https://api.algorithmia.com/v1/users/:username \
  -X DELETE \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Deleting a user is not yet supported by our Python client library.
```

`DELETE /users/:username`

### Authorization

In order to interact with this endpoint you must provide an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys#admin-api-keys) to learn more.

### Returns

An empty response upon success, otherwise an [error](#errors).
