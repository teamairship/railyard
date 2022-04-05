# railyard

Railyard is a Rails application template used to scaffold rails 7 projects.  Heavily influenced by mattbrictson/rails-template

## Requirements

This template currently works with:

* Rails 7.0.x
* Bundler 2.x
* PostgreSQL
* chromedriver

## Installation

*Optional.*

To make this the default Rails application template on your system, create a `~/.railsrc` file with these contents:

```
-d postgresql
-m https://raw.githubusercontent.com/teamairship/railyard/main/template.rb
```

## Usage

To generate a Rails application using this template, pass the `-m` option to `rails new`, like this:

```
rails new blog \
  -d postgresql \
  -m https://raw.githubusercontent.com/teamairship/railyard/main/template.rb
```

*Remember that options must go after the name of the application.* The only database supported by this template is `postgresql`.

If you’ve installed this template as your default (using `~/.railsrc` as described above), then all you have to do is run:

```
rails new blog
```

## What does it do?

The template will perform the following steps:

1. Generate your application files and directories
2. Create the development and test databases
3. Sets up active storage
4. Sets up ci/cd
5. TODO: Commit everything to git

## What is included?

#### These gems are added to the standard Rails stack

* Core
    * Pundit
    * TODO: sidekiq
* Configuration
    * [dotenv][] – for local configuration
* Utilities
    * TODO: [annotate][] – auto-generates schema documentation
    * [guard][] – runs tests as you develop; mandatory for effective TDD
    * [rubocop][] – enforces Ruby code style
* Security
    * [brakeman][] and [bundler-audit][] – detect security vulnerabilities
* Testing

## How does it work?

This project works by hooking into the standard Rails [application templates][] system, with some caveats. The entry point is the [template.rb][] file in the root of this repository.

Rails generators are very lightly documented; what you’ll find is that most of the heavy lifting is done by [Thor][]. The most common methods used by this template are Thor’s `copy_file`, `template`, and `gsub_file`. You can dig into the well-organized and well-documented [Thor source code][thor] to learn more.

[sidekiq]:http://sidekiq.org
[dotenv]:https://github.com/bkeepers/dotenv
[annotate]:https://github.com/ctran/annotate_models
[guard]:https://github.com/guard/guard
[rubocop]:https://github.com/bbatsov/rubocop
[brakeman]:https://github.com/presidentbeef/brakeman
[bundler-audit]:https://github.com/rubysec/bundler-audit
[application templates]:http://guides.rubyonrails.org/generators.html#application-templates
[template.rb]: template.rb
[thor]: https://github.com/erikhuda/thor
