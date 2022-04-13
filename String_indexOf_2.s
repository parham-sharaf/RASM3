    .global String_indexOf_2

// PRE-CONDITION
// X0 holds the address to the string
// X1 holds the index
// X2 holds the starting index

// POST-CONDITION
// X0 returns the index of first occurance of the character
// after the specified index

String_indexOf_2:

    LDR     X19, =name
    MOV     X20, #0x61
    MOV     X21, #9
//    MOV     X19, X0
//    MOV     X20, X1
//    MOV     X21, X2

    ADD     X19, X19, X21

    LDRB    W4, [X19], #1
    MOV     W3, #0x0

loop:
    CBZ     W4, notFound
    CMP     W20, W4
    BEQ     found
    Add     W3, W3, #0x1
    LDRB    W4, [X19], #1
    B       loop

found:
    MOV     W0, W3
    RET

notFound:
    MOV     X0, #-1
    RET
