## Java Algorithm Development

#### Available APIs

Algorithmia makes a number of libraries available to make algorithm development easier.
The full <a href="http://docs.oracle.com/javase/8/docs/technotes/guides/language/index.html">Java 8 language and standard library</a>
is available for you to use in your algorithms. Furthermore, algorithms can call other algorithms and manage data on the Algorithmia platform
via the <a href="http://developers.algorithmia.com/clients/java/">Algorithmia Java Client</a>.

#### Managing Dependencies

Algorithmia supports adding 3rd party dependencies via Maven packages. Specifically, any packages from
<a href="http://search.maven.org/">Maven Central</a> can be added to algorithms.
On the algorithm editor page, click Options and select Manage Dependencies.

Add dependencies by adding lines of the following form:

`<dependency org="{GroupID}" name="{ArtifactID}" rev="{Version}" conf="default" changing="true"/> `

For example, to add Apache Commons Math version 3.4.1,

`<dependency org="org.apache.commons" name="commons-math3" rev="3.4.1" conf="default" changing="true"/>`

#### Automatic JSON parsing

```java
package algorithmia.docs.Example;
import com.algorithmia.*;

public class Example {
    public String apply(Map<String,String> dict, String key) {
        return dict.get(key);
    }
}
```

By default, Algorithmia uses Google's <a href="https://code.google.com/p/google-gson/">GSON</a> library for converting JSON to and from
native Java objects. You can specify the input and output types of your algorithm simply by setting the parameters and return type of
your `apply()` method.

This example shows a function that takes two parameters, a Map from Strings to Strings (dict) and another String (key), and returns another String.

Algorithmia can automatically parse many types of native Java objects to and from JSON: Integers, Lists, Arrays, Maps, and many others. In many cases it can also parse arbitrary user-defined Java Classes to and from JSON. See the <a href="https://sites.google.com/site/gson/gson-user-guide">Gson User Guide</a> for reference.

<aside class="notice">
  Note: Binary data is passed using <code>byte[]</code>
</aside>

#### Error Handling

```java
throw new AlgorithmException("Invalid graph structure");
```

Algorithms can throw any exception, and they will be returned as an error via the Algorithmia API. If you want to throw a generic exception message, use an `AlgorithmException`.

#### Calling Other Algorithms and Managing Data

To call other algorithms or manage data from your algorithm, use the [Algorithmia Java Client](#java-client) which is automatically available to any algorithm you create on the Algorithmia platform.

When designing your algorithm, don't forget that there are special data directories, `.session` and `.algo`, that are available only to algorithms to help you manage data over the course of the algorithm execution.

<aside class="warning">
Some older algorithms use our deprecated Java client. If it has an import from the <code>algorithmia</code> package instead of the <code>com.algorithmia</code> package, that means it is using the deprecated client.
</aside>


#### Additional Resources

* <a href="http://developers.algorithmia.com/clients/java/">Algorithmia Client Java Docs <i class="fa fa-external-link"></i></a>
* <a href="http://docs.oracle.com/javase/8/docs/api/">Java 8 JDK API</a>
