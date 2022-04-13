    .data
name:           .asciz  "Green eggs and ham."
phrase:         .asciz  "eggs"
    .global _start

    .text
// PRE-CONDITION
// X0 holds the address to the string
// X1 holds the address of a phrase

// POST-CONDITION
// X0 returns the index of last occurance of the character

_start:
    LDR     X19, =name
    LDR     X20, =phrase

    STR     LR, [SP, #-16]!
    MOV     X0, X19
    BL      strlength
    LDR     LR, [SP], #16

    SUB     W21, W0, #1

    STR     LR, [SP, #-16]!
    MOV     X0, X20
    BL      strlength
    LDR     LR, [SP], #16

    SUB     W22, W0, #1

    ADD     X19, X19, X21
    ADD     X20, X20, X22

    LDRB    W4, [X19], #-1
    LDRB    W5, [X20], #-1

loop:
    CMP     W22, W21
    BGT     notFound

    CMP     W22, #-1
    BEQ     found
    CMP     W4, W5
    BNE     noMatch
    SUB     W21, W21, #1
    SUB     W22, W22, #1
    LDRB    W4, [X19], #-1
    LDRB    W5, [X20], #-1


noMatch:
    LDRB    W4, [X19], #-1
    LDRB    W5, [X20], #-1
    SUB     W22, W0, #1
    ADD     X20, X20, X22
    B       loop

found:
    MOV     X0, X21
    RET

notFound:
    MOV     X0, #-1
    RET
