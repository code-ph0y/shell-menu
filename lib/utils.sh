#!/bin/sh

# Convert a string to lowercase
strtolower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

# Replace all occurrences of a substring
str_replace() {
    echo "$1" | sed "s/$2/$3/g"
}

# Turn snake_case into Human Readable
encode_human_readable() {
    string_to_encode=$(str_replace "$1" "_" " ")
    echo "$string_to_encode" | tr '[:upper:]' '[:lower:]' | sed -e 's/^./\U&/g' -e 's/ ./\U&/g'
}