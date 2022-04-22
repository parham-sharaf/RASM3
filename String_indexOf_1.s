    .global String_indexOf_1

// PRE-CONDITION
// X0 holds the address to the string
// X1 holds the index

// POST-CONDITION
// X0 returns the index of first occurance of the character

String_indexOf_1:
    MOV     X19, X0
    MOV     X20, X1

    LDRB    W3, [X0], #1
    MOV     W2, #0x0

loop:
    CBZ     W3, notFound
    CMP     W1, W3
    BEQ     Found
    Add     W2, W2, #0x1
    LDRB    W3, [X0], #1
    B       loop

Found:
    MOV     W0, W2
    RET

notFound:
    MOV     X0, #-1
    RET
