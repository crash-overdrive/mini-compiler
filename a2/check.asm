lis $1
.word -15
lis $2
.word 10
div $1, $2
mflo $3
mfhi $4
jr $31
