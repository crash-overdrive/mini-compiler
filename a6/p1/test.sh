#!/bin/bash

echo wlp4scan '<' $1.txt '>' "$1expected.out"
wlp4scan < $1.txt > "$1expected.out"
echo scala Scanning '<' $1.txt '>' "$1actual.out"
scala Scanning <  $1.txt > "$1actual.out"
if [ $? -eq 0 ]
  then
    echo diff "$1expected.out" "$1actual.out"
    diff "$1expected.out" "$1actual.out"
  fi

