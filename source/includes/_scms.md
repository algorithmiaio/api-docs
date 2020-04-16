# SCMs

## The SCM object

```json
{
  "default": true,
  "enabled": true,
  "id": "5d48d16c-15cb-4336-8d0c-05l36f3170e1",
  "oauth": {
    "client_id": "89fsdy7hsdf8tsgd6"
  },
  "provider": "github",
  "urls": {
    "api": "https://api.github.com",
    "ssh": "ssh://git@github.com",
    "web": "https://github.com"
  }
}
```

|Attribute|Type|Description|
|-|-|-|
|`default`|Boolean|Whether this SCM is the default choice for users creating an algorithm.|
|`enabled`|Boolean|Whether Algorithmia platform users may create algorithms with this SCM.|
|`id`|String|The unique identifier for this SCM, represented as a UUID.|
|`oauth.client_id`|String|If SCM is external to the Algorithmia platform, the ID of the OAuth client that can be used to authenticate Algorithmia platform users with the SCM.|
|`provider`|String|Represents the type of SCM. Choose from `internal` or `github`.|
|`urls.api`|String|If using an external SCM, such as `github`, the URL to the SCM's API endpoint.|
|`urls.api`|String|If using an external SCM, such as `github`, the URL to the SCM's SSH endpoint.|
|`urls.web`|String|If using an external SCM, such as `github`, the URL to the SCM's website.|

## Create an SCM

```shell
curl https://api.algorithmia.com/v1/admin/scms \
  -X POST \
  -H 'Authorization: Simple ADMIN_API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "enabled": false,
    "id": "github",
    "oauth": {
      "client_id": "89fsdy7hsdf8tsgd6",
      "client_secret": "..."
    },
    "provider": "github",
    "urls": {
      "api": "https://api.github.com",
      "ssh": "ssh://git@github.com",
      "web": "https://github.com"
    }
  }'
```

```python
# Creating an SCM is not yet supported by our Python client library.
```

`POST /admin/scms`

### Authorization

In order to interact with this endpoint you must pass an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys) to learn more.

### Payload Parameters

|Attribute|Type|Description|
|-|-|-|
|`enabled`|Boolean|Whether this SCM should be enabled for Algorithmia platform users on creation.|
|`id`|String|If provided, allows the configuration of a vanity ID. Otherwise, a UUID will be generated for this property.|
|`oauth.client_id`|String|*Required*. The ID of the OAuth client that can be used to authenticate Algorithmia platform users with the SCM. Learn more about creating OAuth apps [in our documentation](/developers/algorithmia-enterprise/scms).|
|`oauth.client_secret`|String|*Required*. The secret of the OAuth client that can be used to authenticate Algorithmia platform users with the SCM. Learn more about creating OAuth apps [in our documentation](/developers/algorithmia-enterprise/scms).|
|`provider`|String|*Required* Represents the type of SCM you wish to create. `github` is the only available option at the present time.|
|`urls.api`|String|*Required*. The URL to the SCM's API endpoint.|
|`urls.api`|String|*Required*. The URL to the SCM's SSH endpoint.|
|`urls.web`|String|*Required*. The URL to the SCM's website.|

## Returns

```json
{
  "default": true,
  "enabled": true,
  "id": "5d48d16c-15cb-4336-8d0c-05l36f3170e1",
  "oauth": {
    "client_id": "89fsdy7hsdf8tsgd6"
  },
  "provider": "github",
  "urls": {
    "api": "https://api.github.com",
    "ssh": "ssh://git@github.com",
    "web": "https://github.com"
  }
}
```

A single [SCM object](#the-scm-object) if the payload was valid, otherwise an [error](#errors).

## List SCMs

```shell
curl https://api.algorithmia.com/v1/scms \
  -H 'Authorization: Simple API_KEY'
```

```python
# Listing SCMs is not yet supported by our Python client library.
```

`GET /scms`

### Returns

```json
{
  "results": [{
    "default": true,
    "enabled": true,
    "id": "5d48d16c-15cb-4336-8d0c-05l36f3170e1",
    "oauth": {
      "client_id": "89fsdy7hsdf8tsgd6"
    },
    "provider": "github",
    "urls": {
      "api": "https://api.github.com",
      "ssh": "ssh://git@github.com",
      "web": "https://github.com"
    }
  }]
}
```

|Attribute|Type|Description|
|-|-|-|
|`results`|Array|A list of one or more [scm objects](#the-scm-object). An SCM of the type `internal` will always be returned.|

## Get an SCM

```shell
curl https://api.algorithmia.com/v1/scms/:scm_id \
  -H 'Authorization: Simple API_KEY'
```

```python
# Getting an SCM is not yet supported by our Python client library.
```

`GET /scms/:scm_id`

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`scm_id`|String|The the unique `id` for the SCM you wish to retrieve.|

### Returns

```json
{
  "default": true,
  "enabled": true,
  "id": "5d48d16c-15cb-4336-8d0c-05l36f3170e1",
  "oauth": {
    "client_id": "89fsdy7hsdf8tsgd6"
  },
  "provider": "github",
  "urls": {
    "api": "https://api.github.com",
    "ssh": "ssh://git@github.com",
    "web": "https://github.com"
  }
}
```

A single [SCM object](#the-scm-object) if a valid identifier was passed, otherwise an [error](#errors).

## Update an SCM

```shell
curl https://api.algorithmia.com/v1/admin/scms/:scm_id \
  -X PATCH \
  -H 'Authorization: Simple ADMIN_API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "enabled": true
  }'
```

```python
# Updating an SCM is not yet supported by our Python client library.
```

`PATCH /admin/scms/:scm_id`

### Authorization

In order to interact with this endpoint you must pass an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys) to learn more.

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`scm_id`|String|The the unique `id` for the SCM you wish to update.|

### Payload Parameters

|Parameter|Type|Description|
|-|-|-|
|`enabled`|Boolean|If specified, determines whether the specified SCM should be available for Algorithmia platform users to create algorithms. You cannot set `enabled` to `false` if an SCM's default property is also set to `true`. To accomplish this, make sure you make another SCM the default SCM.|

### Returns

```json
{
  "default": true,
  "enabled": true,
  "id": "5d48d16c-15cb-4336-8d0c-05l36f3170e1",
  "oauth": {
    "client_id": "89fsdy7hsdf8tsgd6"
  },
  "provider": "github",
  "urls": {
    "api": "https://api.github.com",
    "ssh": "ssh://git@github.com",
    "web": "https://github.com"
  }
}
```

An [SCM object](#the-scm-object) representing the updated SCM if the payload was valid, otherwise an [error](#errors).

## Set the default SCM

```shell
curl https://api.algorithmia.com/v1/admin/scms/:scm_id/default \
  -X POST \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Setting the default SCM is not yet supported by our Python client library.
```

`POST /admin/scms/:scm_id/default`

### Authorization

In order to interact with this endpoint you must pass an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys) to learn more.

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`scm_id`|String|The the unique `id` for the SCM you wish to set as the default SCM.|

### Returns 

No content if the operation was successful, otherwise an [error](#errors). Note that a disabled SCM cannot become the default SCM for the platform: it must be enabled first.

## Delete an SCM

```shell
curl https://api.algorithmia.com/v1/admin/scms/:scm_id \
  -X DELETE \
  -H 'Authorization: Simple ADMIN_API_KEY'
```

```python
# Deleting an SCM is not yet supported by our Python client library.
```

`DELETE /admin/scms/:scm_id`

### Authorization

In order to interact with this endpoint you must pass an admin API key. Visit [our documentation](/developers/platform/customizing-api-keys) to learn more.

### Path Parameters

|Parameter|Type|Description|
|-|-|-|
|`scm_id`|String|The the unique `id` for the SCM you wish to delete.|

### Returns

No content if the operation was successful, otherwise an [error](#errors). Note that, once an SCM has been used to create an algorithm, it may not be deleted, only disabled.
