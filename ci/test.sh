#!/bin/bash

set -e -x

pushd lolstats-staging
  #bundle exec rspec
  bundle install
  #bundle exec rake test
  bin/rails test
popd
