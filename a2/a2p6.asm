

print:


;$29 stores initial value of stack
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
mflo $1 ;quotient will be negative
mult $5, $9
mflo $5
add $5, $5, $8
mult $1, $9
mflo $1
sw $5, -4($30)
sub $30, $30, $4
beq $0, $0, loop


;checking for 0
check: bne $1, $0, loop
add $1, $0, $8
sw $1, 0($6)
beq $0, $0, end


loop: beq $1, $0, display
div $1, $7
mfhi $5
add $5, $5, $8
sw $5, -4($30)
sub $30, $30, $4
mflo $5
add $1, $5, $0
beq $0, $0, loop


display: beq $29, $30, end
add $30, $30, $4
lw $5, -4($30)
sw $5, 0($6)
beq $0, $0, display

end: sw $7, 0($6)
jr $31



