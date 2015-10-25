#!/bin/bash

git config --global user.name 'mrizzoli'
git config --global user.email 'marco@rizzoli.me.uk'
git config --global push.default simple

# Make sure destination folder exists as git repo

# Generate the site
# Commit and push to github
mkdir -p /tmp/notes_src/deploy
cd /tmp/notes_src/deploy
git init

git remote add origin https://github.com/mrizzoli/notes_src.git
git checkout -b gh-pages
git pull origin gh-pages
rsync -a /home/marco/Downloads/notes_stuff/src/_site/* /tmp/notes_src/deploy

git add --all .
git commit -m 'Updating'
git push origin gh-pages --quiet
