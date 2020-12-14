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
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
sub $25, $30, $4
lis $5
.word FnoArgs
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
FnoArgs: 
;;; prolog for procedure noArgs has started!!
add $29, $25, $0  ; point $29 to temp register $25 which contains start of frame!!
add $30, $29, $4  ; set stack pointer to bottom of stack!!
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 0
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure noArgs has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 123
;;;code generated for putting NUM in $3!!
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
