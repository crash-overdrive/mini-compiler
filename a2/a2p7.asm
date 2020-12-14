sw $1, -4($30)
sw $2, -8($30)
sw $4, -12($30)
sw $5, -16($30)
lis $4
.word 16
sub $30, $30, $4


lis $5
.word 1
lis $4
.word 4
loop: beq $2, $0, end

;call print with $1 after storing it in stack
sw $1, -4($30)
sw $2, -8($30)
sw $31, -12($30)
lis $2
.word 12
sub $30, $30, $2
lw $1, 0($1)
lis $2
.word print
jalr $2

lis $2
.word 12
add $30, $30, $2
lw $31, -12($30)
lw $2, -8($30)
lw $1, -4($30)

add $1, $1, $4
sub $2, $2, $5
beq $0, $0, loop

end: lis $4
.word 16
add $30, $30, $4
lw $5, -16($30)
lw $4, -12($30)
lw $2, -8($30)
lw $1, -4($30)
jr $31
