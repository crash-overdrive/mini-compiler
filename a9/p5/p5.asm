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
.word 16
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
;;;prolog for procedure wain has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 0
;;;code generated for putting NUM in $3!!
sw $3, -8($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -8
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 5
;;;code generated for putting NUM in $3!!
sw $3, -12($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is -12
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8
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
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
