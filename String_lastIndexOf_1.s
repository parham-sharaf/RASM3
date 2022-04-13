    .global String_lastIndexOf_1

    .text
// PRE-CONDITION
// X0 holds the address to the string
// X1 holds a character

// POST-CONDITION
// X0 returns the index of last occurance of the character

String_lastIndexOf_1:
    MOV     X19, X0
    MOV     X20, X1

    STR     LR, [SP, #-16]!
    MOV     X0, X19
    BL      length
    LDR     LR, [SP], #16

    SUB     W3, W0, #1
    ADD     X19, X19, X3

    LDRB    W4, [X19], #-1

loop:
    CMP     W3, #-1
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
