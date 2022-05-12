# railyard

Railyard is a Rails application template used to scaffold rails projects. It provides a way to easily install application dependencies at the time of project creation.

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

If you see a message similar to `*** NOTE: If you are prompted to 'overwrite' ./bin/dev, press Y. Press enter to continue. ***` then enter y and press enter to continue.

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

## How does it work?

This project works by hooking into the standard Rails [application templates][] system, with some caveats. The entry point is the [template.rb][] file in the root of this repository.

Rails generators are very lightly documented; what you’ll find is that most of the heavy lifting is done by [Thor][]. The most common methods used by this template are Thor’s `copy_file`, `template`, and `gsub_file`. You can dig into the well-organized and well-documented [Thor source code][thor] to learn more.

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
