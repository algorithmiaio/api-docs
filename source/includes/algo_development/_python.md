## Python Algorithm Development

#### Managing Dependencies

Algorithmia supports adding 3rd party dependencies via the <a href="https://pypi.python.org/pypi">Python Package Index (PyPI)</a> using a requirements.txt file. On the algorithm editor page, click Options and select Manage Dependencies.

Add dependencies by adding lines to the `requirements.txt` file.

Note that you will still need to include an import statement file. For example, to make use of numpy, you would include the line

`numpy`

in the dependencies file and the line

`import numpy as np`

in the main file.

#### Error Handling

```
raise NameError('Invalid graph structure')
```

> Exceptions will be returned as JSON, of the form:

```json
{
  "error": {
    "message": "Error running algorithm",
    "stacktrace": ...
  }
}
```

Algorithms can throw any exception and they will be returned as an error via the Algorithmia API. Use standard Python exception conventions, such as NameError.

#### JSON parsing

> Within the receiving algorithm, the arguments would be retrieved as follows:

```
def apply(input):
  arg1 = input['arg1']
  arg2 = input['arg2']
```

For single arguments, JSON parsing works in a similar manner as it does for Java algorithms. However, to take multiple arguments to an algorithm, you must store them in a single python object such as a list, array, or dictionary. For example, to pass `arg1` and `arg2`, the first of which is a string and the second of which is a list of integers, you would construct a dictionary. Below you'll see an example shown below as a JSON map:

`{"arg1": "word", "arg2": [1,2,3,4]}`
