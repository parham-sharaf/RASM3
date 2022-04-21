    .global String_lastIndexOf_2

    .text
// PRE-CONDITION
// X0 holds the address to the string
// X1 holds a character
// X2 the starting index

// POST-CONDITION
// X0 returns the index of last occurance of the character

String_lastIndexOf_2:

    MOV     X3, X1
    ADD     X0, X0, X1

    LDRB    W4, [X0], #-1

loop:
    CMP     W3, #-1
    BEQ     notFound
    CMP     W1, W4
    BEQ     found
    SUB     W3, W3, #0x1
    LDRB    W4, [X0], #-1
    B       loop

found:
    MOV     X0, X3
    RET

notFound:
    MOV     X0, #-1
    RET
