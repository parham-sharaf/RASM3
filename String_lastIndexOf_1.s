    .global String_lastIndexOf_1

    .text
// PRE-CONDITION
// X0 holds the address to the string
// X1 holds a character

// POST-CONDITION
// X0 returns the index of last occurance of the character

String_lastIndexOf_1:
    STR     LR, [SP, #-16]!

    BL      length
    LDR     LR, [SP], #16

    SUB     W2, W0, #1
    ADD     X0, X0, X3

    LDRB    W3, [X0], #-1

loop:
    CMP     W2, #-1
    BEQ     notFound
    CMP     W1, W3
    BEQ     found
    SUB     W3, W3, #0x1
    LDRB    W4, [X0], #-1
    B       loop

found:
    MOV     X0, X2
    RET

notFound:
    MOV     X0, #-1
    RET
