sltu $4, $1, $2
beq $4, $0, one
two: add $3, $2, $0
beq $0, $0, end
one: add $3, $1, $0
end: jr $31
