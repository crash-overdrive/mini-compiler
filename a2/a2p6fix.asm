lis $8
.word 48 
lis $6
.word 0xffff000c
lis $7
.word 10
lis $4
.word 4


add $29, $30, $0

;checking for negative
slt $5, $1, $0
beq $5, $0, check
lis $5
.word -1
mult $1, $5
mflo $1
lis $5
.word 45
sw $5, 0($6)

;checking for 0
check: bne $1, $0, loop
add $1, $0, $8
sw $1, 0($6)
beq $0, $0, end 


loop: beq $1, $0, print
div $1, $7
mfhi $3
sw $3, -4($30)
sub $30, $30, $4
mflo $3
add $1, $3, $0
beq $0, $0, loop


print: beq $29, $30, end
add $30, $30, $4
lw $3, -4($30)
add $3, $3, $8
sw $3, 0($6)
beq $0, $0, print

end: sw $7, 0($6)
jr $31
