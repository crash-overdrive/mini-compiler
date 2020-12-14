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
sub $25, $30, $4
lis $5
.word Fbar
jalr $5
;;returned from callee function, $3 <- return value of called function!!
add $30, $30, $8
lw $31, -8($30)
lw $29, -4($30)
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
Fbar: 
;;; prolog for procedure bar has started!!
add $29, $25, $0  ; point $29 to temp register $25 which contains start of frame!!
add $30, $29, $4  ; set stack pointer to bottom of stack!!
;;code to push stack frame to reserve space for arguments and local variables begins!!
lis $9
.word 4
sub $30, $30, $9
;;code to push stack frame to reserve space for arguments and local variables ends!!
;;;prolog for procedure bar has ended!!
;;starting to generate code for putting NULL in $3!!
lis $3
.word 0x1
;;;code generation for putting NULL in $3 completed!!
sw $3, 0($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is 0
;;;starting to generate code for putting NUM in $3!!
lis $3
.word 10
;;;code generated for putting NUM in $3!!
;; epilog         ; pop
add $30, $29, $4  ; stack
jr $31            ; frame
