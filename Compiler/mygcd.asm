; $1 , $2 has numbers passed into it, $3 will contain the result
begin: beq $2, $0, end ;if $2 == 0 then goto end
add $4, $1, $0 		   ; else $4 <- $1
add $1, $2, $0 		   ; $1 <- $2
div $4, $2 			   ; $4 / $2
mfhi $2 			   ; $2 = $4/$2

beq $0, $0, begin	   ; goto begin


end: add $3, $1, $0
jr $31
