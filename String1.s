    .global String_length                       //Provide program starting address to linker
    .global String_equals                       //Provide program starting address to linker
    .global String_equalsIgnoreCase             //Provide program starting address to linker
    .global String_copy                         //Provide program starting address to linker
    .global String_substring_1                  //Provide program starting address to linker
    .global String_substring_2                  //Provide program starting address to linker
    .global String_charAt                       //Provide program starting address to linker
    .global String_endsWith                     //Provide program starting address to linker
    .global String_replace                      //Provide program starting address to linker
    .global String_toLowerCase                  //Provide program starting address to linker
    .global String_toUpperCase                  //Provide program starting address to linker
    .global String_concat                       //Provide program starting address to linker

    .text

    //String_equalsIgnoreCase
    .equ            str1_equalsIgnoreCase, 0    //Used by the frame pointer. Start of #str1_equalsIgnoreCase is at 0 bytes
    .equ            str2_equalsIgnoreCase, 8    //Used by the frame pointer. Start of #str2_equalsIgnoreCase is at 8 bytes

    //String_copy
    .equ            str_copy, 0                 //Used by the frame pointer. Start of #str_copy is at 0 bytes
    .equ            len_copy, 8                 //Used by the from pointer. Start of #len_copy is at 8 bytes

    //String_substring_1
    .equ            str_substring_1, 0          //Used by the frame pointer. Start of #str_substring_1 is at 0 bytes
    .equ            index_substring_1, 8        //Used by the frame pointer. Start of #index_substring_1 is at 8 bytes
    .equ            len_substring_1, 16         //Used by the frame pointer. Start of #len_substring_1 is at 16 bytes

    //String_substring_2
    .equ            str_substring_2, 0          //Used by the frame pointer. Start of #str_substring_2 is at 0 bytes
    .equ            index_substring_2, 8        //Used by the frame pointer. Start of #index_substring_2 is at 8 bytes
    .equ            len_substring_2, 16         //Used by the frame pointer. Start of #len_substring_2 is at 16 bytes

    //String_charAt
    .equ            str_charAt, 0               //Used by the frame pointer. Start of #str_charAt is at 0 bytes
    .equ            index_charAt, 8             //Used by the frame pointer. Start of #index_charAt is at 8 bytes

    //String_endsWith
    .equ            str_endsWith, 0             //Used by the frame pointer. Start of #str_endsWith is at 0 bytes
    .equ            phr_endsWith, 8             //Used by the frame pointer. Start of #phr_endsWith is at 8 bytes
    .equ            len_endsWith, 16            //Used by the frame pointer. Start of #len_endsWith is at 16 bytes

    //String_replace
    .equ            str_replace, 0              //Used by the frame pointer. Start of #str_replace is at 0 bytes
    .equ            char1_replace, 8            //Used by the frame pointer. Start of #char1_replace is at 8 bytes
    .equ            char2_replace, 16           //Used by the frame pointer. Start of #char2_replace is at 16 bytes
    .equ            len_replace, 24             //Used by the frame pointer. Start of #len_replace is at 24 bytes

    //String_toLowerCase
    .equ            str_toLowerCase, 0          //Used by the frame pointer. Start of #str_toLowerCase is at 0 bytes
    .equ            len_toLowerCase, 8          //Used by the frame pointer. Start of #len_toLowerCase is at 8 bytes

    //String_toUpperCase
    .equ            str_toUpperCase, 0          //Used by the frame pointer. Start of #str_toUpperCase is at 0 bytes
    .equ            len_toUpperCase, 8          //Used by the frame pointer. Start of #len_toUpperCase is at 8 bytes

    //String_concat
    .equ            str1_concat, 0              //Used by the frame pointer. Start of #str1_concat is at 0 bytes
    .equ            str2_concat, 8              //Used by the frame pointer. Start of #str2_concat is at 8 bytes
    .equ            len_concat, 16              //Used by the frame pointer. Start of #len_concat is at 16 bytes



//*******************************************************************************
//* FUNCTION String_length
//* -----------------------------------------------------------------------------
//* Returns the length of the given string
//* 	 	==> returns: positive integer
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*
//* 	POST-CONDITIONS
//*         X0: holds the length of the given string
//* 		Following registers will be modified
//*         X0, X1, X2
//*******************************************************************************

String_length:
        mov X1, #0              //Resetting the counter (X1) to be 0

loop_length:
        ldrb W2, [X0], #1       //Loading W2 with the next byte from the string
        cbnz W2, cont_length    //If W2 contains a null character, jump to cont_length

        mov X0, X1              //Moving the counter from X1 to X0 (facilitates printing it out to the terminal)
        ret                     //Return back to main
cont_length:
        add X1, X1, #1          //Increment counter
        b loop_length           //Loop again



//*******************************************************************************
//* FUNCTION String_equals
//* -----------------------------------------------------------------------------
//* Compares the two given strings. Returns true if they match and false
//*  otherwise. It is case sensitive.
//* 	 	==> returns: boolean
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the first str
//*         X1: holds the address to the second str
//*
//* 	POST-CONDITIONS
//*         X0: holds the boolean (1 = TRUE, 0 = FALSE)
//* 		Following registers will be modified
//*         X0, X1, X2, X3
//*******************************************************************************

String_equals:
        ldrb W2, [X0], #1               //Loading W2 with the next byte from the first string
        ldrb W3, [X1], #1               //Loading W3 with the next byte from the second string

        cbz W2, checkOther_equals       //If W2 contains a null character, check to see if we are at the end of the second string

        cmp W2, W3                      //Checking to see if the character from the first string and second string match
        b.ne noMatch_equals             //If they do not match, jump to noMatch_equals

        b String_equals                 //Loop again

checkOther_equals:
        cbz W3, match_equals            //If the second string ends as well, jump to match_equals
        b noMatch_equals                //Strings do not match; jump to noMatch_equals

match_equals:
        mov X0, #1                      //Setting the boolean to TRUE
        ret                             //Return back to main

noMatch_equals:
        mov X0, #0                      //Setting the boolean to FALSE
        ret                             //Return back to main



//*******************************************************************************
//* FUNCTION String_equalsIgnoreCase
//* -----------------------------------------------------------------------------
//* Compares the two given strings. Returns true if they match and false
//*  otherwise. It is not case sensitive.
//* 	 	==> returns: boolean
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the first str
//*         X1: holds the address to the second str
//*
//* 	POST-CONDITIONS
//*         X0: holds the boolean (1 = TRUE, 0 = FALSE)
//* 		Following registers will be modified
//*         X0, X1, X2, X3
//*******************************************************************************

String_equalsIgnoreCase:
        stp LR, FP, [SP, #-16]!                     //Loading the LR and FP onto the stack
        sub SP, SP, #16                             //Moving the SP down by 16 bytes
        mov FP, SP                                  //Moving the FP to match the SP

        str X1, [FP, #str2_equalsIgnoreCase]        //Storing the second string (X1) into the FP at position #str2_equalsIgnoreCase

        bl String_toLowerCase                       //Branching and linking to toLowerCase
                                                    //X0 already contains the address to the first string, so the function would set the first
                                                    //string to be lowercased
        str X0, [FP, #str1_equalsIgnoreCase]        //Storing the first string (X0), now lowercased, into the FP at position #str1_equalsIgnoreCase

        ldr X0, [FP, #str2_equalsIgnoreCase]        //Loading X0 with the address of the second string from the FP
        bl String_toLowerCase                       //Branching and linking to toLowerCase
        str X0, [FP, #str2_equalsIgnoreCase]        //Storing the second string (X0), now lowercased, into the FP at position #str2_equalsIgnoreCase

        ldr X0, [FP, #str1_equalsIgnoreCase]        //Loading X0 with the address of the lowercased first string from the FP
        ldr X1, [FP, #str2_equalsIgnoreCase]        //Loading X1 with the address of the lowercased second string from the FP
        bl String_equals                            //Branching and linking to String_equals to see if they match

        add SP, SP, #16                             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16                       //Restoring previous LR and FP from the stack
        ret                                         //Return back to main



//*******************************************************************************
//* FUNCTION String_copy
//* -----------------------------------------------------------------------------
//* Copies the content of the given string and stores it in a separate address
//* 	 	==> returns: string address
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*
//* 	POST-CONDITIONS
//*         X0: holds the address of the copied str
//* 		Following registers will be modified
//*         X0, X1, X2
//*******************************************************************************

String_copy:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str_copy]     //Storing the string (X0) into the FP at position #str_copy
        bl String_length            //Branching and linking to String_length to determine the length of the string
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_copy]     //Storing the length (X0) into the FP at position #len_copy

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str_copy]     //Loading X1 with the address of the string from the FP

loop_copy:
        ldrb W2, [X1], #1           //Loading W2 with the next byte from the string
        strb W2, [X0], #1           //Storing W2 on the next byte into X0

        cbnz W2, loop_copy          //If W2 does not contains a null character, jump to loop_copy

        ldr X1, [FP, #len_copy]     //Loading X1 with the length of the string along with the null character from the FP
        sub X0, X0, X1              //Moving the string "pointer" back to the start of the string

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



//*******************************************************************************
//* FUNCTION String_substring_1
//* -----------------------------------------------------------------------------
//* Creates a string from the given string starting from the first index
//*  (inclusive) to the second index (exclusive)
//* 	 	==> returns: string address
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the first index
//*         X2: holds the second index
//*
//* 	POST-CONDITIONS
//*         X0: holds the address to the substring
//* 		Following registers will be modified
//*         X0, X1, X2, X3
//*******************************************************************************

String_substring_1:
        stp LR, FP, [SP, #-16]!             //Loading the LR and FP onto the stack
        sub SP, SP, #32                     //Moving the SP down by 32 bytes
        mov FP, SP                          //Moving the FP to match the SP

        str X0, [FP, #str_substring_1]      //Storing the string (X0) into the FP at position #str_substring_1
        str X1, [FP, #index_substring_1]    //Storing the first index (X1) into the FP at position #index_substring_1

        sub X0, X2, X1                      //Changing the length to be only that of the substring
        str X0, [FP, #len_substring_1]      //Loading the length of the substring (X0) into the FP at position #len_substring_1

        bl malloc                           //Branching and linking to malloc

        ldr X1, [FP, #str_substring_1]      //Loading X1 with the address of the string from the FP
        ldr X2, [FP, #index_substring_1]    //Loading X2 with the first index from the FP

        add X1, X1, X2                      //Moving the string "pointer" to the first index
        ldr X2, [FP, #len_substring_1]      //Loading X2 with the length of the substring

loop_substring_1:
        ldrb W3, [X1], #1                   //Loading W3 with the next byte from the string
        strb W3, [X0], #1                   //Storing W3 on the next byte into X0

        sub X2, X2, #1                      //Decrementing the counter
        cbnz X2, loop_substring_1           //If the counter is not 0, jump to loop_substring_1

        ldr X1, [FP, #len_substring_1]      //Loading X1 with the length of the substring
        sub X0, X0, X1                      //Moving back the string "pointer" back to the beginning of the string

        add SP, SP, #32                     //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32               //Restoring previous LR and FP from the stack
        ret                                 //Return back to main



//*******************************************************************************
//* FUNCTION String_substring_2
//* -----------------------------------------------------------------------------
//* Creates a string from the given string starting from the index
//*  (exclusive) to the end of the given string
//* 	 	==> returns: string address
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the index
//*
//* 	POST-CONDITIONS
//*         X0: holds the address to the substring
//* 		Following registers will be modified
//*         X0, X1, X2, X3
//*******************************************************************************

String_substring_2:
        stp LR, FP, [SP, #-16]!                 //Loading the LR and FP onto the stack
        sub SP, SP, #32                         //Moving the SP down by 32 bytes
        mov FP, SP                              //Moving the FP to match the SP

        str X0, [FP, #str_substring_2]          //Storing the string (X0) into the FP at position #str_substring_2
        str X1, [FP, #index_substring_2]        //Storing the index (X1) into the FP at position #index_substring_2

        bl String_length                        //Branching and linking to String_length to determine the length of the string
        ldr X1, [FP, #index_substring_2]        //Loading X1 with the index from the FP
        sub X0, X0, X1                          //Calculating the length of the substring
        add X0, X0, #1                          //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_substring_2]          //Storing the length of the substring (X0) into the FP at position #len_substring_2

        bl malloc                               //Branching and linking to malloc

        ldr X1, [FP, #str_substring_2]          //Loading X1 with the address of the string from the FP
        ldr X2, [FP, #index_substring_2]        //Loading X2 with the index from the FP

        add X1, X1, X2                          //Moving the string "pointer" to the index

loop_substring_2:
        ldrb W3, [X1], #1                       //Loading W3 with the next byte from the string
        strb W3, [X0], #1                       //Storing W3 on the next byte into X0

        cbnz W3, loop_substring_2               //If W3 does not contain a null character, jump to loop_substring_2

        ldr X1, [FP, #len_substring_2]          //Loading X1 with the length of the substring
        sub X0, X0, X1                          //Moving back the string "pointer" back to the beginning of the string

        add SP, SP, #32                         //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32                   //Restoring previous LR and FP from the stack
        ret                                     //Return back to main



//*******************************************************************************
//* FUNCTION String_charAt
//* -----------------------------------------------------------------------------
//* Returns a character at the given index (use putch to print out the char
//*  to the terminal)
//* 	 	==> returns: string address
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the index
//*
//* 	POST-CONDITIONS
//*         X0: holds the address to str with the desired char in the next byte
//*              (use putch to print out the char to the terminal)
//* 		Following registers will be modified
//*         X0, X1
//*******************************************************************************

String_charAt:
        stp LR, FP, [SP, #-16]!         //Loading the LR and FP onto the stack
        sub SP, SP, #16                 //Moving the SP down by 16 bytes
        mov FP, SP                      //Moving the FP to match the SP

        str X0, [FP, #str_charAt]       //Storing the string (X0) into the FP at position #str_charAt
        str X1, [FP, #index_charAt]     //Storing the index (X1) into the FP at position #index_charAt
        bl String_length                //Branching and linking String_length to determine the length of the string

        ldr X1, [FP, #index_charAt]     //Loading X1 with the index from the FP
        sub X0, X0, X1                  //Calculating the length of the substring
        cmp X0, #0                      //Checking to see if the length is negative (special case)
        b.lt outOfBounds_charAt         //If it is negative, jump to outOfBounds (negative length is impossible)

        ldr X0, [FP, #str_charAt]       //Loading X0 with the address of the string from the FP
                                        //X1 is holding the index
        add X0, X0, X1                  //Moving the string "pointer" up to the byte right before the byte that contains the character

        b cont_charAt                   //Unconditional jump to cont_charAt

outOfBounds_charAt:
        mov X0, #0                      //Setting X0 to 0

cont_charAt:
        add SP, SP, #16                 //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16           //Restoring previous LR and FP from the stack
        ret                             //Return back to main



//*******************************************************************************
//* FUNCTION String_endsWith
//* -----------------------------------------------------------------------------
//* Determines if the given string ends with the given phrase. Returns true
//*  if it ends with the phrase and false otherwise.
//* 	 	==> returns: boolean
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the address to the phrase
//*
//* 	POST-CONDITIONS
//*         X0: holds the boolean (1 = TRUE, 0 = FALSE)
//* 		Following registers will be modified
//*         X0, X1, X2, X3
//*******************************************************************************

String_endsWith:
        stp LR, FP, [SP, #-16]!             //Loading the LR and FP onto the stack
        sub SP, SP, #32                     //Moving the SP down by 32 bytes
        mov FP, SP                          //Moving the FP to match the SP

        str X0, [FP, #str_endsWith]         //Storing the string (X0) into the FP at position #str_endsWith
        str X1, [FP, #phr_endsWith]         //Storing the phrase (X1) into the FP at position #phr_endsWith

        ldr X0, [FP, #phr_endsWith]         //Loading X0 with the address of the phrase from the FP
        bl String_length                    //Branching and linking to String_length to determine the length of the string
        str X0, [FP, #len_endsWith]         //Storing the length of the phrase (X0) into the FP at position #len

        ldr X0, [FP, #str_endsWith]         //Loading X0 with the address of the string from the FP
        bl String_length                    //Branching and linking to String_length to determine the length of the string
        ldr X1, [FP, #len_endsWith]         //Loading X1 with the length from the FP

        sub X2, X0, X1                      //Finding the difference between the two lengths and storing the result in X2
        cmp X2, #0                          //Checking if the difference is negative; if it is, the string cannot possible end with the phrase
        b.lt false_endsWith                 //If it is, jump to false_endsWith

        ldr X0, [FP, #str_endsWith]         //Loading X0 with the addres of the string from the FP
        ldr X1, [FP, #phr_endsWith]         //Loading X1 with the address of the phrase from the FP

        add X0, X0, X2                      //Moving the string pointer to where the phrase starts
        bl String_equals                    //Branching and linking to String_equals to see if the phrase and the truncated string match
        b exit_endsWith                     //Unconditional jump to exit_endsWith

false_endsWith:
        mov X0, #0                          //Setting X0 to 0

exit_endsWith:
        add SP, SP, #32                     //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32               //Restoring previous LR and FP from the stack
        ret                                 //Return back to main



//*******************************************************************************
//* FUNCTION String_replace
//* -----------------------------------------------------------------------------
//* Determines if the given string ends with the given phrase. Returns true
//*  if it ends with the phrase and false otherwise.
//* 	 	==> returns: boolean
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*         X1: holds the ASCII code of the character that is being replaced
//*         X2: holds the ASCII code of the character that is replacing
//*
//* 	POST-CONDITIONS
//*         X0: holds the str with the replaced characters
//* 		Following registers will be modified
//*         X0, X1, X2, X3, X4
//*******************************************************************************

String_replace:
        stp LR, FP, [SP, #-16]!             //Loading the LR and FP onto the stack
        sub SP, SP, #32                     //Moving the SP down by 32 bytes
        mov FP, SP                          //Moving the FP to match the SP

        str X0, [FP, #str_replace]          //Storing the string (X0) into the FP at position #str_replace
        str W1, [FP, #char1_replace]        //Storing the first character (W1) into the FP at position #char1_replace
        str W2, [FP, #char2_replace]        //Storing the second character (W2) into the FP at position #char2_replace

        bl String_length                    //Branching and linking to String_length to determine the length of the string
        add X0, X0, #1                      //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_replace]          //Storing the length (X0) into the FP at position #len_replace

        bl malloc                           //Branching and linking to malloc

        ldr X1, [FP, #str_replace]          //Loading X1 with the address of the string from the FP
        ldr W2, [FP, #char1_replace]        //Loading W2 with the ASCII code of the character being replaced
        ldr W3, [FP, #char2_replace]        //Loading W3 with the ASCII code of the character replacing

loop_replace:
        ldrb W4, [X1], #1                   //Loading W4 with the next byte from the string

        cmp W4, W2                          //Comparing the current character (W4) with the character being replaced (W2)
        b.eq repl_replace                   //If they are equal, replace the character

        b store_replace                     //Store the character in the new string

repl_replace:
        strb W3, [X0], #1                   //Storing the replacing character (W3) on the next byte into X0
        b checkEnd_replace                  //Continue loop

store_replace:
        strb W4, [X0], #1                   //Storing W4 on the next byte into X0

checkEnd_replace:
        cbnz W4, loop_replace               //If W4 does not contain a null character, loop again

        ldr X1, [FP, #len_replace]          //Loading X1 with the length of the string from the FP
        sub X0, X0, X1                      //Moving back the string "pointer" back to the beginning of the string

        add SP, SP, #32                     //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32               //Restoring previous LR and FP from the stack
        ret                                 //Return back to main



//*******************************************************************************
//* FUNCTION String_toLowerCase
//* -----------------------------------------------------------------------------
//* Sets all the characters of the string to lowercase.
//* 	 	==> returns: string address
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*
//* 	POST-CONDITIONS
//*         X0: holds the str with its characters lowercased
//* 		Following registers will be modified
//*         X0, X1, X2
//*******************************************************************************

String_toLowerCase:
        stp LR, FP, [SP, #-16]!             //Loading the LR and FP onto the stack
        sub SP, SP, #16                     //Moving the SP down by 16 bytes
        mov FP, SP                          //Moving the FP to match the SP

        str X0, [FP, #str_toLowerCase]      //Storing the string (X0) into the FP at position #str_toLowerCase
        bl String_length                    //Branching and linking String_length to determine the length of the string
        add X0, X0, #1                      //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_toLowerCase]      //Storing the length (X0) into the FP at position #len_toLowerCase

        bl malloc                           //Branching and linking to malloc

        ldr X1, [FP, #str_toLowerCase]      //Loading X1 with the address of the string

loop_toLowerCase:
        ldrb W2, [X1], #1                   //Loading W2 with the next byte from the string

        cmp W2, #'Z'                        //Checking if W2 is greater than the ASCII value of 'Z'
        b.gt loopEnd_toLowerCase            //If it is, jump to loopEnd_toLowerCase

        cmp W2, #'A'                        //Checkinf if W2 is less than the ASCII value of 'A'
        b.lt loopEnd_toLowerCase            //If it is, jump to loopEnd_toLowerCase

        add W2, W2, #('a' - 'A')            //Adding the difference between the ASCII values of upper and lower case and
                                            //adding it from the ASCII value of W2 to make it the lowercase of that letter

loopEnd_toLowerCase:
        strb W2, [X0], #1                   //Storing W2 on the next byte into X0
        cbz W2, cont_toLowerCase            //If W2 contains a null character, jump to cont_toLowerCase
        b loop_toLowerCase                  //Loop again

cont_toLowerCase:
        ldr X1, [FP, #len_toLowerCase]      //Loading X1 with the length of the string from the FP
        sub X0, X0, X1                      //Moving the string "pointer" back to the start of the string

        add SP, SP, #16                     //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16               //Restoring previous LR and FP from the stack
        ret                                 //Return back to main



//*******************************************************************************
//* FUNCTION String_toUpperCase
//* -----------------------------------------------------------------------------
//* Sets all the characters of the string to uppercase.
//* 	 	==> returns: string address
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the str
//*
//* 	POST-CONDITIONS
//*         X0: holds the str with its characters uppercased
//* 		Following registers will be modified
//*         X0, X1, X2
//*******************************************************************************

String_toUpperCase:
        stp LR, FP, [SP, #-16]!             //Loading the LR and FP onto the stack
        sub SP, SP, #16                     //Moving the SP down by 16 bytes
        mov FP, SP                          //Moving the FP to match the SP

        str X0, [FP, #str_toUpperCase]      //Storing the string (X0) into the FP at position #str_toUpperCase
        bl String_length                    //Branching and linking String_length to determine the length of the function
        add X0, X0, #1                      //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_toUpperCase]      //Storing the length (X0) into the FP at position #len_toUpperCase

        bl malloc                           //Branching and linking to malloc

        ldr X1, [FP, #str_toUpperCase]      //Loading X1 with the address of the string from the FP

loop_toUpperCase:
        ldrb W2, [X1], #1                   //Loading W2 with the next byte from the string

        cmp W2, #'z'                        //Checking if W2 is greater than the ASCII value of 'z'
        b.gt loopEnd_toUpperCase            //If it is, jump to loopEnd_toUpperCase

        cmp W2, #'a'                        //Checkinf if W2 is less than the ASCII value of 'a'
        b.lt loopEnd_toUpperCase            //If it is, jump to loopEnd_toUpperCase

        sub W2, W2, #('a' - 'A')            //Subtracting the difference between the ASCII values of upper and lower case and
                                            //subtracting it from the ASCII value of W2 to make it the uppercase of that letter

loopEnd_toUpperCase:
        strb W2, [X0], #1                   //Storing W2 on the next byte into X0
        cbz W2, cont_toUpperCase            //If W2 is a null character, jump to cont_toUpperCase
        b loop_toUpperCase                  //Loop again

cont_toUpperCase:
        ldr X1, [FP, #len_toUpperCase]      //Loading X1 with the length of the string from the FP
        sub X0, X0, X1                      //Moving the string "pointer" back to the start of the string

        add SP, SP, #16                     //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16               //Restoring previous LR and FP from the stack
        ret                                 //Return back to main



//*******************************************************************************
//* FUNCTION String_concat
//* -----------------------------------------------------------------------------
//* Combines the two given strings into one concatenated string.
//* 	 	==> returns: string address
//* -----------------------------------------------------------------------------
//* 	PRE-CONDITIONS
//*         X0: holds the address to the first str
//*         X0: holds the address to the second str
//*
//* 	POST-CONDITIONS
//*         X0: holds the concatenated str
//* 		Following registers will be modified
//*         X0, X1, X2, X3
//*******************************************************************************

String_concat:
        stp LR, FP, [SP, #-16]!         //Loading the LR and FP onto the stack
        sub SP, SP, #32                 //Moving the SP down by 32 bytes
        mov FP, SP                      //Moving the FP to match the SP

        str X0, [FP, #str1_concat]      //Storing the first string (X0) into the FP at position #str1_concat
        str X1, [FP, #str2_concat]      //Storing the second string (X1) into the FP at position #str2_concat

        bl String_length                //Branching and linking to String_length to determine the length of the string
        str X0, [FP, #len_concat]       //Storing the length of the first string (X0) into the FP at position #len_concat

        ldr X0, [FP, #str2_concat]      //Popping the stack and storing the second string into X0
        bl String_length                //Branching and linking to String_length to determine the length of the string
        ldr X1, [FP, #len_concat]       //Loading X1 with the length of the first string

        add X0, X0, X1                  //Adding the length of the first and second string together
        add X0, X0, #1                  //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_concat]       //Storing the length of the concatenated string (X0) into the FP at position #len_concat

        bl malloc                       //Branching and linking to malloc

        ldr X1, [FP, #str1_concat]      //Loading X1 with the address of the first string
        ldr X2, [FP, #str2_concat]      //Loading X2 with the address of the second string

loop_concat:
        ldrb W3, [X1], #1               //Loading W3 with the next byte from the first string
        cbz W3, nextStr_concat          //If W3 contains a null character, jump to nextStr_concat
        strb W3, [X0], #1               //Storing W3 on the next byte over into X0
        b loop_concat                   //Loop again

nextStr_concat:
        ldrb W3, [X2], #1               //Loading W3 with the next byte from the second string
        strb W3, [X0], #1               //Storing W3 on the next byte over into X0
        cbz W3, cont_concat             //If W3 contains a null character, jump to cont_concat
        b nextStr_concat                //Loop again

cont_concat:
        ldr X1, [FP, #len_concat]       //Loading X1 with the length of the concatenated string from the FP
        sub X0, X0, X1                  //Moving the string "pointer" back to the start of the string

        add SP, SP, #32                 //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32           //Restoring previous LR and FP from the stack
        ret                             //Return back to main
