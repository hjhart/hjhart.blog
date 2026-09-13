FROM ruby:3.2
RUN apt-get update -qq && apt-get install -y build-essential nodejs

WORKDIR /site

COPY Gemfile* ./

RUN bundle install

COPY . .
