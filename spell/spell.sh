#!/bin/bash

# SPDX-FileCopyrightText: 2022 Alexander Kromm <mmaulwurff@gmail.com>
#
# SPDX-License-Identifier: MIT

# This script prints misspelled words found in the mod files.
# See files_to_check for what files are searched for words.
#
# This script requires aspell with English dictionary to be installed.
#
# Usage:
# spell.sh

known_words=$(dirname "${BASH_SOURCE[0]}")/known-words.txt

files_to_check=$(find . -name '*.zs'  \
                     -o -name '*.md'  \
                     -o -name '*.txt' \
                     -o -name '*.sh'  \
                     -o -name '*.fp' \
              )

lowercase_words=$(echo "$files_to_check" | while read -r file; do
    grep -h -o -E '\w{4,}' "$file" \
        | sed -e 's/_/ /g'          \
        | sed -e 's/[0-9]/ /g'       \
        | perl -ne 'print lc(join(" ", split(/(?=[A-Z])/)))' \
        | grep -o -E '\w{4,}'

    grep -h -o -E '[A-Z]{4,}' "$file" | tr '[:upper:]' '[:lower:]'
done)

words=$(echo "$lowercase_words" "$UPPERCASE" \
            | sort -u -f \
            | aspell --lang=en_UK --ignore-case --home-dir=. --personal=$known_words list)

while [[ $# -gt 0 ]]
do
    words=$(comm -13 <(sort "$1") <(echo "$words" | sort))
    shift
done

if [ -z "$words" ]
then
    echo "No misspelled words."
else
    echo "Misspelled words:"
    echo "$words"
fi
