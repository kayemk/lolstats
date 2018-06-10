#!/bin/bash

set -e -x

pushd lolstats-staging
  bundle update
  bundle install
popd
