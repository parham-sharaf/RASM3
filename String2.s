//File: String2.s
//Author: Parham Sharafoleslami

    .global String_startsWith_1                 //Provide program starting address to linker
    .global String_startsWith_2                 //Provide program starting address to linker
    .global String_indexOf_1                    //Provide program starting address to linker
    .global String_indexOf_2                    //Provide program starting address to linker
    .global String_indexOf_3                    //Provide program starting address to linker
    .global String_lastIndexOf_1                //Provide program starting address to linker
    .global String_lastIndexOf_2                //Provide program starting address to linker
    .global String_lastIndexOf_3                //Provide program starting address to linker

    .text



//*******************************************************************************
//* FUNCTION String_startsWith_1
//* -----------------------------------------------------------------------------
//* Returns 1 if the string starts wtih the given substring. Otherwise returns
//*     0, indicating the string does not start at the specified index
//*     with the substring
//*
//* 	 	==> returns: signed integer
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the string index
//*         X2: holds the address to the substring
//*
//* 	POST-CONDITIONS
//*         X0: returns 0 (false) if substring is not found
//*         X0, X1, X2, X3, X4
//*******************************************************************************

String_startsWith_1:
    ADD     X0, X0, X1              // Creates an offset for the string pointer

    LDRB    W3, [X0], #1            // Gets the first character of str
    LDRB    W4, [X2], #1            // Gets the second character of substring

loop_ssw1:
    CBZ     W4, found_ssw1          // Checks if it has not reached the end of substring

    // If not found
    CMP     W3, W4                  // Checks if it has not reached the end of substring
    BNE     notFound_ssw1           // Branches to notFound if the ch does not match

    // Else
    LDRB    W3, [X0], #1            // Loads the next character of in str into W3
    LDRB    W4, [X2], #1            // Loads the next character int the substring in W4

    // Loops again
    B       loop_ssw1               // Loop again

notFound_ssw1:
    // Return not found
    MOV     X0, #0x0                // X0 = 0
    RET                             // Return

found_ssw1:
    // Return found
    MOV     X0, #0x1                // X0 = 1
    RET                             // Return


//*******************************************************************************
//* FUNCTION String_startsWith_2
//* -----------------------------------------------------------------------------
//* Returns 1 if the string starts wtih the given substring. Otherwise returns
//*     0, indicating the string does not start with the substring
//*
//* 	 	==> returns: signed integer
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the address to the substring
//*
//* 	POST-CONDITIONS
//*         X0: returns 0 (false) if substring is not found
//*         X0, X1, X2, X3
//*******************************************************************************

String_startsWith_2:
    LDRB    W2, [X0], #1        // Gets the first character of str
    LDRB    W3, [X1], #1        // Gets the second character of substring

loop_ssw2:
    CBZ     W3, found_ssw2      // Checks if it has not reached the end of substring

    // if not found
    CMP     W2, W3              // Compares the ch in str and substring at the given index
    BNE     notFound_ssw2       // Branches to notFound if the ch does not match

    // Else
    LDRB    W2, [X0], #1        // Loads the next character of in str into W2
    LDRB    W3, [X1], #1        // Loads the next character int the substring in W3

    // Loops again
    B       loop_ssw2           // Branches back to loop_ssw2

notFound_ssw2:
    // Return false
    MOV     X0, #0x0            // returns 0 for false
    RET                         // Return

found_ssw2:
    // Return true
    MOV     X0, #0x1            // Returns 1 for found
    RET                         // Return



//*******************************************************************************
//* FUNCTION String_indexOf_1
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
loop_sio1:
    // Check if the pointer is
    // at the end of str
    CBZ     W3, notFound_sio1               // If W3 == null, branch to notFound_sio1

    // If str[n] == W1
    CMP     W1, W3                          // Compares the W3 to W1
    BEQ     found_sio1                      // If the same, branch to found_sio1

    // Else
    LDRB    W3, [X0], #1                    // Get the next character and store it in W3
    Add     W2, W2, #0x1                    // Else, increment the index
    B       loop_sio1                       // Branch to loop_sio1

found_sio1:
    // Return
    MOV     W0, W2                          // W0 = W2
    RET                                     // Return

notFound_sio1:
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
loop_sio2:
    // Check if the pointer is
    // at the end of str
    CBZ     W4, notFound_sio2       // If W4 == null, branch to notFound_sio2

    // If str[n] == W1
    CMP     W1, W4                  // Compares the W4 to W1
    BEQ     found_sio2              // If the same, branch to found_sio2

    // Else
    LDRB    W4, [X0], #1            // Get the next character and store it in W4
    Add     W3, W3, #0x1            // Else, increment the index
    B       loop_sio2               // Branch to loop_sio2

found_sio2:
    // Return found
    MOV     W0, W3                  // W0 = W3
    RET                             // Return

notFound_sio2:
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
    BL      String_length               // Branches to String_length to get the length of str
    MOV     X21, X0                     // Stores the length into X21

    // Length of substring
    MOV     X0, X20                     // Moves the address of the substring into X0
    BL      String_length               // Branches to String_length to get the length of the substring
    MOV     X22, X0                     // Moves the length into X22

    // Checks if the substring is
    // longer than str
    CMP     X22, X21                    // Compares the length of str to the length of substring
    BGT     notFound_sio3               // Jumps to notFound_sio3 if it is greater

    // Last index to be checked
    SUB     X23, X21, X22               // Subtracts the length of substring from the lenght of str
    ADD     X23, X23, #1                // Increments X23
    MOV     X4, #0x0                    // Initializes the index counter
loop_sio3:
    // Gets the charaters
    LDRB    W2, [X19], #1               // Obtains the character in str X19 is pointing to
    LDRB    W3, [X20]                   // Obtains the character in the substring X20 is pointing to

    // If str[n] == substring[n]
    CMP     W2, W3                      // Compares the characters
    BEQ     cont_sio3                   // If the same, jumps to cont

noMatch_sio3:
    // Increment the index
    ADD     X4, X4, #1                  // Adds 1 to the index

    // If str[str.length() -
    //  substring.lenght()] == substring[0]
    CMP     X4, X23                     // Compares if the index check has reached the last index
    BEQ     notFound_sio3               // If yes, branches to notFound_sio3

    B       loop_sio3                   // Otherwise, loop again

cont_sio3:
    // Stores str current index pointer
    MOV     X5, X19                     // X5 = X19

    // Increment substring index pointer
    ADD     X6, X20, #1                 // X6 = X20 + 1

checkWord_sio3:

    // Gets the charaters
    LDRB    W2, [X5], #1                // Obtains the character in str X5 is pointing to
    LDRB    W3, [X6], #1                // Obtains the character in the substring X6 is pointing to

    // If str[n] == substring[n]
    CMP     W2, W3                      // Compares the characters
    BEQ     checkWord_sio3              // Continues with the loop

    // If the end of substring is reached
    CBZ     W3, found_sio3              // If W3 == 0, branch to found
    B       noMatch_sio3                // else, branch to noMathc

found_sio3:
    // Return found
    MOV     W0, W4                      // W0 = W4, the index found
    B       exit_sio3                   // Branch to exit

notFound_sio3:
    // Return no found
    MOV     X0, #-1                     // X0 = -1
    B       exit_sio3                   // Branch to exit

exit_sio3:
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
    BL      String_length                   // Branches to String_length

    // Sets the index
    SUB     W0, W0, #1                      // W2 = W0 - 1
    ADD     X19, X19, X0                    // Increases the pointer by str length


    LDRB    W2, [X19], # -1                 // Gets character

loop_slio1:
    // Checks for end of str
    CMP     W0, #-1                         // Compares W0 to -1
    BEQ     notFound_slio1                  // Branches if X0 == -1

    // Checks for character
    CMP     W20, W2                         // Checks if character is found
    BEQ     exit_slio1                      // Exits if character is found

    // Decrements the index
    SUB     W0, W0, #0x1                    // W0 = W0 - 1
    LDRB    W2, [X19], #-1                  // Gets the next character in str
    B       loop_slio1                      // Loops again

notFound_slio1:
    MOV     X0, #-1

exit_slio1:
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

loop_slio2:
    CMP     W3, #-1                     // Checks if it has reached the end of str
    BEQ     notFound_slio2              // If so, branch to notFound

    CMP     W1, W4                      // Compare the character in str to ch
    BEQ     found_slio2                 // If the same, branch to found

    SUB     W3, W3, #0x1                // Decrement the index
    LDRB    W4, [X0], #-1               // Loads the character into W4
    B       loop_slio2                  // Loop again

found_slio2:
    // Return found
    MOV     X0, X3                      // X0 = X3
    RET                                 // Return

notFound_slio2:
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
    BL      String_length               // Branches to String_length to get the length of str
    MOV     X21, X0                     // Stores the length into X21

    ADD     X19, X19, X21               // Increases str pointer by the size of str
    SUB     X19, X19, #1                // Sets str pointer to the end of str

    // Length of substring
    MOV     X0, X20                     // Moves the address of the substring into X0
    BL      String_length               // Branches to String_length to get the length of the substring
    MOV     X22, X0                     // Moves the length into X22

    ADD     X20, X20, X22               // Increase the pointer by the size of string
    SUB     X20, X20, #1                // Sets substring pointer to the end of substring

    // Checks if the substring is
    // longer than str
    CMP     X22, X21                    // Compares the length of str to the length of substring
    BGE     notFound_slio3              // Jumps to notFound_slio3 if it is greater

    // Last index to be checked
    SUB     X23, X22, #1                // Decrements the size
    MOV     X4, X21                     // Initializes the index counter
    SUB     X4, X4, #1                  // Sets the index to the end of str

loop_slio3:
    // Gets the charaters
    LDRB    W2, [X19], #-1              // Obtains the character in str X19 is pointing to
    LDRB    W3, [X20]                   // Obtains the character in the substring X20 is pointing to

    // If str[n] == substring[n]
    CMP     W2, W3                      // Compares the characters
    BEQ     cont_slio3                  // If the same, jumps to cont

noMatch_slio3:
    // Increment the index
    SUB     X4, X4, #1                  // Adds 1 to the index

    // If str[str.length() -
    //  substring.lenght()] == substring[0]
    CMP     X4, X23                     // Compares if the index check has reached the last index
    BEQ     notFound_slio3              // If yes, branches to notFound

    B       loop_slio3                  // Otherwise, loop again

cont_slio3:
    // Stores str current index pointer
    MOV     X5, X19                     // X5 = X19

    // Increment substring index pointer
    SUB     X6, X20, #1                 // X6 = X20 + 1

    // Initizalizes X22 with the size of substring
    MOV     X22, X0                     // X22 = X0

checkWord_slio3:

    // Gets the charaters
    LDRB    W2, [X5], #-1               // Obtains the character in str X5 is pointing to
    LDRB    W3, [X6], #-1               // Obtains the character in the substring X6 is pointing to

    // Decrements index
    SUB     X22, X22, #1                // Subtracts 1 from X22

    // If str[n] == substring[n]
    CMP     W2, W3                      // Compares the characters
    BEQ     checkWord_slio3             // Continues with the loop

    // If the end of substring is reached
    CMP     X22, #0

    BEQ     found_slio3                 // Branch to found if X22 is 0
    B       noMatch_slio3               // else, branch to noMatch_slio3

found_slio3:
    // Return found
    SUB     W0, W4, W23                 // W0 = W4, the index found
    B       exit_slio3                  // Branch to exit_slio3

notFound_slio3:
    // Return not found
    MOV     X0, #-1                     // X0 = -1
    B       exit_slio3                  // Branch to exit

exit_slio3:
    LDP     X22, X23, [SP], #16         // Pop X22 and X23 from the stack
    LDP     X20, X21, [SP], #16         // Pop X20 and X21 from the stack
    LDP     LR,  X19, [SP], #16         // Pop LR and X19 from the stack
    RET                                 // Return
