    .global String_indexOf_3

//*******************************************************************************
//* FUNCTION String_indexOf_3
//* -----------------------------------------------------------------------------
//* This method returns the index of first occurrence of
//* specified substring str.
//* 	 	==> returns: signed integer
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the address of specified substring
//*
//* 	POST-CONDITIONS
//*         X0: returns the index of first occurance of the substring
//* 		Following registers will be modified
//*         X0, X1, X2, X3, X4, X5, X6
//*******************************************************************************/

String_indexOf_3:
    STP     LR,  X19, [SP, #-16]!       // Pushes LR and X19 onto the stack
    STP     X20, X21, [SP, #-16]!       // Pushes X20 and X21 onto the stack
    STP     X22, X23, [SP, #-16]!       // Pushes X22 and X23 onto the stack

    // Preserves the addresses
    MOV     X19, X0                     // Moves the address of str into X19
    MOV     X20, X1                     // Moves the address of the substring into X20

    // Length of str
    BL      length                      // Branches to length to get the length of str
    MOV     X21, X0                     // Stores the length into X21

    // Length of substring
    MOV     X0, X20                     // Moves the address of the substring into X0
    BL      length                      // Branches to length to get the length of the substring
    MOV     X22, X0                     // Moves the length into X22

    // Checks if the substring is
    // longer than str
    CMP     X22, X21                    // Compares the length of str to the length of substring
    BGT     notFound                    // Jumps to notFound if it is greater

    // Last index to be checked
    SUB     X23, X21, X22               // Subtracts the length of substring from the lenght of str
    ADD     X23, X23, #1                // Increments X23
    MOV     X4, #0x0                    // Initializes the index counter
loop:
    // Gets the charaters
    LDRB    W2, [X19], #1               // Obtains the character in str X19 is pointing to
    LDRB    W3, [X20]                   // Obtains the character in the substring X20 is pointing to

    // If str[n] == substring[n]
    CMP     W2, W3                      // Compares the characters
    BEQ     cont                        // If the same, jumps to cont

noMatch:
    // Increment the index
    ADD     X4, X4, #1                  // Adds 1 to the index

    // If str[str.length() -
    //  substring.lenght()] == substring[0]
    CMP     X4, X23                     // Compares if the index check has reached the last index
    BEQ     notFound                    // If yes, branches to notFound

    B       loop                        // Otherwise, loop again

cont:
    // Stores str current index pointer
    MOV     X5, X19                     // X5 = X19

    // Increment substring index pointer
    ADD     X6, X20, #1                 // X6 = X20 + 1

checkWord:

    // Gets the charaters
    LDRB    W2, [X5], #1                // Obtains the character in str X5 is pointing to
    LDRB    W3, [X6], #1                // Obtains the character in the substring X6 is pointing to

    // If str[n] == substring[n]
    CMP     W2, W3                      // Compares the characters
    BEQ     checkWord                   // Continues with the loop

    // If the end of substring is reached
    CBZ     W3, found                   // If W3 == 0, branch to found
    B       noMatch                     // else, branch to noMathc

found:
    // Return found
    MOV     W0, W4                      // W0 = W4, the index found
    B       exit                        // Branch to exit

notFound:
    // Return no found
    MOV     X0, #-1                     // X0 = -1
    B       exit                        // Branch to exit

exit:
    LDP     X22, X23, [SP], #16         // Pop X22 and X23 from the stack
    LDP     X20, X21, [SP], #16         // Pop X20 and X21 from the stack
    LDP     LR,  X19, [SP], #16         // Pop LR and X19 from the stack
    RET                                 // Return
