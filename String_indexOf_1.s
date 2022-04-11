    .global String_indexOf_1

    .text

// PRE-CONDITION
// X0 holds the address to the string
// X1 holds the index

// POST-CONDITION
// X0 returns the index of first occurance of the character

String_indexOf_1:
    MOV     X19, X0
    MOV     X20, X1

    LDRB    W4, [X19], #1
    MOV     W3, #0x0

loop:
    CBZ     W4, notFound
    CMP     W20, W4
    BEQ     Found
    Add     W3, W3, #0x1
    LDRB    W4, [X19], #1
    B       loop

Found:
    MOV     W0, W3
    B       exit
    RET

notFound:
    MOV     X0, #-1
    RET
