[![Run Status](https://api.shippable.com/projects/56709c711895ca4474666740/badge?branch=master)](https://app.shippable.com/projects/56709c711895ca4474666740)

API Docs
========

Welcome to the repository for Algorithmia's API. Here you will find the API reference, as well as some documentation on getting started with the API and basic set up.

These docs are built on Slate. Learn more over at [the official repo](https://github.com/tripit/slate).

Running locally
------------------------------

### Prerequisites

You're going to need:

 - **Linux or OS X** — Windows may work, but is unsupported.
 - **Ruby, version 1.9.3 or newer**
 - **Bundler** — If Ruby is already installed, but the `bundle` command doesn't work, just run `gem install bundler` in a terminal.

### Getting Set Up

 1. Fork this repository on Github.
 2. Clone *your forked repository* with `git clone https://github.com/YOURUSERNAME/api-docs.git`
 3. `cd api-docs`
 4. Install all dependencies: `bundle install`. If you are having trouble with some of the gems, try running `bundle update`, then run `bundle install` again.
 5. Start the test server: `bundle exec middleman server`

You can now see the docs at <http://localhost:4567>. Whoa! That was fast!

If you are making any changes to the stylesheets or javascript, run `rake build` to re-build the project so you can see your changes.

### How to add new files

To add a new file and have it included in the navigation, be sure to add it to the `includes:` field of the front-matter in `index.rb`. Note that while the files are prefaced with an underscore, here in the front-matter, the underscore is unnecessary. You also do not need to include the file extension.

```
...
includes:
  - introduction
  - authentication
  - apispecification
  - data
  - dataapispecification
  - clients/cli
...

```


### Language Tabs

Adding a new language to the docs is easy! To get a new language tab, simply add the language to the front-matter in `index.rb`. 

```
language_tabs:
  - shell: cURL
  - cli: CLI
  - python
  - java
  - scala
  - javascript
  - nodejs
```

Need to add a custom lexer? Add it in `custom_lexers.rb`.

If you add a new language, be sure to add code samples for each snippet that appears in other languages! The docs are only complete when there is language parity.

Contributing
-------------

First, check out a new branch and make any changes on that branch. When you are ready, make a pull request to this repo and we will review the changes. Be sure to describe the changes, attach screenshots of any cosmetic changes, and if applicable, link to the open issue.


Need Help? Found a bug?
----------------


If you find a bug, can't follow the documentation or have a question – [submit an issue!](https://github.com/algorithmiaio/api-docs/issues)

We will respond to you or reach out for more information as soon as possible. And, of course, feel free to submit pull requests with bug fixes or changes.
