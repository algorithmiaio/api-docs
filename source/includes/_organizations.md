# Organizations

## The organization object

```json
{
  "org_name": "algorithmiahq",
  "org_label": "Algorithmia",
  "org_contact_name": "Algorithmia Support",
  "org_email": "support@algorithmia.com",
  "org_url": "https://algorithmia.com",
  "self_link": "http://api.test.algorithmia.com/v1/organizations/algorithmiahq",
  "resource_type": "organization"
}
```

|Attribute|Type|Description|
|-|-|-|
|`org_name`|String|The unique identifier for this organization.|
|`org_label`|String|The human-readable name for the organization.|
|`org_contact_name`|String|The individual who can be contacted with any questions about the organization.|
|`org_email`|String|The email address by which the organization's contact may be reached.|
|`org_url`|String|The URL for the organization's website.|
|`resource_type`|String|Always set to `organization` for organizations.
|`self_link`|String|The URL that can be used to retrieve this specific organization via the REST API.|

## Create an organization

```shell
curl https://api.algorithmia.com/v1/organizations \
  -X POST \
  -H 'Authorization: Simple ADMIN_API_KEY' \
  -d '{
    "org_name": "example_organization",
    "org_label": "Example Organization",
    "org_contact_name": "Example User",
    "org_email": "support@example.com",
    "org_url": "https://example.com",
  }'
```

```python
# Creating an organization is not yet supported by our Python client library.
```

`POST /v1/organizations`

### Authorization

In order to interact with this endpoint you must pass an admin API key. Visit [our documentation](https://algorithmia.com/developers/platform/customizing-api-keys) to learn more.

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`org_name`|String|*Required*. The unique identifier for this organization. Only letters, numbers, and underscores are permitted.|
|`org_label`|String|*Required*. The human-readable name for the organization.|
|`org_contact_name`|String|*Required*. The individual who can be contacted with any questions about the organization.|
|`org_email`|String|*Required*. The email address by which the organization's contact may be reached.|
|`org_url`|String|The URL for the organization's website.|

## List organizations

```shell
curl https://api.algorithmia.com/v1/organizations \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Listing organizations is not yet supported by our Python client library.
```

`GET /v1/organizations`

### Query Parameters

|Parameter|Type|Description|
|-|-|-|
|`limit`|Number|The maximum number of items to return in the response. Defaults to 10.|
|`marker`|String|Used for paginating results from previous queries. See the [pagination section](#pagination) above.|

### Returns

|Attribute|Type|Description|
|-|-|-|
|`marker`|String|If more results are available than can be shown based on the supplied `limit`, this value can be used to paginate results. See the [pagination section](#pagination) above.|
|`next_link`|String|A link to the next page of results, if more results exist.|
|`results`|Array|A list of zero or more [organization objects](#the-organization-object).|

## Get an organization

```shell
curl https://api.algorithmia.com/v1/organizations/:org_name \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Getting an organization is not yet supported by our Python client library.
```

`GET /v1/organizations/:org_name`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`org_name`|String|*Required*. The the unique `org_name` for the organization you wish to retrieve.|

### Returns 

A single [organization object](#the-organization-object) if a valid `org_name` was provided, otherwise an error.

## Delete an organization

```shell
curl https://api.algorithmia.com/v1/organizations/:org_name \
  -X DELETE \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Deleting an organization is not yet supported by our Python client library.
```

`DELETE /v1/organizations/:org_name`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`org_name`|String|*Required*. The the unique `org_name` for the organization you wish to delete.|

## Returns

An empty response upon success, otherwise an error.
