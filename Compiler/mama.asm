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
sw $2, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $2, $0, $0
jalr $13
add $30, $30, $8
lw $31, -8($30)
lw $2, -4($30)
;;;prolog for entire program has ended!!
Fwain: 
;;; prolog for procedure wain has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 20
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure wain has ended!!
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 0
;;;code generated for putting NUM in $3!!
sw $3, -8($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -8
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 0
;;;code generated for putting NUM in $3!!
sw $3, -12($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -12
;;starting to generate code for putting NULL in $3!!
lis $3
.word 0x1
;;;code generation for putting NULL in $3 completed!!
sw $3, -16($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -16
;;call to another function with paramters made!! Save $29, $31 on stack and store stack address on $25!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
sub $25, $30, $4
;;evaluating argument to be pushed on stack!! $3 <- value of expr to be stored on stack!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;evaluating argument to be pushed on stack!! $3 <- value of expr to be stored on stack!!
lw $3, -16($29) ;;load variable whose offset from frame pointer is -16 into $3
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
lis $5
.word Fgetprod
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;;starting to generate code to get $3 <- size of array requested!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 10
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
sw $3, -16($29) ;;store content of $3 in variable whose offset from frame pointer is -16
while1: ;;start of while label!!
;; code generation of test condition of while loop begins!!
;;code generation to achieve $3 <- result of expr1, in test -> expr1 LT expr2 begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;code generation to achieve $3 <- result of expr1, in test -> expr1 LT expr2 ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 LT expr2 begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 10
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 LT expr2 ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
slt $3, $5, $3 ;;set $3 <- 1 if expr1 < expr2
;; code generation of test condition of while loop ends!!
beq $3, $0, wend1 ;;if test false then exit while loop!!
;; code generation of statements of while loop begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;pushing value of expr(stored in $3) onto stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- value of factor in lvalue STAR factor!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
lw $3, -16($29) ;;load variable whose offset from frame pointer is -16 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
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
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
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
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
sw $3, -12($29) ;;store content of $3 in variable whose offset from frame pointer is -12
;; code generation of statements of while loop ends!!
beq $0, $0, while1 ;;retest while condition!!
wend1: ;;end of while loop!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 0
;;;code generated for putting NUM in $3!!
sw $3, -12($29) ;;store content of $3 in variable whose offset from frame pointer is -12
while2: ;;start of while label!!
;; code generation of test condition of while loop begins!!
;;code generation to achieve $3 <- result of expr1, in test -> expr1 LT expr2 begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;code generation to achieve $3 <- result of expr1, in test -> expr1 LT expr2 ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 LT expr2 begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 10
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 LT expr2 ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
slt $3, $5, $3 ;;set $3 <- 1 if expr1 < expr2
;; code generation of test condition of while loop ends!!
beq $3, $0, wend2 ;;if test false then exit while loop!!
;; code generation of statements of while loop begins!!
;;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
lw $3, -16($29) ;;load variable whose offset from frame pointer is -16 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
mult $3, $4 ;;multiply term by 4
mflo $3     ;;i.e. the size of one word
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term*4
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
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
lw $3, -12($29) ;;load variable whose offset from frame pointer is -12 into $3
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
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
sw $3, -12($29) ;;store content of $3 in variable whose offset from frame pointer is -12
;; code generation of statements of while loop ends!!
beq $0, $0, while2 ;;retest while condition!!
wend2: ;;end of while loop!!
;;call to another function with paramters made!! Save $29, $31 on stack and store stack address on $25!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
sub $25, $30, $4
;;evaluating argument to be pushed on stack!! $3 <- value of expr to be stored on stack!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;evaluating argument to be pushed on stack!! $3 <- value of expr to be stored on stack!!
lw $3, -16($29) ;;load variable whose offset from frame pointer is -16 into $3
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
lis $5
.word Fgetprod
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
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
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Fgetprod: 
;;; prolog for procedure getprod has started!!
add $29, $25, $0  ; point $29 to temp register $25 which contains start of frame!!
add $30, $29, $4  ; set stack pointer to bottom of stack!!
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 12
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure getprod has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 0
;;;code generated for putting NUM in $3!!
sw $3, -8($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -8
;; code generation of test condition of if control begins!!
;;code generation to achieve $3 <- result of expr1, in test -> expr1 LE expr2 begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of expr1, in test -> expr1 LE expr2 ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 LE expr2 begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 1
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 LE expr2 ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
slt $3, $3, $5 ;;set $3 <- 1, if expr1 > expr2
sub $3, $11, $3 ;; $3 <- not($3)
;; code generation of test condition of if control ends!!
beq $3, $0, if1 ;if test false do statements of else
;; code generation of statements of if control begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 1
;;;code generated for putting NUM in $3!!
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;; code generation of statements of if control ends!!
beq $0, $0, fi1 ; skip executing statements of else
if1: ;label indicating beginning of else statements
;; code generation of statements of else control begins!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
;;call to another function with paramters made!! Save $29, $31 on stack and store stack address on $25!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
sub $25, $30, $4
;;evaluating argument to be pushed on stack!! $3 <- value of expr to be stored on stack!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
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
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
sub $3, $5, $3 ;;$3 <- expr2 - term
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;evaluating argument to be pushed on stack!! $3 <- value of expr to be stored on stack!!
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
lis $5
.word Fgetprod
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;; code generation of statements of else control ends!!
fi1: ;label indicating end of else statements
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
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
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
