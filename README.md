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


Contributing
-------------

First, check out a new branch and make any changes on that branch. When you are ready, make a pull request to this repo and we will review the changes. Be sure to describe the changes, attach screenshots of any cosmetic changes, and if applicable, link to the open issue.


Need Help? Found a bug?
----------------


If you find a bug, can't follow the documentation or have a question – [submit an issue!](https://github.com/algorithmiaio/api-docs/issues)

We will respond to you or reach out for more information as soon as possible. And, of course, feel free to submit pull requests with bug fixes or changes.
