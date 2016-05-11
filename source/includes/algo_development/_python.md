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

> ####I/O for Your Algorithms:

> Datatypes that are either sequences that you don't wish to iterate over such as strings or inputs that are scalar in nature such as a numeric data type can be accessed via input.

```
import Algorithmia

def apply(input):
    assert isinstance(input, basestring)
    return input
```

> A string input:

```
"It's just a flesh wound."
```

> Inputs that are sequences such as: lists, dictionaries, tuples and bytearrays (binary byte sequence such as an image file) can be handled as you would any Python sequence, however you will probably want to check for the data type you are expecing to receive. For example:

```
import Algorithmia

def apply(input):
    assert isinstance(input, list)
    return 'Hello ' + input[0]
```

> Here is an example of a list input:

```
["Knights Who Say Ni", "Killer Rabbit of Caerbannog"]
```

> Which will return:

```
"Hello Knights Who Say Ni"
```
#### I/O for Your Algorithms

When you are creating an algorithm that takes input from other algorithms it's important to understand what data types to expect and what data types you may return as output that the user of your algorithm will ingest.

Note that you can also return any of these data structures in your algorithm.


#### Calling Other Algorithms and Managing Data

To call other algorithms or manage data from your algorithm, use the [Algorithmia Python Client](#python-client) which is automatically available to any algorithm you create on the Algorithmia platform.

When designing your algorithm, don't forget that there are special data directories, `.session` and `.algo`, that are available only to algorithms to help you manage data over the course of the algorithm execution.

#### Error Handling

> ####Error Handling:

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

Algorithms can throw any exception, and they will be returned as an error via the Algorithmia API. If you want to throw a generic exception message, use an `AlgorithmException`.

#### Additional Resources

* <a href="http://developers.algorithmia.com/clients/python/">Algorithmia Client Python Docs <i class="fa fa-external-link"></i></a>
* <a href="https://docs.python.org/2.7/">Python 2.7 Docs</a>
