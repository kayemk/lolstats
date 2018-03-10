#FROM rails:5.1.4
FROM ruby:2.4.2
MAINTAINER kayemk <contact@kayemk.net>
RUN apt-get update -qq && apt-get install -y build-essential && mkdir -p /var/app
WORKDIR /var/app
COPY Gemfile /var/app/Gemfile
RUN bundle install
#CMD rails s -b 0.0.0.0
