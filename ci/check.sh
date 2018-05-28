#!/bin/sh

pushd lolstats-staging
  whoami
  env
  ruby --version
popd
