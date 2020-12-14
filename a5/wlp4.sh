#!/bin/bash

echo wlp4c '<' $1.wlp4 '>' $1.mips
wlp4c < $1.wlp4 > $1.mips
if [ $? -eq 0 ]
  then
    echo java mips.twoints $1.mips
    java mips.twoints $1.mips
  fi
