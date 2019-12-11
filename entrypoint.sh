#!/bin/bash
BRANCH=${GITHUB_BRANCH:-gh-pages}
mkdir build
cd build
remote_repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" 
remote_branch=${INPUT_GITHUB_BRANCH:-gh-pages} 
git init 
git remote add origin $remote_repo 
git config user.name "${GITHUB_ACTOR}" 
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com" 
git fetch 
git checkout $remote_branch

cd ..
bundle install
bundle list | grep "jekyll ("
bundle exec rake generate
cd build

git add . 
echo -n 'Files to Commit:' && ls -l | wc -l 
git commit -m"action build `date`" > /dev/null  
git push > /dev/null  
rm -fr .git 
cd ../
