Algorithmia API Documentation
=============================

This is an in-progress refresh of Algorithmia's API documentation. Stay tuned!

## Local Development

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
