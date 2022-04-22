    .global String_indexOf_3

// PRE-CONDITION
// X0 holds the address to the string
// X1 holds the address to phrase

// POST-CONDITION
// X0 returns the index of the phrase in the string

String_indexOf_3:
    STP     LR,  X19, [SP, #-16]!
    STP     X20, X21, [SP, #-16]!
    STP     X22, X23, [SP, #-16]!
//    STR     LR, [SP, #-16]!

    MOV     X19, X0
    MOV     X20, X1

    // Length of the string
    BL      length
    MOV     X21, X0

    // Length of phrase
    MOV     X0, X20
    BL      length
    MOV     X22, X0

    CMP     X22, X21
    BGT     notFound

    SUB     X23, X21, X22
    MOV     X4, #0x0

loop:
    LDRB    W2, [X19], #1
    LDRB    W3, [X20]

    CMP     W2, W3
    BEQ     cont

noMatch:
    ADD     X4, X4, #1

    CMP     X4, X23
    BEQ     notFound

    B       loop

cont:
    MOV     X5, X19
    ADD     X6, X20, #1

checkWord:

    LDRB    W2, [X5], #1
    LDRB    W3, [X6], #1

    CMP     W2, W3
    BEQ     checkWord

    CBZ     W3, found
    B       noMatch

found:
    MOV     W0, W4
    B       exit

notFound:
    MOV     X0, #-1
    B       exit

exit:
    LDP     X22, X23, [SP], #16
    LDP     X20, X21, [SP], #16
    LDP     LR,  X19, [SP], #16
//    LDR     LR, [SP], #16
    RET
