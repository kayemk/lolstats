#!/bin/sh
git config --global user.email "noreply@cicici.org"
git config --global user.name "ci"

git add .
git commit -m "Update"
