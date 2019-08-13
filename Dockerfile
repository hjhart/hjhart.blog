FROM ruby:2.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /site

COPY Gemfile* ./

RUN bundle install

COPY . .
