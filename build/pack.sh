#!/bin/bash

# This scripts creates a GZDoom mod package.
# To use it, cd to the directory containing mod files, then
#
# pack.sh mod-name

# Prepare package file name, put it in build directory.
filename=build/$1-$(git describe --abbrev=0 --tags).pk3

# Create build directory if it doesn't exist.
mkdir -p build

# Remove the old file, if any, to guarantee that the archive won't contain obsolete files.
rm --force "$filename"

# Put all mod files into the archive.
zip --recurse-patterns "$filename" "*.md" "*.txt" "*.zs" "*.png" "*.ogg" "*.fp" > /dev/null

# Launch GZDoom to check for errors.
# The output is redirected to prevent character spam for some terminals.
gzdoom  "$filename" "$@" > output 2>&1; cat output
