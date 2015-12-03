## Java Client

The Algorithmia Java client is available on Github, published to Maven Central, and automatically available to any algorithm you create on the Algorithmia platform.

### Getting started

> Add the Java client as a dependency:

```
<dependency>
  <groupId>com.algorithmia</groupId>
  <artifactId>algorithmia-client</artifactId>
  <version>[,1.1.0)</version>
</dependency>
```

The Algorithmia java client is published to Maven central. It is already listed as a dependency for new algorithms written in Java in the marketplace.


#### Instantiate a client:

In your application:

`AlgorithmiaClient client = Algorithmia.client("@apiKey");`

In an algorithm on the Algorithmia platform:

`AlgorithmiaClient client = Algorithmia.client();`


<aside class="notice">
  Using version range `[,1.1.0)` is recommended as it implies using the latest backward-compatible bugfixes.
</aside>

### Calling Algorithms

> Algorithms called with the `.pipe()`:

```
AlgoResponse response = client.algo("docs/JavaAddOne").pipe(72);
Integer result = response.as(new TypeToken<Integer>(){});
Double durationInSeconds = response.getMetadata().getDuration();
```

There are two ways to call an algorithm: `.pipeJson` and `.pipe`.

`.pipeJson:` 

* Use pipeJson when you are manually converting objects to JSON. This can be useful when working on edge cases or in testing.  

* We recommend that you use .pipe whenever possible.

`.pipe:`  

* Use .pipe whenever possible. .pipe will take an object and convert it into the JSON structure required.  

* You can use .pipe with binary files. No JSON serialization is required with .pipe.


#### Casting results


> For an algorithm that returns a string:

```
stringResult.as(new TypeToken<String>(){});
```

> For an algorithm that returns an array of strings:

```
stringArrayResult.as(new TypeToken<List<String>>(){});
```

> For an algorithm that returns a custom class, cast the result to that class:

```
class CustomClass {
    int maxCount;
    List<String> items;
}
customClassResult.as(new TypeToken<CustomClass>(){});
```

> For debugging, it is often helpful to get the JSON String representation of the result:

```
anyResult.asJsonString();
```

In order to cast the result to a specific type, call `.as()` with a TypeToken.
On the right pane, you'll find examples of how to do this to return a string, an array of strings, and a custom class.

<aside class="notice">
  To create a TypeToken, use the syntax `new TypeToken<CustomClass>(){}` ensuring that the trailing `{}` is present to create an anonymous subclass.
</aside>


### Working with Data

The Algorithmia Java Client provides an easy way to manage data stored within Algorithmia. Basic usage samples are shown to the right. See the [Data API](#the-data-api) for more information.

> Create a directory "foo"

```
DataDirectory foo = client.dir("data://.my/foo");
foo.create();
```
> Upload files to "foo" directory

```
foo.file("sample.txt").put("sample text contents");
foo.file("binary_file").put(new byte[] { (byte)0xe0, 0x4f, (byte)0xd0, 0x20 });
foo.putFile(new File("/local/path/to/myfile"));
```

> List files in "foo"

```
for(DataFile file : foo.getFileIter()) {
    System.out.println(file.toString() + " at URL: " + file.url());
}
```

> Get contents of files

```
String sampleText = foo.file("sample.txt").getString();
byte[] binaryContent = foo.file("binary_file").getBytes();
File tempFile = foo.file("myfile").getFile();
```

> Delete files and directories

```
foo.file("sample.txt").delete();
foo.delete(true); // true implies force deleting the directory and its contents
```

### Additional resources

* <a href="http://www.javadoc.io/doc/com.algorithmia/algorithmia-client/1.0.3">Algorithmia Client Java Docs <i class="fa fa-external-link"></i></a>
* <a href="https://github.com/algorithmiaio/algorithmia-java">Algorithmia Java Client Source Code<i class="fa fa-external-link"></i></a>
