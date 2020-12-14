lis $5
.word 1
lis $4
.word 4
lw $3, 0($1)
loop: beq $2, $0, end
add $1, $1, $4
sub $2, $2, $5
lw $6, 0($1)
slt $7, $3, $6
beq $7, $0, loop
add $3, $6, $0
beq $0, $0, loop
end: jr $31
