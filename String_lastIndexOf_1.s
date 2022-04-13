    .global _start
name:       .asciz      "Green eggs and ham."

    .text
// PRE-CONDITION
// X0 holds the address to the string
// X1 holds a character

// POST-CONDITION
// X0 returns the index of last occurance of the character

_start:
//    MOV     X19, X0
//    MOV     X20, X1

    LDR     X19, =name
    MOV     X20, 0x67

    STR     LR, [SP, #-16]!

    MOV     X0, X19
    BL      strlength

    LDR     LR, [SP], #16

    SUB     W3, W0, #1

    SUB     X19, X19, X3

    LDRB    W4, [X19], #1


loop:
    CMP     W4, #-1
    BEQ     notFound
    CMP     W20, W4
    BEQ     found
    SUB     W3, W3, #0x1
    LDRB    W4, [X19], #-1
    B       loop

found:
    MOV     X0, X3
    RET

notFound:
    MOV     X0, #-1
    RET
