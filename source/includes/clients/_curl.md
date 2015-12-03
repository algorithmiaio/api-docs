## cURL

[needs docs]
[needs formatting]

### Calling an Algorithm

```bash
curl -X POST -d '41' -H 'Content-Type: application/json' -H 'Authorization: Simple @apiKey' @apiUrl/algo/docs/JavaAddOne
```

```json
{"result": 42,"metadata":{"duration":0.0001}}
```

### Working with Data

#### Create a collection

```bash
curl -X POST -d 'newCollection' -H 'Authorization: Simple @apiKey' @apiUrl/data/@username
```

```json
{"result": "data://@username/newCollection"}
```

#### Upload File

```bash
curl -X PUT -F file=@@filename.csv -H 'Authorization: Simple @apiKey' @apiUrl/data/@username/newCollection
```

```json
{"result": "data://@username/newCollection/filename.csv"}
```

#### Upload data as a file

```bash
curl -X PUT -H 'Content-Type:application/json' -d '{"key1": "value1"}' -H 'Authorization: Simple @apiKey' @apiUrl/data/@username/newCollection/myFile.json
```

```json
{"result": "data://@username/newCollection/myFile.json"}
```
