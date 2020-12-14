#!/bin/bash

echo wlp4scan '<' $1.wlp4 '>' $1.scanned
wlp4scan < $1.wlp4 > $1.scanned

echo wlp4parse '<' $1.scanned '>' $1.wlp4i
wlp4parse < $1.scanned > $1.wlp4i

echo scala WLP4Gen '<' $1.wlp4i '>' $1.asm
scala WLP4Gen < $1.wlp4i > $1.asm

echo java cs241.binasm '<' $1.asm '>' $1.mips
java cs241.binasm < $1.asm > $1.mips

echo java mips.twoints $1.mips
java mips.twoints $1.mips
