#!/bin/bash

# This scripts creates a changelog file from Git history.
#
# Warning: the changelog overwrites changelog.txt file.
#
# Usage:
# make_changelog.txt

git log --date=short --pretty=format:"-%d %ad %s%n" | \
    grep -v "^$" | \
    sed "s/HEAD -> master, //" | \
    sed "s/, origin\\/master//" | \
    sed "s/ (HEAD -> master)//" | \
    sed "s/ (origin\\/master)//"  |\
    sed "s/- (tag: \\(v\\?[0-9.]*\\))/\\n\\1\\n-/" \
    > changelog.txt
