;;;prolog for entire program has started!!
.import print
.import init
.import new
.import delete
lis $12
.word print
lis $13
.word init
lis $14
.word new
lis $15
.word delete
lis $4
.word 4
lis $8
.word 8
lis $11
.word 1
sw $2, -4($30)
sw $31, -8($30)
sub $30, $30, $8
add $2, $0, $0
jalr $13
add $30, $30, $8
lw $31, -8($30)
lw $2, -4($30)
;;;prolog for entire program has ended!!
Fwain: 
;;; prolog for procedure wain has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 8
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure wain has ended!!
sw $1, 0($29)     ; store a
sw $2, -4($29)    ; store b
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo: 
;;; prolog for procedure foo has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 0
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo has ended!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo1
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo1: 
;;; prolog for procedure foo1 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo1 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 22289
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo2
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo2: 
;;; prolog for procedure foo2 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo2 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 25910
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo3
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo3: 
;;; prolog for procedure foo3 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo3 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 22414
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo4
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo4: 
;;; prolog for procedure foo4 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo4 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 12434
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo5
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo5: 
;;; prolog for procedure foo5 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo5 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 17498
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo6
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo6: 
;;; prolog for procedure foo6 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo6 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 5116
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo7
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo7: 
;;; prolog for procedure foo7 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo7 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 31639
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo8
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo8: 
;;; prolog for procedure foo8 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo8 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 22191
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo9
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo9: 
;;; prolog for procedure foo9 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo9 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 30412
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo10
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo10: 
;;; prolog for procedure foo10 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo10 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 14386
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo11
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo11: 
;;; prolog for procedure foo11 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo11 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 21729
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo12
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo12: 
;;; prolog for procedure foo12 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo12 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 23354
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo13
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo13: 
;;; prolog for procedure foo13 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo13 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 13805
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo14
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo14: 
;;; prolog for procedure foo14 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo14 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 24689
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo15
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo15: 
;;; prolog for procedure foo15 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo15 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 3027
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo16
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo16: 
;;; prolog for procedure foo16 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo16 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 16977
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo17
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo17: 
;;; prolog for procedure foo17 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo17 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 3095
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo18
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo18: 
;;; prolog for procedure foo18 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo18 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 21561
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo19
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo19: 
;;; prolog for procedure foo19 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo19 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 21244
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo20
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo20: 
;;; prolog for procedure foo20 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo20 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 27425
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo21
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo21: 
;;; prolog for procedure foo21 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo21 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 29026
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo22
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo22: 
;;; prolog for procedure foo22 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo22 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 3953
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo23
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo23: 
;;; prolog for procedure foo23 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo23 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 12146
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo24
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo24: 
;;; prolog for procedure foo24 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo24 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 26278
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo25
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo25: 
;;; prolog for procedure foo25 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo25 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 29630
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo26
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo26: 
;;; prolog for procedure foo26 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo26 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 12290
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo27
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo27: 
;;; prolog for procedure foo27 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo27 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 14898
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo28
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo28: 
;;; prolog for procedure foo28 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo28 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 16504
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo29
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo29: 
;;; prolog for procedure foo29 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo29 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 27042
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo30
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo30: 
;;; prolog for procedure foo30 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo30 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 177
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo31
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo31: 
;;; prolog for procedure foo31 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo31 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 23842
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo32
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo32: 
;;; prolog for procedure foo32 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo32 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 17696
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo33
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo33: 
;;; prolog for procedure foo33 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo33 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 25354
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo34
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo34: 
;;; prolog for procedure foo34 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo34 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 6651
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo35
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo35: 
;;; prolog for procedure foo35 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo35 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 5712
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo36
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo36: 
;;; prolog for procedure foo36 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo36 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 24605
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo37
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo37: 
;;; prolog for procedure foo37 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo37 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 13481
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo38
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo38: 
;;; prolog for procedure foo38 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo38 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 10300
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo39
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo39: 
;;; prolog for procedure foo39 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo39 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 15373
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!
;;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!
sw $29, -4($30)
sw $31, -8($30)
sub $30, $30, $8
lis $5
.word Ffoo40
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
add $3, $5, $3 ;; $3 <- expr2 + term
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Ffoo40: 
;;; prolog for procedure foo40 has started!!
sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure foo40 has ended!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 16487
;;;code generated for putting NUM in $3!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;code generation to achieve $3 <- result of term2, in term1 -> term2 * factor begins!!
lw $3, 0($29) ;;load variable whose offset from frame pointer is 0 into $3
;;code generation to achieve $3 <- result of term2, in term1 -> term2 * factor ends!!
;;push the value stored in $3
;;onto the system stack
sw $3, -4($30)
sub $30, $30, $4
;;push value from $3 to stack completed!!
;;code generation to achieve $3 <- result of factor, in term1 -> term2 * factor begins!!
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 2
;;;code generated for putting NUM in $3!!
;;code generation to achieve $3 <- result of factor, in term1 -> term2 * factor ends!!
;;pop the value off of the system
;;stack and store it in register $5
add $30, $30, $4
lw $5, -4($30)
;;pop value from stack and store in $5 completed!!
mult $3, $5 ;;$3
mflo $3     ;;   <- term2 * factor
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
