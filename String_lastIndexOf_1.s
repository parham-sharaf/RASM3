    .global String_lastIndexOf_1

//*******************************************************************************
//* FUNCTION String_indexOf_3
//* -----------------------------------------------------------------------------
//* It returns the last occurrence of the character ch in
//*    the string.
//* 	 	==> returns: signed integer
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the character
//*
//* 	POST-CONDITIONS
//*         X0: returns the index of last occurance of the substring
//* 		Following registers will be modified
//*         X0, X1, X2, X3, X4
//*******************************************************************************/

String_lastIndexOf_1:
    STR     LR, [SP, #-16]!                 // Pushes LR onto the stack
    STP     X19, X20, [SP, #-16]!           // Pushes X19 and X20 onto the stack

    // Stores the variables
    MOV     X19, X0                         // X19 = X0
    MOV     X20, X1                         // X20 = X0

    // Gets the length of the string
    BL      length                          // Branches to length

    // Sets the index
    SUB     W0, W0, #1                      // W2 = W0 - 1
    ADD     X19, X19, X0                    // Increases the pointer by str length


    LDRB    W2, [X19], # -1                 // Gets character

loop:
    // Checks for end of str
    CMP     W0, #-1                         // Compares W0 to -1
    BEQ     notFound                        // Branches if X0 == -1

    // Checks for character
    CMP     W20, W2                         // Checks if character is found
    BEQ     exit                            // Exits if character is found

    // Decrements the index
    SUB     W0, W0, #0x1                    // W0 = W0 - 1
    LDRB    W2, [X19], #-1                  // Gets the next character in str
    B       loop                            // Loops again

notFound:
    MOV     X0, #-1

exit:
    LDP     X19, X20, [SP], #16             // Pops X19 and X20 from the stack
    LDR     LR, [SP], #16                   // Pops LR from the stack
    RET
