##Making your first API call

Calling an algorithm is as simple as making a curl request. For example, to call the JavaAddOne algorithm, simply run:

```bash
$ curl -X POST -d '41' -H 'Content-Type: application/json' -H 'Authorization: Simple @apiKey' @apiUrl/algo/docs/JavaAddOne

{"result": 42,"metadata":{"duration":0.0001}}
```


API Address
For a given user and algorithm name, API calls are made to the following url:

POST https://api.algorithmia.com/v1/algo/:owner/:algoname

