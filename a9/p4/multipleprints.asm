;;; prolog
.import print
lis $12
.word print
lis $4
.word 4
lis $8
.word 8
lis $11
.word 1
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
sub $30, $30, $8  ; push stack frame
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
;; body
lw $3, -4($29)
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
lw $3, 0($29)
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
lw $3, 0($29)
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
lw $3, 0($29)
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 2
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
lis $3
.word 2
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
lw $3, 0($29)
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
lis $3
.word 42
sw $1, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $1, $3, $0
jalr $12
add $30, $30, $8
lw $31, -8($30)
lw $1, -4($30)
lw $3, 0($29)
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
