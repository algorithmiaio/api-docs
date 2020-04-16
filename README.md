Algorithmia API Documentation
=============================

This repository houses the documentation for Algorithmia's API.

## Getting Started

### Local Development

First, ensure you have Ruby 2.3.1 or later installed on your system. Then, with the repository as your active working directory, run the following to install necessary packages:

```
bundle install
```

 If Ruby is already installed, but the `bundle install` command doesn't work, just run `gem install bundler` and try the above command once more.

Then run the following to fire up a development server:

```
bundle exec middleman server
```

And voila! Your development server is available at `localhost:4567`, and will automatically update with any changes you make.

### Building for Production

To build the static assets for this documentation, simply run:

```
bundle exec middleman build --clean
```

A `build` directory will be created that contains all of the production-ready static assets for this documentation.

## Contributing

Want to add documentation for a new API resource or endpoint? Huzzah! Follow this checklist to ensure you add all of the necessary information.

### If you're adding a new resource:

- First, create a new file in `source/includes` specifically for your resource. Title it `_${resource_name}`, e.g. `_users.md`, `_organization_members.md`, etc...
- Add the name of this file to the `includes` section at the top of `index.html.md` file. Alphabetical ordering please!
- Within your new file, add a section to the top that fully describes the resource and the properties it might possess. For an example, take a look at the `_algorithms.md` file: it possesses a section titled "The algorithm object" which describes every property an `algorithm` object might possess.
- For each property, provide the name of the property (for nested properties use dot notation, e.g. `obj1.property`), the data type, and a description of the property.
- For each endpoint that can be used to modify a resource type, follow the instructions below on how to add an endpoint.

### If you're adding a new endpoint for a resource:

- Find the file in `source/includes` for the resource you wish to add an endpoint for. If one doesn't exist, take a look at the section above on adding a new resource.
- Endpoints are ordered by CRUD: create, read, update, then delete. If your endpoint doesn't fit one of those categories, use your best judgement to determine where it should fit within the file, and try to observe conventions used in other resource files.
- Add the following to your description of the new endpoint:
  - Examples for cURL and Python.
  - The REST API endpoint backing the endpoint, e.g. `PUT /algorithms/:username/:algoname`.
  - A description of any and all inputs, such as path and query parameters and the structure a request body should take (if one is required).
  - A description of what will be returned upon success or failure, and an example for the success case.

When in doubt, take a look at how other endpoints have been documented, and leverage existing conventions. If you need to alert a user to sharp edge, or simply point out a nuance, leverage an `aside` element (check out the examples in [the Slate demo](https://slatedocs.github.io/slate/#introduction)).
