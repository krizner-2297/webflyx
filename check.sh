#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"

# Run the command and capture output
clear
output=$(git branch)
exit_code=$?

# Verify exit code
if [ $exit_code -ne 0 ]; then
    echo -e "${RED}Fail: Unexpected exit code $exit_code"
    exit 1
fi

included_words=("master")
for word in "${included_words[@]}"; do
    if ! echo "$output" | grep -q "$word"; then
        echo -e "${RED}Fail: Output does not contain '$word'"
        exit 1
    fi
done

# Check if output contains any forbidden words
forbidden_words=("webflyx")
for word in "${forbidden_words[@]}"; do
    if echo "$output" | grep -q "$word"; then
        echo -e "${RED}Fail: Output contains forbidden word '$word'"
        exit 1
    fi
done

echo -e "${GREEN}Success: OUTPUT is correct"
exit 0
