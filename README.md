API Docs
========

Welcome to the repository for Algorithmia's API. Here you will find the API reference, as well as some documentation on getting started with the API and basic set up.


Contributing
------------------------------

### Prerequisites

You're going to need:

 - **Linux or OS X** — Windows may work, but is unsupported.
 - **Ruby, version 1.9.3 or newer**
 - **Bundler** — If Ruby is already installed, but the `bundle` command doesn't work, just run `gem install bundler` in a terminal.

### Getting Set Up

 1. Fork this repository on Github.
 2. Clone *your forked repository* (not our original one) to your hard drive with `git clone https://github.com/YOURUSERNAME/api-docs.git`
 3. `cd api-docs`
 4. Install all dependencies: `bundle install`. If you are having trouble with some of the gems, try running `bundle update`, then `bundle install` again.
 5. Start the test server: `bundle exec middleman server`

You can now see the docs at <http://localhost:4567>. Whoa! That was fast!

Make any changes you see fit. Be sure to check them out locally! 
When you are ready, make a pull request to this repo and we will review the changes.


Need Help? Found a bug?
--------------------

Just [submit a issue](https://github.com/algorithmiaio/api-docs/issues) to the API docs Github if you need any help. And, of course, feel free to submit pull requests with bug fixes or changes.