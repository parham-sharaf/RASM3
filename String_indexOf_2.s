    .global String_indexOf_2

//*******************************************************************************
//* FUNCTION String_indexOf_2
//* -----------------------------------------------------------------------------
//* Returns the index of first occurrence of the specified
//*  character ch in the string from the starting position
//* 	 	==> returns: signed integer
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the character
//*         X2: holds the starting position
//*
//* 	POST-CONDITIONS
//*         X0: returns the index of first occurance of the character
//* 		Following registers will be modified
//*         X0, X1, X2, X3, X4
//*******************************************************************************/

String_indexOf_2:

    // Moves the pointer to to starting position
    ADD     X0, X0, X2              // X0 = X0 + X2

    // Get character in str
    LDRB    W4, [X0], #1            // Obtains the character X0 is pointing to

    MOV     W3, #0x0                // Initializes the index counter
loop:
    // Check if the pointer is
    // at the end of str
    CBZ     W4, notFound            // If W4 == null, branch to notFound

    // If str[n] == W1
    CMP     W1, W4                  // Compares the W4 to W1
    BEQ     found                   // If the same, branch to found

    // Else
    LDRB    W4, [X0], #1            // Get the next character and store it in W4
    Add     W3, W3, #0x1            // Else, increment the index
    B       loop                    // Branch to loop

found:
    // Return found
    MOV     W0, W3                  // W0 = W3
    RET                             // Return

notFound:
    // Return not found
    MOV     X0, #-1                 // X0 = -1
    RET                             // Return
