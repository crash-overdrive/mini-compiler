;;; prolog
lis $4
.word 4
lis $11
.word 1
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame)
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
sub $30, $30, $4
sub $30, $30, $4
;; body
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
div $5, $3
mfhi $3
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
