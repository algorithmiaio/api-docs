# Algorithms

## Create an algorithm

```shell
curl https://api.algorithmia.com/v1/algorithms/:username \
  -H 'Authorization: Simple YOUR_API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "details": {
      "label": "My First Algorithm"
    },
    "name": "my_first_algorithm",
    "settings": {
      "environment": "cpu",
      "language": "java",
      "license": "apl",
      "network_access": "full",
      "pipeline_enabled": true,
      "source_visibility": "closed" 
    }
  }'
```

```python
import Algorithmia

client = Algorithmia.client('YOUR_API_KEY')

algo = client.algo(':username/my_first_algorithm')

algo.create(
  details = {
    "label": "My First Algorithm"
  },
  settings = {
    "language": "java",
    "source_visibility": "closed",
    "license": "apl",
    "network_access": "full",
    "pipeline_enabled": True,
    "environment": "cpu"
  }
)
```

...

## Invoke an algorithm

...

## Get an algorithm

...

## Update an algorithm

...

## Compile an algorithm

...

## Delete an algorithm

...

## List algorithm builds

...

## Get an algorithm build

...

## Get algorithm build logs

...

## Version an algorithm

...

## List algorithm versions

...

## Get algorithm version

...

## Get algorithm SCM status

...
