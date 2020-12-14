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
;;; prolog for procedure wain has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 16
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
;;;prolog for procedure wain has ended!!
;;starting to generate code for putting NULL in $3!!
lis $3
.word 0x1
;;;code generation for putting NULL in $3 completed!!
sw $3, -8($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -8
;;starting to generate code for putting NULL in $3!!
lis $3
.word 0x1
;;;code generation for putting NULL in $3 completed!!
sw $3, -12($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -12
;;starting to generate code to get $3 <- size of array requested!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 5
;;;code generated for putting NUM in $3!!
;;finished generating code for getting $3 <- size of array requested!!
add $1, $3, $0  ;;$1 <- size of array requested
;;Code to allocate memory of size $1 begins!!
sw $31, -4($30)
sub $30, $30, $4
jalr $14
add $30, $30, $4
lw $31, -4($30)
;;Code to allocate memory of size $1 ends!!
bne $3, $0, skip1 ;;if $3 == 0 then make $3 <- NULL
;;starting to generate code for putting NULL in $3!!
lis $3
.word 0x1
;;;code generation for putting NULL in $3 completed!!
skip1: 
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 2
;;;code generated for putting NUM in $3!!
;;pushing value of expr(stored in $3) onto stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- value of factor in lvalue STAR factor!
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;;popping value of expr(stored on top of system stack) to $5
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sw $5, 0($3) ;;storing value of expr in memory location MEM[$3]
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 3
;;;code generated for putting NUM in $3!!
;;pushing value of expr(stored in $3) onto stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- value of factor in lvalue STAR factor!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 1
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
mult $3, $4 ;;multiply term by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term*4
;;popping value of expr(stored on top of system stack) to $5
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sw $5, 0($3) ;;storing value of expr in memory location MEM[$3]
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 5
;;;code generated for putting NUM in $3!!
;;pushing value of expr(stored in $3) onto stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- value of factor in lvalue STAR factor!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 2
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
mult $3, $4 ;;multiply expr2 by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2*4 + term
;;popping value of expr(stored on top of system stack) to $5
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sw $5, 0($3) ;;storing value of expr in memory location MEM[$3]
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 7
;;;code generated for putting NUM in $3!!
;;pushing value of expr(stored in $3) onto stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- value of factor in lvalue STAR factor!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 3
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
mult $3, $4 ;;multiply expr2 by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2*4 + term
;;popping value of expr(stored on top of system stack) to $5
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sw $5, 0($3) ;;storing value of expr in memory location MEM[$3]
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 11
;;;code generated for putting NUM in $3!!
;;pushing value of expr(stored in $3) onto stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- value of factor in lvalue STAR factor!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 2
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
mult $3, $4 ;;multiply expr2 by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2*4 + term
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 2
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
mult $3, $4 ;;multiply term by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term*4
;;popping value of expr(stored on top of system stack) to $5
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sw $5, 0($3) ;;storing value of expr in memory location MEM[$3]
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 4
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
mult $3, $4 ;;multiply term by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term*4
sw $3, -12($29) ;;store content of $3 in variable whose offset from frame pointer is -12
;;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;Code generation for factor2 in factor1 -> STAR factor2 ends!! $3 has been updated with result of factor2
lw $3, 0($3) ;;interpreting what's in $3 as an address and loading contents of address in $3, in $3 itself!!
;;code to print content of $3 begins!!
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
;;code to print content of $3 ends!!
;;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 1
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term ends!!
mult $3, $4 ;;multiply term by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sub $3, $5, $3 ;;$3 <- expr2 - term
;;Code generation for factor2 in factor1 -> STAR factor2 ends!! $3 has been updated with result of factor2
lw $3, 0($3) ;;interpreting what's in $3 as an address and loading contents of address in $3, in $3 itself!!
;;code to print content of $3 begins!!
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
;;code to print content of $3 ends!!
;;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 2
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term ends!!
mult $3, $4 ;;multiply term by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sub $3, $5, $3 ;;$3 <- expr2 - term
;;Code generation for factor2 in factor1 -> STAR factor2 ends!! $3 has been updated with result of factor2
lw $3, 0($3) ;;interpreting what's in $3 as an address and loading contents of address in $3, in $3 itself!!
;;code to print content of $3 begins!!
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
;;code to print content of $3 ends!!
;;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 3
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term ends!!
mult $3, $4 ;;multiply term by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sub $3, $5, $3 ;;$3 <- expr2 - term
;;Code generation for factor2 in factor1 -> STAR factor2 ends!! $3 has been updated with result of factor2
lw $3, 0($3) ;;interpreting what's in $3 as an address and loading contents of address in $3, in $3 itself!!
;;code to print content of $3 begins!!
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
;;code to print content of $3 ends!!
;;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 4
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term ends!!
mult $3, $4 ;;multiply term by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sub $3, $5, $3 ;;$3 <- expr2 - term
;;Code generation for factor2 in factor1 -> STAR factor2 ends!! $3 has been updated with result of factor2
lw $3, 0($3) ;;interpreting what's in $3 as an address and loading contents of address in $3, in $3 itself!!
;;code to print content of $3 begins!!
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
;;code to print content of $3 ends!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 0
;;;code generated for putting NUM in $3!!
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
