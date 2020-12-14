;;;prolog for entire program has started!!
.import print
.import init
.import new
.import delete
lis $12
.word print
lis $13
.word init
lis $14
.word new
lis $15
.word delete
lis $4
.word 4
lis $8
.word 8
lis $11
.word 1
sw $31, -4($30)
sub $30, $30, $4
jalr $13
add $30, $30, $4
lw $31, -4($30)
;;;prolog for entire program has ended!!
Fwain: 
;;; prolog for procedure wain has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 12
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure wain has ended!!
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
;;starting to generate code for putting NULL in $3!!
lis $3
.word 0x1
;;;code generation for putting NULL in $3 completed!!
sw $3, -8($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -8
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
sw $3, 0($29) ;;store content of $3 in variable whose offset from frame pointer is 0
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;;pushing value of expr(stored in $3) onto stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- value of factor in lvalue STAR factor!
;;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!
;;Code generation to get $3 <- address of a variable in RAM begins!!
lis $3
.word 0
add $3, $3, $29
;;Code generation to get $3 <- address of a variable in RAM ends!!
;;Code generation for factor2 in factor1 -> STAR factor2 ends!! $3 has been updated with result of factor2
lw $3, 0($3) ;;interpreting what's in $3 as an address and loading contents of address in $3, in $3 itself!!
;;popping value of expr(stored on top of system stack) to $5
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sw $5, 0($3) ;;storing value of expr in memory location MEM[$3]
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
