#!/usr/bin/env bash
set -xe

REPO='dot-files'
FILENAME='font.ttf'

cd "$REPO"

## remove all files but those that present:
git ls-files > ../to-keep.txt
git filter-branch --force --index-filter \
  "git rm --ignore-unmatch --cached -qr . ; \
   cat $PWD/../to-keep.txt | tr '\n' '\0' | xargs -d '\0' git reset -q \$GIT_COMMIT --" \
  --prune-empty --tag-name-filter cat -- --all

## remove exactly specified file:
# git filter-branch --force --prune-empty --index-filter \
#   "git rm -f --cached --ignore-unmatch '$FILENAME'" \
#   --tag-name-filter cat -- --all

## shrink the repository:
rm -rf .git/refs/original
git reflog expire --expire=now --all
git gc --aggressive --prune=now

cd -
