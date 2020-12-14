;;;prolog for entire program has started!!
.import print
lis $12
.word print
lis $4
.word 4
lis $8
.word 8
lis $11
.word 1
;;;prolog for entire program has ended!!
;;; prolog for procedure wain has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 12
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
;;;prolog for procedure wain has ended!!
;;starting to generate code for putting NULL in $3!!
lis $3
.word 0x1
;;;code generated for putting NULL in $3!!
sw $3, -8($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -8
;;Code generation to get $3 <- address of a variable in RAM begins!!
lis $3
.word -4
add $3, $3, $29
;;Code generation to get $3 <- address of a variable in RAM ends!!
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;;Code generation for factor2 in factor1 -> STAR factor2 ends!! $3 has been updated with result of factor2
lw $3, 0($3) ;;interpreting what's in $3 as an address and loading contents of address in $3, in $3 itself!!
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
