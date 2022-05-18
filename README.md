# Railyard

Railyard is a tool to scaffold applications. It is meant to be extendable to create any type of project
but mainly focuses on Rails. When you create a project with Railyard, you will be able to choose what dependencies get installed.

** Note ** In terms of maturity, this project has some growing up to do. It can currently create a project successfully but be aware there may be some edge cases where selected options could conflict and some manual setup will still be required to finalize installation of some dependencies. If you run into any issues feel free to open an issue.

## Dependencies

Ensure that NPM is up to date before generating an app.

The project is currently setup to utilize Ruby 3.1.x and works with versions 6-7 of Rails. Although we do recommend using the latest release of Rails 7.

To utilize this project, please ensure you have whatever version of Ruby is specified in the Gemfile file in the root of the project.

## Installation

To utilze the project pull down the repository from Github:

```
git clone git@github.com:teamairship/railyard.git [DESIRED DIRECTORY HERE]
cd [DESIRED DIRECTORY HERE]
```

Ensure that you have the appropriate Ruby installed and gemset setup for the project then bundle install:

```
bundle install
```

Note that you can use the Rails version of your preference and will have to install that manually:

```
gem install rails
```

## Usage

To see the available commands, run the following from the directory where Railyard is located:

```
./bin/railyard
```

To start scaffolding a project:

```
./bin/railyard create [PATH TO DESIRED DIRECTORY]
```

Answer the questions about dependencies as you are prompted.


Change into the directory where you generated your app:

```
cd [DIRECTORY OF GENERATED APP]
bundle install
overcommit --install
yarn
foreman start
```

## Known Issues

Make sure your node and npm versions are up to date or you might run into build command not fount issues when trying to run the generated app if using Rails 7. You will need to remove and regenerate the app once up to date.

[https://stackoverflow.com/questions/70482086/rails-7-0-esbuild-running-app-gives-error-command-build-not-found](https://stackoverflow.com/questions/70482086/rails-7-0-esbuild-running-app-gives-error-command-build-not-found)

## Development Details

Railyard is meant to be extendable and you can add any number of Frameworks or options but currently there is only one starter template for Rails found under the `/rails` directory.

There is a main `template.rb` file found in the `/rails` directory. This is the main entry point for the Rails generator and any core dependency will be listed here. Only functionality that is common between project types should be included in this file otherwise a `blueprint` should be utilized.

### Blueprints vs Templates

Currently dependencies can be installed one of two ways:

- One at a time with generic configurations with `Blueprints`.
- Many at a time with specific configurations with `Templates`.

### Blueprints

Within the `/rails` directory, you will also find a `/blueprints` folder where the specific Rails options are located. Any number of `blueprints` can be added to the project. Currently there are options for Tailwind, Devise, GraphQl, JS linting, Pundit and Rspec.

The current expectation is that you can select any number of blueprints and they should play nicely relative to the other selections.

### Adding a Blueprint

Adding a blueprint is fairly straightforward. There are some folders located in `/rails/blueprints` directory to use as examples. The main concept is that each blueprint has an entry `template.rb` file. 

Once the `template.rb` file is added and assuming the correct file structure is followed, the blueprint will automatically be recognized and executed on the next run.

### Templates

Within the `rails/blueprints` directory you will find the `templates` folder.

A `template` is a collection of `blueprints` or a collection of dependencies pre-configured in a specific way.

An example template has been included in the `templates/example_template` directory. Other templates can be added by following this file structure.

### How does it work?

Each blueprint and template is a collection of [Thor][] commands.

This project works by hooking into the standard Rails [application templates][] system, with some caveats. The entry point is the [template.rb][] file in the root of this repository.

Rails generators are very lightly documented; what you’ll find is that most of the heavy lifting is done by [Thor][]. The most common methods used by this template are Thor’s `copy_file`, `template`, and `gsub_file`. You can dig into the well-organized and well-documented [Thor source code][thor] to learn more.

Thor can run pretty much anything that could be run from the command line. It can run Ruby commands as well as node commands for example.

### Testing

When a blueprint is added, take special care to carefully inspect the generated app. Does it work? Does it work relative to other possible option combinations? It could appear that an integration is successful initially but fail on check in or in the CI/CD stage. By ensuring the blueprint plays nice with things like foreman and overcommit, we can ensure a stable experience for everyone.

Beyond manual testing, there are not currently tests for the project but would be ideal in the future.

### Branching and Merging Strategy

New branches should be created for features, bug fixes, etc:

- feature/name-of-feature
- bugfix/name-of-bugfix
- hotfix/name-of-hotfix
- release/name-of-release

Pull requests are made into the `main` branch.

## MIT License

Copyright 2022 Airship

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[sidekiq]: http://sidekiq.org
[dotenv]: https://github.com/bkeepers/dotenv
[annotate]: https://github.com/ctran/annotate_models
[guard]: https://github.com/guard/guard
[rubocop]: https://github.com/bbatsov/rubocop
[brakeman]: https://github.com/presidentbeef/brakeman
[bundler-audit]: https://github.com/rubysec/bundler-audit
[application templates]: http://guides.rubyonrails.org/generators.html#application-templates
[template.rb]: template.rb
[thor]: https://github.com/erikhuda/thor
