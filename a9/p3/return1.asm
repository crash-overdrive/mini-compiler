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
lis $3
.word 1
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
