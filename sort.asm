    addi $30, $30, -4       ; Make room for one word on stack.
    sw   $31, 0($30)        ; Store return address on stack.
    jal  main               ; Go to main
    lw   $31, 0($30)        ; Load old return address
    addi $30, $30, 4        ; Pop off stack
    jr   $31                ; Finish

; Subroutine that takes an integer in $4, and prints it out to the screen,
; as a base 10 number. Uses temp registers:
; $8  condition checker
; $9  char to print
; $10 Stores printer address
; $11 Number of chars to print
; $12 Stores current number
; $13 Stores 10
; $14 stores current digit
printInt:
    add  $11, $0, $0        ; Init $11 to 0
    add  $12, $4, $0        ; Init $12 to our number
    addi $13, $0, 10        ; Init $13 to 10
    lis  $10                ; Setup $10 as printer
    .word 0xffff000c
    slt  $8,  $4, $0        ; Check if negative number.
    beq  $8,  $0, pushLoop  ; If positive just start loop
    sub  $12, $0, $4        ; Convert to positive
    addi $9,  $0, 45        ; Load 45, ascii -
    sw   $9,  0($10)        ; Print minus sign
pushLoop:
    divu $12, $13           ; Divide cur num by 10
    mfhi $14                ; Copy remainder into $14
    mflo $12                ; Update curnum to quotient
    addi $11, $11, 1        ; Increment num chars
    addi $30, $30, -4       ; Make space on stack
    sw   $14, 0($30)        ; Store digit on stack.
    bne  $12, $0, pushLoop  ; Keep going if not at 0
popLoop:
    lw   $9, 0($30)         ; Load current digit to print
    addi $9, $9, 48         ; Set to ASCII val for that digit
    sw   $9, 0($10)         ; Print the digit
    addi $30, $30, 4        ; Pop off stack
    addi $11, $11, -1       ; Decrement count of digits
    bne  $11, $0, popLoop   ; Keep going if not done
    jr   $31

; Subroutine that takes a memory address in $4 corresponding to start of an
; array, and a natural number in $5 corresponding to the number of elements
; in the array, and prints the array. Uses temp registers:
; $8  to store beginning of array
; $9  to store address of current element
; $10 to store how many elements have been printed.
; $11 to store the address of printer
; $12 to store comma char
; $13 to store space char
; $14 to store nl char
printArray:
    lis  $11              ; Initialize printer
    .word 0xffff000c
    addi $12, $0,  44     ; Init comma char
    addi $13, $0,  32     ; Init space char
    addi $14, $0,  10     ; Init newline
    add  $8,  $4,  $0     ; Store initial value of array
    add  $9,  $4,  $0     ; Set current element to first
    add  $10, $0,  $0     ; printed at 0 elements so far.
    addi $30, $30, -4     ; Make room on stack
    sw   $31, 0($30)      ; Store return address on stack
pLoop:
    lw   $4,  0($9)       ; Load int to print into arg register.
    addi $30, $30, -28    ; Make space on stack for temporary vals
    sw   $8,  0($30)      ; Store temporaries!
    sw   $9,  4($30)
    sw   $10, 8($30)
    sw   $11, 12($30)
    sw   $12, 16($30)
    sw   $13, 20($30)
    sw   $14, 24($30)
    jal  printInt         ; Print int
    lw   $8,  0($30)      ; Reload temporaries!
    lw   $9,  4($30)
    lw   $10, 8($30)
    lw   $11, 12($30)
    lw   $12, 16($30)
    lw   $13, 20($30)
    lw   $14, 24($30)
    addi $30, $30, 28     ; Pop off stack
    addi $9,  $9,  4      ; Point to next element in array
    addi $10, $10, 1      ; Increment counter
    beq  $10, $5,  pFin   ; Finish printing.
    sw   $12, 0($11)      ; Print comma
    sw   $13, 0($11)      ; Print space
    beq  $0,  $0,  pLoop  ; Repeat
pFin:
    add  $4,  $8,  $0     ; Set $4 back to array start
    sw   $14, 0($11)      ; Print newline
    lw   $31, 0($30)      ; Get old return address
    addi $30, $30, 4      ; Pop off stack
    jr   $31
    

; Subroutine that takes a memory location in $4 that corresponds to
; the start of an array and a natural number in $5 that corresponds to
; the length of the array. Sorts the array. $4 and $5 must be preserved.
sort:
    ;$4 contains array
    ;$5 contains length of array
    ;$18 contains len-1
    ;$19 for checks in slt
    ;use $20(i), $21(j) as loop counters 
    ;$22 stores 4
    ;use $23 for storing a[i]
    ;use $24 for storing a[j]
    ;use $25 for mflo operations
    addi $22, $0, 4
    subi $18, $5, 1
    add $20, $0, $0
    startouterloop:
        beq $20, $18, endsort
        addi $21, $20, 1

        startinnerloop:            
            beq $21, $5, endinnerloop
            
            mult $20, $22
            mflo $25
            add $25, $25, $4
            lw $23, 0($25)
            
            mult $21, $22
            mflo $25
            add $25, $25, $4
            lw $24, 0($25)
            
            slt $19, $23, $24
            beq $19, $0, continue
            
            ;;swapping values stored at memory locations

            mult $20, $22
            mflo $25
            add $25, $25, $4
            sw $24, 0($25)

            mult $21, $22
            mflo $25
            add $25, $25, $4
            sw $23, 0($25)

            continue: 
                addi $21, $21, 1
                beq $0, $0, startinnerloop


        endinnerloop:
            addi $20, $20, 1
            beq $0, $0, startouterloop
    
    endsort: 
        jr   $31

main:
    addi $30, $30, -4       ; Make room for one word on stack.
    sw   $31, 0($30)        ; Store return address on stack.
    add  $4,  $1, $0        ; Put array start in $4
    add  $5,  $2, $0        ; Put length in $5
    jal  sort               ; Sort Array
    jal  printArray         ; Print array
    lw   $31, 0($30)        ; Load old return address.
    addi $30, $30, 4        ; Pop off stack
    jr   $31
 

