## Java Client

[needs review]
[needs formatting]

The Algorithmia Java client is available on Github, published to Maven Central, and automatically available to any algorithm you create on the Algorithmia platform.

### Getting started

The Algorithmia java client is published to Maven central. It is already a dependency of new algorithms in the marketplace. It can be added as a dependency to other projects via:

````xml
<dependency>
  <groupId>com.algorithmia</groupId>
  <artifactId>algorithmia-client</artifactId>
  <version>[,1.1.0)</version>
</dependency>
````

Instantiate a client:
````java
//In your application:
AlgorithmiaClient client = Algorithmia.client("@apiKey");

//In an algorithm on the Algorithmia platform:
AlgorithmiaClient client = Algorithmia.client();
````

Notes:

- Using version range `[,1.1.0)` is recommended as it implies using the latest backward-compatible bugfixes.


### Calling Algorithms

There are two ways to call an algorithm: `.pipeJson` and `.pipe`.

`.pipeJson:` 

* Use pipeJson when you are manually converting objects to JSON. This can be useful when working on edge cases or in testing.  

* We recommend that you use .pipe whenever possible.

`.pipe:`  

* Use .pipe whenever possible. .pipe will take an object and convert it into the JSON structure required.  

* You can use .pipe with binary files. No JSON serialization is required with .pipe.

Algorithms called with the `.pipe()` method are shown below:

````java
AlgoResponse response = client.algo("docs/JavaAddOne").pipe(72);
Integer result = response.as(new TypeToken<Integer>(){});
Double durationInSeconds = response.getMetadata().getDuration();
````

In order to cast the result to a specific type, call `.as()` with a TypeToken, for example:

````java
// For an algorithm that returns a String
stringResult.as(new TypeToken<String>(){});

// For an algorithm that returns an array of Strings
stringArrayResult.as(new TypeToken<List<String>>(){});

// For an algorithm that returns a custom class, cast the result to that class
class CustomClass {
    int maxCount;
    List<String> items;
}
customClassResult.as(new TypeToken<CustomClass>(){});

// For debugging, it is often helpful to get the JSON String representation of the result
anyResult.asJsonString();
````

Note: To create a TypeToken use the syntax `new TypeToken<CustomClass>(){}` making sure to have the trailing `{}` to create an anonymous subclass.

### Working with Data

Algorithmia supports creating <a href="@routes.Data.list">Data Collections</a> making it easy to get data into and out of algorithms.
In the simplest case, you can feed data to an algorithm at request time.
For applications with larger data requirements, Algorithmia allows you to create named collections of independent documents.
These collections are created on a per-user basis, and you control the access on a per-collection basis.

The Algorithmia Java Client provides an easy way to manage data stored within Algorithmia. Basic usage samples are described below. See the [DataAPI docs](../data.md) for more information.


````java
// Create a directory "foo"
DataDirectory foo = client.dir("data://.my/foo");
foo.create();

// Upload files to "foo" directory
foo.file("sample.txt").put("sample text contents");
foo.file("binary_file").put(new byte[] { (byte)0xe0, 0x4f, (byte)0xd0, 0x20 });
foo.putFile(new File("/local/path/to/myfile"));

// List files in "foo"
for(DataFile file : foo.getFileIter()) {
    System.out.println(file.toString() + " at URL: " + file.url());
}

// Get contents of files
String sampleText = foo.file("sample.txt").getString();
byte[] binaryContent = foo.file("binary_file").getBytes();
File tempFile = foo.file("myfile").getFile();

// Delete files and directories
foo.file("sample.txt").delete();
foo.delete(true); // true implies force deleting the directory and its contents
````

### Additional resources

* <a href="/docs/lang/java">Algorithmia Client Java Docs <i class="fa fa-external-link"></i></a>
* <a href="https://github.com/algorithmiaio/algorithmia-java">Algorithmia Java Client Source <i class="fa fa-external-link"></i></a>
