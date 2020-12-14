lis $7
.word 64
lis $6
.word 0xffff000c
lis $5
.word 1
lis $4
.word 4


loop: beq $2, $0, end
lw $3, 0($1)
beq $3, $0, space
add $3, $3, $7
beq $0, $0, print
space: lis $3
.word 32
print: sw $3, 0($6)
add $1, $1, $4
sub $2, $2, $5
beq $0, $0, loop


end: jr $31
