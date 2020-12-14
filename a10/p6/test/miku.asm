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
.word 12
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
;; code generation of test condition of if control begins!!
;;code generation to achieve $3 <- result of expr1, in test -> expr1 GT expr2 begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of expr1, in test -> expr1 GT expr2 ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of expr2, in test -> expr1 GT expr2 begins!!
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
;;code generation to achieve $3 <- result of expr2, in test -> expr1 GT expr2 ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
slt $3, $3, $5 ;;set $3 <- 1 if expr1 > expr2
;; code generation of test condition of if control ends!!
beq $3, $0, if1 ;if test false do statements of else
;; code generation of statements of if control begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;; code generation of statements of if control ends!!
beq $0, $0, fi1 ; skip executing statements of else
if1: ;label indicating beginning of else statements
;; code generation of statements of else control begins!!
lw $3, -4($29) ;;load variable whose offset from frame pointer is -4 into $3
sw $3, -8($29) ;;store content of $3 in variable whose offset from frame pointer is -8
;; code generation of statements of else control ends!!
fi1: ;label indicating end of else statements
lw $3, -8($29) ;;load variable whose offset from frame pointer is -8 into $3
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
