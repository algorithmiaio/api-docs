## Python Algorithm Development

#### Available APIs

Algorithmia makes a number of libraries available to make algorithm development easier.
The full <a href="https://docs.python.org/2.7/">Python 2.7 language and standard library</a>
is available for you to use in your algorithms. Furthermore, algorithms can call other algorithms and manage data on the Algorithmia platform
via the <a href="http://developers.algorithmia.com/clients/python/">Algorithmia Python Client</a>.

#### Managing Dependencies

Algorithmia supports adding 3rd party dependencies via the <a href="https://pypi.python.org/pypi">Python Package Index (PyPI)</a> using a requirements.txt file. On the algorithm editor page, click Options and select Manage Dependencies.

Add dependencies by adding the package name to the `requirements.txt` file.

Note that you will still need to include an import statement to your algorithm file. For example, to make use of numpy, you would include the line

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
import Algorithmia
def apply(input):
    return 'Hello ' + str(input)
```

For single arguments, JSON parsing works in a similar manner as it does for Java algorithms. However, to take multiple arguments to an algorithm, you must store them in a single python object such as a list, tuple or dictionary. For example: to pass `arg1` and `arg2` the first of which is a string and the second of which is a list of integers you would construct a dictionary. Below you'll see an example shown below as a JSON object:

`{"arg1": "word", "arg2": [1,2,3,4]}`

#### Calling Other Algorithms and Managing Data

To call other algorithms or manage data from your algorithm, use the [Algorithmia Python Client](#python-client) which is automatically available to any algorithm you create on the Algorithmia platform.

When designing your algorithm, don't forget that there are special data directories, `.session` and `.algo`, that are available only to algorithms to help you manage data over the course of the algorithm execution.

#### Additional Resources

* <a href="http://developers.algorithmia.com/clients/python/">Algorithmia Client Python Docs <i class="fa fa-external-link"></i></a>
* <a href="https://docs.python.org/2.7/">Python 2.7 Docs</a>
