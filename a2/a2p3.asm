;$1 beginning of array
;$2 length of array
;$3 last element of array or -1
;$4 contains 4
;$5 contains 1
lis $5
.word 1
lis $4 
.word 4

beq $2, $0, empty

loop: beq $2, $0, set
add $1, $1, $4
sub $2, $2, $5
beq $0, $0, loop

empty: lis $3
.word -1
beq $0, $0, end

set: lw $3, -4($1)

end: jr $31
