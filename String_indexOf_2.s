    .global String_indexOf_2

// PRE-CONDITION
// X0 holds the address to the string
// X1 holds the index
// X2 holds the starting index

// POST-CONDITION
// X0 returns the index of first occurance of the character
// after the specified index

String_indexOf_2:

    ADD     X0, X0, X2

    LDRB    W4, [X0], #1
    MOV     W3, #0x0

loop:
    CBZ     W4, notFound
    CMP     W1, W4
    BEQ     found
    Add     W3, W3, #0x1
    LDRB    W4, [X0], #1
    B       loop

found:
    MOV     W0, W3
    RET

notFound:
    MOV     X0, #-1
    RET
