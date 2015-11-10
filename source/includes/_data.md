# The Data API

The Algorithmia Data API makes it easy to get your data into and out of Algorithmia.

The Algorithmia API allows for up to 10 Mib of data to be fed into an algorithm at request time. However, you may find yourself wanting to apply Algorithmia to applications with larger data requirements. The Algorithmia Data API allows you to create collections of files. These collections are created on a per-user basis and you can control the access and visibilty of the data.

## When should I use the Data API?

The Algorithmia Data API is used when you have large data requirements.

* preserve state?
* keep data in one place?
* other reasons to use this?

* when do I have to use the data api?


## Collection Types

* what is a collection?

There are four types of collections: User collections, Session collections, Permanent Algorithm collections, and Temporary Algorithm collections.

## User Collections

```
data://:username/:collection

data://:username/:collection/:filename
```

Users can create named collections of data that can be controlled by collection-based Access Control Lists (ACLs). This allows you to manange the permissions for each collection from the Data page.

Each collection has its own ACLs, and there are three types of permissions for reading data from a collection. Only you can write to your own collections, so they are by default marked as private.

### Private (only me):

When you set your collection read access to Private, only you will be able to read and write to the Data collection. This is the most restrictive option. This permission setting is the only option available for writing to collections to prevent involuntary data retention.

### My Algorithms (called by any user):

If you select this permission option for your data collection, it will allow other users on the platform to interact with your data through your algorithms. This means they can call your algorithm to perform an operation on your data stored in this collection. This option is perfect for showcasing the algoriths and letting the users get an idea of what they can do on your sample data.

### Public (anybody):

Anyone can read the data in your collection, feed that data to their algorithms, or copy the data to their own collections.

### The `.my` pseudonym

```
data://.my/:collection
data://.my/:collection/:filename
```

If you are operating on your own directories / files you can use the .my pseudonym and the username will be assumed from the authorization provided.

<aside class="warning">
Avoid using the `.my` pseudonym in the program code of an algorithm. When the algorithm is executed, `.my` will be interpreted as the username of the user who called the algorithm, rather than the author's username.
</aside>

## Session Collections

If using Data URI within Algorithmia:

data://.session/:filename
The session directory exists for each Algorithm Session and is only accessible to algorithms within that session

* What makes a session?
* when do you use this collection
* why isn't there a "session" section on the data page?
* example?

## Temporary Algorithm Collections

> Access temporary collections with this URI format from inside of Algorithmia or using a client:

```
data://.algo/:author/:algoname/temp/:filename
```
Temporary algorithm collections give you a space to store data on a temporary basis. You will find the temporary collections under a `temp` directory inside of an algorithm collection. For example, a user can have an algorithm that produces a file inside of a temporary collection.

### The Simplified Format

> Simplified URI format:

```
data://.algo/temp/:filename
```

If you are using the Data URI from inside Algorithmia, you can also use a simplified form of the URI. This simplified version will infer the algorithm when it is being called so that you don't have to specify the author and algorithm name.

Temporary algorithm collections are ideal for storing data on a short term basis. This data is deleted after approximately one day. This temporary state is perfect for showcasing sample input in an algorithm that generates an output. If you store the output in a temporary algorithm collection, the results from teh algorithm will be cleaned up automatically, allowing users to try the algorithm without creating permanent data.

## Permanent Algorithm Collections
If using api-key auth from outside of Algorithmia (for example, when using a client) or from inside Algorithmia:

data://.algo/:author/:algoname/perm/:filename
Use this form when accessing an algorithm collection from a specific algorithm. For example, if the user docs had an algorithm called CollectionWriter that produced a file called file.csv in its perm directory, this file could be accessed as

data://.algo/docs/CollectionWriter/perm/file.csv
If using Data URI from inside Algorithmia, you may optionally use the simplified form, in which the algorithm triggering the call will be assumed:

data://.algo/perm/:filename

## more
* algorithm data vs my collections
* perm vs temp vs session
* what kinds of permissions are there


