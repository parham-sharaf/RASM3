    .global String_startsWith_1

    .text

// PRE-CONDITION
// X0 holds the address to the string
// X1 holds the index
// X2 holds the address to the phrase

// POST-CONDITION
// X0 holds 1 for the phrase found in the string
// and 0 for the phrase not found in the string

String_startsWith_1:
    MOV X19, X0
    MOV X20, X1
    MOV X21, X2

    ADD     X19, X19, X20

    LDRB    W3, [X19], #1
    LDRB    W4, [X21], #1

Loop:
    CBZ     W4, found
    CMP     W3, W4
    BNE     notFound
    LDRB    W3, [X19], #1
    LDRB    W4, [X21], #1
    B       Loop

notFound:
    MOV     X0, #0x0
    RET

found:
    MOV     X0, #0x1
    RET


