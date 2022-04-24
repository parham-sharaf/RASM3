    .global String_startsWith_1                 //Provide program starting address to linker
    .global String_startsWith_2                 //Provide program starting address to linker
    .global String_indexOf_1                    //Provide program starting address to linker
    .global String_indexOf_2                    //Provide program starting address to linker
    .global String_indexOf_3                    //Provide program starting address to linker
    .global String_lastIndexOf_1                //Provide program starting address to linker
    .global String_lastIndexOf_2                //Provide program starting address to linker
    .global String_lastIndexOf_3                //Provide program starting address to linker

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



// PRE-CONDITION
// X0 holds the address to the string
// X1 holds the address to the phrase

// POST-CONDITION
// X0 holds 1 for the phrase found in the string
// and 0 for the phrase not found in the string

String_startsWith_2:
    MOV X19, X0
    MOV X20, X1

    LDRB    W3, [X19], #1
    LDRB    W4, [X20], #1

Loop:
    CBZ     W4, found
    CMP     W3, W4
    BNE     notFound
    LDRB    W3, [X19], #1
    LDRB    W4, [X20], #1
    B       Loop

notFound:
    MOV     X0, #0x0
    RET

found:
    MOV     X0, #0x1
    RET



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
//*******************************************************************************

String_indexOf_1:

    // Get character in str
    LDRB    W3, [X0], #1                    // Obtains the character X0 is pointing to

    MOV W2, #0x0                            // Initializes the index counter
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
//*******************************************************************************

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
//*******************************************************************************

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



//*******************************************************************************
//* FUNCTION String_lastIndexOf_1
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



//*******************************************************************************
//* FUNCTION String_lastIndexOf_2
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



//*******************************************************************************
//* FUNCTION String_lastIndexOf_3
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

String_lastIndexOf_3:
    STP     LR,  X19, [SP, #-16]!       // Pushes LR and X19 onto the stack
    STP     X20, X21, [SP, #-16]!       // Pushes X20 and X21 onto the stack
    STP     X22, X23, [SP, #-16]!       // Pushes X22 and X23 onto the stack

    // Preserves the addresses
    MOV     X19, X0                     // Moves the address of str into X19
    MOV     X20, X1                     // Moves the address of the substring into X20

    // Length of str
    BL      length                      // Branches to length to get the length of str
    MOV     X21, X0                     // Stores the length into X21

    ADD     X19, X19, X21               // Increases str pointer by the size of str
    SUB     X19, X19, #1                // Sets str pointer to the end of str

    // Length of substring
    MOV     X0, X20                     // Moves the address of the substring into X0
    BL      length                      // Branches to length to get the length of the substring
    MOV     X22, X0                     // Moves the length into X22

    ADD     X20, X20, X22               // Increase the pointer by the size of string
    SUB     X20, X20, #1                // Sets substring pointer to the end of substring

    // Checks if the substring is
    // longer than str
    CMP     X22, X21                    // Compares the length of str to the length of substring
    BGE     notFound                    // Jumps to notFound if it is greater

    // Last index to be checked
    SUB     X23, X22, #1                // Decrements the size
    MOV     X4, X21                     // Initializes the index counter
    SUB     X4, X4, #1                  // Sets the index to the end of str

loop:
    // Gets the charaters
    LDRB    W2, [X19], #-1              // Obtains the character in str X19 is pointing to
    LDRB    W3, [X20]                   // Obtains the character in the substring X20 is pointing to

    // If str[n] == substring[n]
    CMP     W2, W3                      // Compares the characters
    BEQ     cont                        // If the same, jumps to cont

noMatch:
    // Increment the index
    SUB     X4, X4, #1                  // Adds 1 to the index

    // If str[str.length() -
    //  substring.lenght()] == substring[0]
    CMP     X4, X23                     // Compares if the index check has reached the last index
    BEQ     notFound                    // If yes, branches to notFound

    B       loop                        // Otherwise, loop again

cont:
    // Stores str current index pointer
    MOV     X5, X19                     // X5 = X19

    // Increment substring index pointer
    SUB     X6, X20, #1                 // X6 = X20 + 1

    // Initizalizes X22 with the size of substring
    MOV     X22, X0                     // X22 = X0

checkWord:

    // Gets the charaters
    LDRB    W2, [X5], #-1               // Obtains the character in str X5 is pointing to
    LDRB    W3, [X6], #-1               // Obtains the character in the substring X6 is pointing to

    // Decrements index
    SUB     X22, X22, #1                // Subtracts 1 from X22

    // If str[n] == substring[n]
    CMP     W2, W3                      // Compares the characters
    BEQ     checkWord                   // Continues with the loop

    // If the end of substring is reached
    CMP     X22, #0

    BEQ     found                       // Branch to found if X22 is 0
    B       noMatch                     // else, branch to noMatch

found:
    // Return found
    SUB     W0, W4, W23                 // W0 = W4, the index found
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
