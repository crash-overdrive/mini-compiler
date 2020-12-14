#!/bin/bash

echo wlp4scan '<' $1.wlp4 '>' $1.scanned
wlp4scan < $1.wlp4 > $1.scanned

echo wlp4parse '<' $1.scanned '>' $1.wlp4i
wlp4parse < $1.scanned > $1.wlp4i

echo scala WLP4Gen '<' $1.wlp4i '>' $1.asm
scala WLP4Gen < $1.wlp4i > $1.asm

echo java cs241.linkasm '<' $1.asm '>' output.merl
java cs241.linkasm < $1.asm > output.merl

echo linker output.merl print.merl alloc.merl '|' java cs241.merl 0 '>' final.mips
linker output.merl print.merl alloc.merl | java cs241.merl 0 > final.mips

echo java mips.twoints final.mips
java mips.twoints final.mips
