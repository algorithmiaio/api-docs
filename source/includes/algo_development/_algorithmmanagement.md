# Algorithm Management

Using the Algorithm Management APIs, you can create, publish, update, and inspect individual algorithms.

[Preliminary Specification](https://algorithmia.com/developers/algorithm-development/algorithm-management-api)

```javascript
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```shell
  # This client does not currently support Algorithm Management.
  # Use Python or the OpenAPI spec instead:
  # https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```cli
  # This client does not currently support Algorithm Management.
  # Use Python or the OpenAPI spec instead:
  # https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```r
  # This client does not currently support Algorithm Management.
  # Use Python or the OpenAPI spec instead:
  # https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```ruby
  # This client does not currently support Algorithm Management.
  # Use Python or the OpenAPI spec instead:
  # https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```


```java
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```scala
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```rust
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```nodejs
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
```

```php
<?
  // This client does not currently support Algorithm Management.
  // Use Python or the OpenAPI spec instead:
  // https://algorithmia.com/developers/algorithm-development/algorithm-management-api
?>
```


## Parameter definitions

* [details](https://github.com/algorithmiaio/algorithmia-api-client/blob/eb9d99f9317d0a4969e4d30a0ae40d159bcd58f5/python/algorithmia_api_client/models/details.py)
* [settings](https://github.com/algorithmiaio/algorithmia-api-client/blob/eb9d99f9317d0a4969e4d30a0ae40d159bcd58f5/python/algorithmia_api_client/models/settings.py)
* [version_info](https://github.com/algorithmiaio/algorithmia-api-client/blob/eb9d99f9317d0a4969e4d30a0ae40d159bcd58f5/python/algorithmia_api_client/models/version_info.py)

(Some dictionary entries may be optional; see the [OpenAPI spec](https://algorithmia.com/v1/openapispec) for info)

## Create an Algorithm

```python
algo = client.algo('demo/Hello/')
algo.create(details={}, settings={}, version_info={})
```

## Update an Algorithm

```python
algo.update(details={}, settings={}, version_info={})
```

## Compile an Algorithm (or git push)

```python
algo.compile()
```

## Publish an Algorithm

```python
algo.publish(details={}, settings={}, version_info={})
```

## Get info about an an Algorithm

```python
algo.info(algo_hash=None)
```

## List Versions of an Algorithm
```python
versions(limit=None, marker=None, published=None, callable=None)
```