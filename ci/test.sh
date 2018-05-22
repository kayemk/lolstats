#!/bin/bash

set -e -x

pushd lolstats
  #bundle exec rspec
  bundle exec rake test
  #bin/rake test
popd
