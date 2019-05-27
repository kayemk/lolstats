FROM ruby:2.4.6-stretch

RUN apt-get update -qq && apt-get install -y build-essential && mkdir -p /var/app
#RUN gem install rails -v '5.1.6'
WORKDIR /var/app
ADD Gemfile Gemfile.lock /var/app/
RUN bundle install
