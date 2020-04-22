# Organization Members

## The organization member object

```json
{
  "username": "example_user",
  "role": "owner",
  "user_link": "https://api.algorithmia.com/v1/user/example_user",
  "resource_type": "organization_member"
}
```

|Attribute|Type|Description|
|-|-|-|
|`role`|String|One of `owner` or `member`. Owners have the ability to add and remove organization members, promote or demote other owners, and publish algorithms publicly on behalf of the organization.|
|`resource_type`|String|Always set to `organization_member` for organization member objects.|
|`user_link`|String|A link to the [user object](#the-user-object) for the organization member.|
|`username`|String|The user's unique identifer.|

## List organization members

```shell
curl https://api.algorithmia.com/v1/organizations/:org_name/members \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Querying organization members is not yet supported by our Python client library.
```

`GET /organizations/:org_name/members`

### Authorization

In order to interact with this endpoint you must pass an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys#admin-api-keys) to learn more.

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`org_name`|String|*Required*. The the unique `org_name` of the organization you wish to retrieve members for.|

### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`limit`|Number|The maximum number of items to return in the response. Defaults to 50.|
|`marker`|String|Used for paginating results from previous queries. See the [pagination section](#pagination) above.|

### Returns

```json
{
  "marker": null,
  "next_link": null,
  "results": [{
    "username": "example_user",
    "role": "owner",
    "user_link": "https://api.algorithmia.com/v1/user/example_user",
    "resource_type": "organization_member"
  }]
}
```

A collection of [organization member objects](#the-organization-member-object), otherwise an [error](#errors).

|Attribute|Type|Description|
|-|-|-|
|`marker`|String|If more results are available than can be shown based on the supplied `limit`, this value can be used to paginate results. See the [pagination section](#pagination) above.|
|`next_link`|String|A link to the next page of results, if more results exist.|
|`results`|Array|A list of one or more [organization member objects](#the-organization-member-object).|

## Add organization member

```shell
curl https://api.algorithmia.com/v1/organizations/:org_name/members/:username \
  -X PUT \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Adding organization members is not yet supported by our Python client library.
```

`PUT /organizations/:org_name/members/:username`

### Authorization

In order to interact with this endpoint you must pass an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys#admin-api-keys) to learn more.


|Parameter|Type|Description|
|-|-|-|
|`org_name`|String|*Required*. The the unique `org_name` of the organization you wish to retrieve members for.|
|`username`|String|*Required*. The `username` of the specific user you wish to add to the organization.|

### Returns

No content if the operation was successful, otherwise an [error](#errors).

## Delete organization member

```shell
curl https://api.algorithmia.com/v1/organizations/:org_name/members/:username \
  -X DELETE \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Deleting organization members is not yet supported by our Python client library.
```

`DELETE /organizations/:org_name/members/:username`

### Authorization

In order to interact with this endpoint you must pass an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys#admin-api-keys) to learn more.

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`org_name`|String|*Required*. The the unique `org_name` of the organization for which you wish to delete a member.|
|`username`|String|*Required*. The `username` of the specific user you wish to remove from the organization.|

### Returns

No content if the operation was successful, otherwise an [error](#errors).
