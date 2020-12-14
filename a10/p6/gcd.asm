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
.word 8
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure wain has ended!!
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
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
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
lis $5
.word Fgcd
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Fgcd: 
;;; prolog for procedure gcd has started!!
add $29, $25, $0  ; point $29 to temp register $25 which contains start of frame!!
add $30, $29, $4  ; set stack pointer to bottom of stack!!
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 12
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure gcd has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 0
;;;code generated for putting NUM in $3!!
sw $3, -8($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -8
;; code generation of test condition of if control begins!!
;;code generation to achieve $3 <- result of expr1, in test -> expr1 EQ expr2 begins!!
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;;code generation to achieve $3 <- result of expr1, in test -> expr1 EQ expr2 ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 EQ expr2 begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 0
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 EQ expr2 ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
slt $6, $3, $5 ;set $6 <- 1 if expr2 < expr1
slt $7, $5, $3 ;set $7 <- 1 if expr1 < expr2
add $3, $6, $7 ;set $3 <- $6 + $7, $6 and $7 cannot both be 1
sub $3, $11, $3 ;set $3 <- 1 - $3
;; code generation of test condition of if control ends!!
beq $3, $0, if1 ;if test false do statements of else
;; code generation of statements of if control begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;; code generation of statements of if control ends!!
beq $0, $0, fi1 ; skip executing statements of else
if1: ;label indicating beginning of else statements
;; code generation of statements of else control begins!!
;;call to another function with paramters made!! Save $29, $31 on stack and store stack address on $25!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
sub $25, $30, $4
;;evaluating argument to be pushed on stack!! $3 <- value of expr to be stored on stack!!
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;evaluating argument to be pushed on stack!! $3 <- value of expr to be stored on stack!!
;;code generation to achieve $3 <- result of term2, in term1 -> term2 % factor begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term2, in term1 -> term2 % factor ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of factor, in term1 -> term2 % factor begins!!
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;;code generation to achieve $3 <- result of factor, in term1 -> term2 % factor ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
div $5, $3 ;;$3
mfhi $3    ;;   <- term2 % factor
;;$3 updated, now pushing it on stack
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
lis $5
.word Fgcd
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;; code generation of statements of else control ends!!
fi1: ;label indicating end of else statements
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
