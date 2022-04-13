    .global String_lastIndexOf_2

    .text
// PRE-CONDITION
// X0 holds the address to the string
// X1 holds a character
// X2 the starting index

// POST-CONDITION
// X0 returns the index of last occurance of the character

String_lastIndexOf_2:
    LDR     X19, =name
    MOV     X20, 0x47
    MOV     X21, #6

    MOV     X3, X21
    ADD     X19, X19, X21

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
