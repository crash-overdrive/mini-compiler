;;; prolog
lis $4
.word 4
sub $29,$30,$4  ; init fp
lis $12         ; push
.word 8         ; stack
sub $30,$30,$12 ; frame
sw$1,0($29)     ; store a
sw$2,-4($29)    ; store b
;; body
lw $3, -4($29)
;; epilog       ; pop
add $30,$29,$4  ; stack
jr$31           ; frame
