## Scala Client

[needs review]
[needs formatting]

Scala is able to use the Algorithmia Java client which is available on Github, published to Maven Central, and automatically available to any algorithm you create on the Algorithmia platform.

### Getting started

The Algorithmia java client is published to Maven central. It is already a dependency of new algorithms in the marketplace. It can be added as a dependency to other projects via:

````scala
libraryDependencies ++= Seq(
  "com.algorithmia" % "algorithmia-client" % "1.0.+",
)
````

Instantiate a client:
````scala
//In your application:
val client = Algorithmia.client("@apiKey")

//In an algorithm on the Algorithmia platform:
val client = Algorithmia.client()
````

### Calling Algorithms

Algorithms are called with the `.pipe()` method as shown below:

````scala
val response = client.algo("docs/JavaAddOne").pipe(72)
val result = response.as(new TypeToken<Integer>(){})
val durationInSeconds = response.getMetadata.getDuration
````

In order to cast the result to a specific type, call `.as()` with a TypeToken, for example:

````scala
// For an algorithm that returns a String
stringResult.as(new TypeToken<String>(){})

// For an algorithm that returns an array of Strings
stringArrayResult.as(new TypeToken<List<String>>(){})

// For an algorithm that returns a custom class, cast the result to that class
class CustomClass {
  val maxCount: Int
  val items: List[String]
}
customClassResult.as(new TypeToken<CustomClass>(){})

// For debugging, it is often helpful to get the JSON String representation of the result
anyResult.asJsonString
````

Note: To create a TypeToken use the syntax `new TypeToken<CustomClass>(){}` making sure to have the trailing `{}` to create an anonymous subclass.

### Working with Data

Algorithmia supports creating <a href="@routes.Data.list">Data Collections</a> making it easy to get data into and out of algorithms.
In the simplest case, you can feed data to an algorithm at request time.
For applications with larger data requirements, Algorithmia allows you to create named collections of independent documents.
These collections are created on a per-user basis, and you control the access on a per-collection basis.

The Algorithmia Java Client provides an easy way to manage data stored within Algorithmia. Basic usage samples are described below. See the [DataAPI docs](../data.md) for more information.


````scala
// Create a directory "foo"
val foo = client.dir("data://.my/foo")
foo.create()

// Upload files to "foo" directory
foo.file("sample.txt").put("sample text contents")
foo.file("binary_file").put(new byte[] { (byte)0xe0, 0x4f, (byte)0xd0, 0x20 })
foo.putFile(new File("/local/path/to/myfile"))

// List files in "foo"
for(file <- foo.getFileIter) {
  println(s"${file.toString} at URL: ${file.url}")
}

// Get contents of files
val sampleText = foo.file("sample.txt").getString
val binaryContent = foo.file("binary_file").getBytes
val tempFile = foo.file("myfile").getFile

// Delete files and directories
foo.file("sample.txt").delete()
foo.delete(true) // true implies force deleting the directory and its contents
````

### Additional resources

* <a href="/docs/lang/java">Algorithmia Client Java Docs <i class="fa fa-external-link"></i></a>
* <a href="https://github.com/algorithmiaio/algorithmia-java">Algorithmia Java Client Source <i class="fa fa-external-link"></i></a>
