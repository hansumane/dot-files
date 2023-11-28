#!/usr/bin/env bash
if [[ -f ./compile_flags.txt ]]; then
  echo $(<./compile_flags.txt)
elif git rev-parse --is-inside-work-tree &> /dev/null; then
  GIT_CMPFLAGS="$(git rev-parse --show-toplevel)/compile_flags.txt"
  if [[ -f "$GIT_CMPFLAGS" ]]; then
    echo $(<"$GIT_CMPFLAGS")
  else
    echo ''
  fi
else
  echo ''
fi
