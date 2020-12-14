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
loopmain: beq $2, $0, endmain

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
beq $0, $0, loopmain

endmain: lis $4
.word 16
add $30, $30, $4
lw $5, -16($30)
lw $4, -12($30)
lw $2, -8($30)
lw $1, -4($30)
jr $31


print: sw $1, -4($30)
sw $2, -8($30)
sw $4, -12($30)
sw $5, -16($30)
sw $6, -20($30)
sw $7, -24($30)
sw $8, -28($30)
sw $9, -32($30)
sw $29, -36($30)
lis $5
.word 36
sub $30, $30, $5

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
lis $5
.word 36
add $30, $30, $5
lw $29, -36($30)
lw $9, -32($30)
lw $8, -28($30)
lw $7, -24($30)
lw $6, -20($30)
lw $5, -16($30)
lw $4, -12($30)
lw $2, -8($30)
lw $1, -4($30)
jr $31



