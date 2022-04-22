    .global String_indexOf_1

//*******************************************************************************
//* FUNCTION String_indexOf_2
//* -----------------------------------------------------------------------------
//* Returns the index of first occurrence of the specified
//*  character ch in the string.
//* 	 	==> returns: signed integer
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the character
//*
//* 	POST-CONDITIONS
//*         X0: returns the index of first occurance of the character
//* 		Following registers will be modified
//*         X0, X1, X2, X3, X4
//*******************************************************************************/

String_indexOf_1:

    // Get character in str
    LDRB    W3, [X0], #1                    // Obtains the character X0 is pointing to

loop:
    // Check if the pointer is
    // at the end of str
    CBZ     W3, notFound                    // If W3 == null, branch to notFound

    // If str[n] == W1
    CMP     W1, W3                          // Compares the W3 to W1
    BEQ     Found                           // If the same, branch to found

    // Else
    LDRB    W3, [X0], #1                    // Get the next character and store it in W3
    Add     W2, W2, #0x1                    // Else, increment the index
    B       loop                            // Branch to loop

Found:
    // Return
    MOV     W0, W2                          // W0 = W2
    RET                                     // Return

notFound:
    // Return not found
    MOV     X0, #-1                         // X0 = -1
    RET                                     // Return
