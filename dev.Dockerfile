FROM ruby:3.1.0

RUN mkdir -p /usr/src/app
ADD ./Gemfile* /usr/src/app/
ADD . /usr/src/app
WORKDIR /usr/src/app

RUN gem install bundler

RUN bundle
