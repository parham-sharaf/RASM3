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

    LDRB    W4, [X19], #1
    MOV     W3, #0x0
    MOV     W2, #-1

loop:
    CBZ     W4, endOfSearch
    CMP     W20, W4
    BEQ     updateIndex
loopCont:
    Add     W3, W3, #0x1
    LDRB    W4, [X19], #1
    B       loop

updateIndex:
    MOV     W2, W3
    B       loopCont

endOfSearch:
    MOV     X0, X2
    RET
