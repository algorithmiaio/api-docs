# Algorithm Development

As an Algorithmia user, in addition to having access to hundreds of algorithms, you also have the ability to add your own algorithms. You can write a private algorithm for your own use, contribute an open source algorithm, or monetize an algorithm you authored. Our algorithms and platform are designed with composability in mind, so think of algorithms in the marketplace as building blocks.

We currently support algorithm development in Java, Scala, and Python, but we are working on expanding this list. If you have algorithm code you'd like to host on the Algorithmia platform in a different language, please <a href="mailto:support@@algorithmia.com">get in touch</a>! We are able to host executables in some special cases.

## Algorithm Profiles

> To illustrate a good algorithm profile, below you'll find examples from the Sentiment Analysis algorithm.
> Ex. Description:

```
Identify and extract sentiment in given string. Sentiment analysis (also known as opinion mining) refers to the use of natural language processing, text analysis and computational linguistics to identify and extract subjective information in source materials. This algorithm takes an input string and assigns a sentiment rating in the range [0-4] (very negative, negative, neutral, positive, and very positive).
```

> Ex. Tagline:

```
Determine sentiment from text
```

> Ex. Sample input:

```
"Algorithmia loves you!"
```

> Ex. Tags:

```
nlp
sentiment analysis
stanford corenlp
text analysis
```

Your algorithm will be showcases on the marketplace through the description page. Make sure users can discover your algorithm by writing clear descriptions and tagging your algorithm. Below, we'll explain how to get the most out of your algorithm profile.

#### Description:

The algorithm description is front-and-center on the algorithm profile page. Use the description to write a clear explanation of what the algorithm does, what kind of input it takes, and what kind of output the user can expect. Be sure to highlight the various ways your algorithm can be used so that users get a thorough understanding of what types of problems the algorithm solves.

#### Tagline:

The tagline for your algorithm is a succinct way to let potential users quickly understand what it does. This tagline will appear under the title of your algorithm in marketplace search results, so a clear tagline can be very beneficial.

#### Sample Input:

It is crucial to have sample input for the user to see what your algorithm will output. Users will look to your sample input to see if the algorithm can be applied to their data, so the more clear you are about what kinds of input the algorithm takes, the easier it will be for a user to get up to speed on how to use your algorithm.

The sample input is editable at any time. The latest publicly callable version of your algorithm is used to process the sample input and the result will automatically appear on your algorithm's profile page as the sample output. If the sample output is not what you expected from the input, be sure to check your algorithm for bugs.

#### Tags:

You can add tags to your algorithm to help its discoverability in the marketplace. These tags help ensure that your algorithm is visible and easily found when a user is browsing the marketplace. It's advantageous for algorithm developers to use the correct tags.

You'll also see categories of algorithms as you browse the marketplace. Categories are derived from tags on individual algorithms, so be sure to add any appropriate tag to your algorithm to help increase your algorithm's visibility.

#### Algorithm Console:

The console on the algorithm profile allows users to experiment with the algorithm. By default it will run the latest version of an algorithm that is published for public use.

#### Algorithm Metadata:

Several additional pieces of metadata are displayed alongside each algorithm:

* Input/Output Types: Automatically determined from your algorithm's code.
* API Calls: The lifetime number of calls made to any version of the algorithm.
* Version: The latest semantic version published for public use. See [versioning](#versioning) for more details.
* Cost Breakdown: A calculator that includes the royalty fee and average call time. See [pricing](#pricing) for more details.
* Permissions: Any special permissions that this algorithm requires. See [permissions](#permissions) for more details.
* Source Availability: The license and source visibility of an algorithm. See [permissions](#permissions) for more details.
