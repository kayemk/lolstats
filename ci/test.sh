#!/bin/bash

set -e -x

pushd lolstats
  bundle install
  bundle exec rspec
popd
