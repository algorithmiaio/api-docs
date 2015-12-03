## Python Client

[needs review]
[needs formatting]

### Installing the Algorithmia Python Client

The Algorithmia python client is available as a wheel package from PyPi:

```bash
pip install algorithmia
```

### Calling an Algorithm

```python
import Algorithmia
input = 5
Algorithmia.apiKey = 'Simple @apiKey'
result = Algorithmia.algo('docs/JavaAddOne').pipe(input)
print(result)
```

```nohighlight
6
```

```python
input = 7
result = Algorithmia.client('Simple @apiKey').algo('docs/PythonAddOne').pipe(input)
print(result)
```

```nohighlight
8
```

### Data access

#### Read access

Get a file object.
```python
file = Algorithmia.file("data://.my/test/test.txt").getFile()
```

Get a file's contents as bytes.
```python
fileAsBytes = Algorithmia.file("data://.my/test/test.txt").getBytes()
```

Get a file's contents as a string.
```python
fileAsString = Algorithmia.file("data://.my/test/test.txt").getString() 
print(fileAsString)
```

```nohighlight
this is only a test.
```

Get a file's contents as JSON.
```python
fileAsJson = Algorithmia.file("data://.my/test/test.txt").getJson() 
print(fileAsJson)
```

```nohighlight
"this is only a test."
```

Check if a file exists.
```python
fileExists = Algorithmia.file("data://.my/test/test.txt").exists()
print(fileExists)
```

```nohighlight
True
```

#### Write access

Create or update a file from a string.
```python
Algorithmia.file("data://.my/test/test.txt").put("this is only a test.")
```

Create or update a file from JSON. Will automatically convert many python types into JSON.
```python
Algorithmia.file("data://.my/test/test.txt").putJson({'a': 31415})
```

Create or update a file from a local file. The file will be opened and closed within the putFile method.
```python
Algorithmia.file("data://.my/test/test.txt").putFile(localFile)
```

Delete file.
```python
Algorithmia.file("data://.my/test/test.txt").delete()
```

### Additional resources

* <a href="https://github.com/algorithmiaio/algorithmia-python">Algorithmia Python Client Source <i class="fa fa-external-link"></i></a>
