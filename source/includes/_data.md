# The Data API

The Algorithmia Data API makes it easy to get your data into and out of Algorithmia.

The Algorithmia API allows for up to 10 Mib of data to be fed into an algorithm at request time. However, you may find yourself wanting to apply Algorithmia to applications with larger data requirements. The Algorithmia Data API allows you to create collections of files. These collections are created on a per-user basis and you can control the access and visibilty of the data.

## When should I use the Data API?

The Algorithmia Data API is used when you have large data requirements or need to preserve state between calls. It allows algorithms to access data from within the same sesion, but ensures that your data is safe. 

There are many different collection types that have different features and security measures in place. Data in your temporary and user collections can be downloaded to be saved locally. 

## Collection Types

There are four types of collections: User collections, Session collections, Permanent Algorithm collections, and Temporary Algorithm collections.

User collections can store data and allow you to set the read permission on that collection.

Other collection types have system-defined permissions:

* Session Collections only have read/write access from within the same session.
* Temporary and Permanent Algorithm collections have read/write access from internal calls and this data collection type is guaranteed to exist for every algorithm.

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

If you are operating on your own directories or files you can use the .my pseudonym and the username will be assumed from the authorization provided.

<aside class="warning">
If you are authoring an algorithm, avoid using the `.my` pseudonym in the source code. When the algorithm is executed, `.my` will be interpreted as the username of the user who called the algorithm, rather than the author's username.
</aside>

## Session Collections

> The format for session collections when using Data URI within Algorithmia:

```
data://.session/:filename
```

Session collections exist for each Algorithm Session and is only accessible to algorithms within that session. 

The Algorithm session is defined as the scope of the original request and any other subsequent calls withing the tree. When the original request ends, the session collection is no longer available. 

Session collections allow data to be used across multiple algorithms within the scope of one call. This is useful for algorithm developers so that they may ensure access to data on a temporary basis. These collections are no longer available after the request, thus giving the caller security that their data will not be available outside the scope of the session.


## Temporary Algorithm Collections

> Access temporary collections with this URI format from inside of Algorithmia or using a client:

```
data://.algo/:author/:algoname/temp/:filename
```
Temporary algorithm collections give you a space to store data on a temporary basis. You will find the temporary collections under a `temp` directory inside of an algorithm collection. For example, a user can have an algorithm that produces a file inside of a temporary collection.

The temporary algorithm collections are particularly useful for algorithms that produce files as a result of the sample input. For example, if your sample input generates a file, using a temporary algorithm collection allows the algorithm to store its output but will be cleaned up after a day. 

### The Simplified Format

> Simplified URI format:

```
data://.algo/temp/:filename
```

If you are using the Data URI from inside Algorithmia, you can also use a simplified form of the URI. This simplified version will infer the algorithm when it is being called so that you don't have to specify the author and algorithm name.

Temporary algorithm collections are ideal for storing data on a short term basis. This data is deleted after approximately one day. This temporary state is perfect for showcasing sample input in an algorithm that generates an output. If you store the output in a temporary algorithm collection, the results from the algorithm will be cleaned up automatically, allowing users to try the algorithm without creating permanent data.

## Permanent Algorithm Collections

> Access permanent collections with this URI format from inside of Algorithmia or using a client:

```
data://.algo/:author/:algoname/perm/:filename
```

If you need to access a collection from a specific algorithm, you can use the permanent collection. This allows users to generate output that is saved permanently as a result of running the algorithm. Unlike the Temporary Algorithm Collections, the data stored in the permanent is not cleared after one day.

### The Simplified Format

> Simplified URI format:

```
data://.algo/perm/:filename
```

If you are using the Data URI from inside Algorithmia, you can also use a simplified form of the URI. This simplified version will infer the algorithm when it is being called so that you don't have to specify the author and algorithm name.




## more

general questions to help clarify docs:

* algorithm data vs my collections (on the data page)

potential "why" questions about the Data api:

* why should I use this instead of saving stuff myself on my own storage?
* what is an algorithm outputs to data:// do I have to use the data api?
* is there a usage fee for data

