#!/bin/bash

echo scala WLP4Scan '<' $1.wlp4 '>' $1.scanned
scala WLP4Scan < $1.wlp4 > $1.scanned

echo scala WLP4Parse '<' $1.scanned '>' $1.wlp4i
scala WLP4Parse < $1.scanned > $1.wlp4i

echo scala WLP4Gen '<' $1.wlp4i '>' $1.asm
scala WLP4Gen < $1.wlp4i > $1.asm

echo java cs241.linkasm '<' $1.asm '>' $1.merl
java cs241.linkasm < $1.asm > $1.merl

echo xxd -c 4 $1.merl '>' $1.xxd
xxd -c 4 $1.merl > $1.xxd 

echo python linker.py print.xxd alloc.xxd proc.merl
python linker.py print.xxd alloc.xxd proc.merl

echo scala binasm '<' proc.merl '>' proc.asm
scala binasm < proc.merl > proc.asm

echo xxd -c 4 proc.asm '>' proc.xxd
xxd -c 4 proc.asm > proc.xxd

echo python linker.py $1.xxd proc.xxd $1.linked
python linker.py $1.xxd proc.xxd $1.linked

echo scala binasm '<' $1.linked '>' $1.merl2
scala binasm < $1.linked > $1.merl2

#xxd -c 4 $1.xxd > $1.xxd


echo java cs241.merl 0 '<' $1.merl2 '>' $1.mips
java cs241.merl 0 < $1.merl2 > $1.mips

./wlp4c < $1.wlp4 > $1.mips


echo java mips.twoints $1.mips
java mips.twoints $1.mips
