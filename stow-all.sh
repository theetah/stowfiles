#!/bin/bash

# NOTE: this file is quite dated. not sure if i want to work on it anymore, as it's quite finnicky
# is bash the best language for this? probably not. too bad!

# TODO: very likely a way to fix below behavior being required, stow flags?
if [ ! -d ~/stowfiles ]; then
  echo "repo was cloned incorrectly; parent this repo to home directory."
  exit 1
fi

stowed=("fish" "kitty" "nvim" "starship")
not_stowed=("stow")
prerequisites_installed=true

# check if all items in stowed are installed
for item in ${stowed[*]}
do
  if ! command -v $item >/dev/null 2>&1; then
    echo "error: $item is not installed"
    prerequisites_installed=false
  fi
done

# check if all items in not_stowed are installed
for item in ${not_stowed[*]}
do
  if ! command -v $item >/dev/null 2>&1; then
    echo "error: $item is not installed"
    prerequisites_installed=false
  fi
done

# go figure
if ! $prerequisites_installed; then
  exit 1
fi

echo "stowing items..."
echo "---"
for item in ${stowed[*]}
do
  stow "$item"
  echo "$item stowed"
done

echo "---"
echo "Program done!"
# probably don't need the below line, but just in case.
exit 0
