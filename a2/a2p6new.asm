;$10 stores copy of $1
lis $9 ;stores -1
.word -1
lis $8 ;number to ASCII conversion factor
.word 48
lis $7 ;newline and division by 10
.word 10
lis $6 ;stdin
.word 0xffff000c
;$5 is a temp variable used in slt 
lis $4 ;for updating stack pointer
.word 4


add $10, $1, $0
add $29, $30, $0


;checking for negative
slt $5, $1, $0
beq $5, $0, check

;printing - to the stdout
lis $5
.word 45
sw $5, 0($6)

div $1, $7
mfhi $5 ; remainder will be positive
mult $5, $9
mflo $5
add $5, $5, $8
mflo $1 ; quotient will be negative
;mult $1, $9
;mflo $1
;jr $31
beq $0, $0, loop


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

end: sw $5, 0($6)
sw $7, 0($6)
jr $31


