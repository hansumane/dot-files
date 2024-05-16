#!/usr/bin/env bash
set -xe

cd 'dot-files'  # repo name

git ls-files > ../to-keep.txt
git filter-branch --force --index-filter \
  "git rm --ignore-unmatch --cached -qr . ; \
   cat $PWD/../to-keep.txt | tr '\n' '\0' | xargs -d '\0' git reset -q \$GIT_COMMIT --" \
  --prune-empty --tag-name-filter cat -- --all

rm -rf .git/refs/original
git reflog expire --expire=now --all
git gc --aggressive --prune=now

cd -
