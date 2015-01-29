FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /signupsumo
WORKDIR /signupsumo
ADD Gemfile /signupsumo/Gemfile
RUN bundle install
ADD . /signupsumo
