# Algorithm Development

As an Algorithmia user, in addition to having access to hundreds of algorithms, you also have the ability to add your own algorithms. You can write a private algorithm for your own use, contribute an open source algorithm, or monetize an algorithm you authored. Our algorithms and platform are designed with composability in mind, so think of algorithms in the marketplace as building blocks.


We currently support algorithm development in Java, Scala, and Python, but we are working on expanding this list. If you have algorithma code you'd like to host on the Algorithmia platform in a different language, please get in touch! We are able to host executables in some special cases. 

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

### Description:

The algorithm description is front-and-center on the algorithm profile page. Use the description to write a clear explanation of what the algorithm does, what kind of input it takes, and what kind of output the user can expect. Be sure to highlight the various ways your algorithm can be used so that users get a thorough understanding of what types of problems the algorithm solves. 

### Tagline:

The tagline for your algorithm is a succinct way to let potential users quickly understand what it does. This tagline will appear under the title of your algorithm in marketplace search results, so a clear tagline can be very beneficial.

### Sample Input:

It is crucial to have sample input for the user to see what your algorithm will output. Users will look to your sample input to see if the algorithm can be applied to their data, so the more clear you are about what kinds of input the algorithm takes, the easier it will be for a user to get up to speed on how to use your algorithm.

The sample input is editable at any time. The latest publicly callable version of your algorithm is used to process the sample input and the result will automatically appear on your algorithm's profile page as the sample output. If the sample output is not what you expected from the input, be sure to check your algorithm for bugs. 

### Tags:

You can add tags to your algorithm to help its discoverability in the marketplace. These tags help ensure that your algorithm is visible and easily found when a user is browsing the marketplace. It's advantageous for algorithm developers to use the correct tags.

You'll also see categories of algorithms as you browse the marketplace. Categories are derived from tags on individual algorithms, so be sure to add any appropriate tag to your algorithm to help increase your algorithm's visibility. 

### Algorithm Console:

The console on the algorithm profile allows users to experiment with the algorithm. By default it will run the latest version of an algorithm that is published for public use.

### Algorithm Metadata:

Several additional pieces of metadata are displayed alongside each algorithm:

* Input/Output Types: Automatically determined from your algorithm's code.
* API Calls: The lifetime number of calls made to any version of the algorithm.
* Version: The latest semantic version published for public use. See [versioning](#versioning) for more details.
* Cost Breakdown: A calculator that includes the royalty fee and average call time. See [pricing](#pricing) for more details.
* Permissions: Any special permissions that this algorithm requires. See [permissions](#permissions) for more details.
* Source Availability: The license and source visibility of an algorithm. See [permissions](#permissions) for more details.


## Managing dependencies

## Errors

## JSON


## Algorithm Development FAQ

### What languages can I write my algorithm in?

We currently support algorithm development in Java, Scala, and Python. We are adding new languages constantly. To request a language send us email at <a href="mailto:support@algorithmia.com">support@algorithmia.com</a>..

### Who can contribute to the Algorithmia Marketplace?

Anyone can contribute algorithms to the marketplace!


### I am an algorithm developer, how do I make money?

When adding your algorithm to the marketplace, you can determine the unit of charge in Algorithmia credits. Each time your algorithm is called through the API, we meter it and charge the caller's credit account. When you're ready to cash out on the credits you've earned as an algorithm developer, we use PayPal to securely deliver your earnings.

Although you are able to change the royalty fee when releasing new versions, please note that algorithms which are made available for free are not allowed to charge later on minor version changes. This ensures that users of the algorithm have predictable access to a particular version. Compute time will still have a cost for users accessing your algorithm even if it is open source and royalty free.

### I want my algorithm to be open source, can my algorithm be free of royalty charges?

Yes! You can make your work completely open source and free while allowing developers across the world access to your algorithm. As an incentive to promote community contributions, open source algorithms on the Algorithmia Platform will earn 1% of the usage cost (0.01cr/sec of execution time).

### How do I avoid others copying my source code?

Algorithmia has multiple permission modes for your algorithm, including viewable source code and private code. While we encourage making your source code viewable, “black-box” algorithms are allowed.

If you believe there has been a copyright violation, please report it by following the instructions under the section "Copyright Complaints" in the Terms and Conditions.

### Who owns the intellectual property rights of uploaded source code?

The author retains the intellectual property rights of their algorithm. Algorithmia never takes any ownership of your code, documents, or data. These are always owned by the original author and are free to be commercialized through channels other than Algorithmia.

### Can I use external libraries with my algorithms?

Yes, any library in Maven Central can be imported. See [this algorithm](https://algorithmia.com/algorithms/kenny/LDA/edit) as an example.

### How do I claim a bounty with my algorithm?

To claim the bounty, first make sure that the algorithm is published under your account. Then go to the bounty page, click the "Fulfill Bounty" button and follow the steps to select your algorithm. The bounty poster will have 30 days to review your algorithm, give feedback, and accept the submission. If accepted, we will notify you and credit your account.
