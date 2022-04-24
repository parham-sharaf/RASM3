    .global String_lastIndexOf_2

//*******************************************************************************
//* FUNCTION String_indexOf_3
//* -----------------------------------------------------------------------------
//* It returns the last occurrence of the character ch in
//*    the string from a given position.
//* 	 	==> returns: signed integer
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the character
//*         X2: holds the string index
//*
//* 	POST-CONDITIONS
//*         X0: returns the index of last occurance of the substring
//* 		Following registers will be modified
//*         X0, X1, X2, X3, X4
//*******************************************************************************/

String_lastIndexOf_2:

    // Sets the pointer to the specified position
    MOV     X3, X2                      // X3 = X2
    ADD     X0, X0, X2                  // X0 = X0 + X2

    // Get character
    LDRB    W4, [X0], #-1               // Loads the character into W4

loop:
    CMP     W3, #-1                     // Checks if it has reached the end of str
    BEQ     notFound                    // If so, branch to notFound

    CMP     W1, W4                      // Compare the character in str to ch
    BEQ     found                       // If the same, branch to found

    SUB     W3, W3, #0x1                // Decrement the index
    LDRB    W4, [X0], #-1               // Loads the character into W4
    B       loop                        // Loop again

found:
    // Return found
    MOV     X0, X3                      // X0 = X3
    RET                                 // Return

notFound:
    // Return not found
    MOV     X0, #-1                     // X0 = -1
    RET                                 // Return
