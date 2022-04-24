    .global String_length               //Provide program starting address to linker
    .global String_equals               //Provide program starting address to linker
    .global String_equalsIgnoreCase     //Provide program starting address to linker
    .global String_copy                 //Provide program starting address to linker
    .global String_substring_1          //Provide program starting address to linker
    .global String_substring_2          //Provide program starting address to linker
    .global String_charAt               //Provide program starting address to linker
    .global String_endsWith             //Provide program starting address to linker
    .global String_replace              //Provide program starting address to linker
    .global String_toLowerCase          //Provide program starting address to linker
    .global String_toUpperCase          //Provide program starting address to linker
    .global String_concat               //Provide program starting address to linker

    .text

    //String_equalsIgnoreCase
    .equ            str1_equalsIgnoreCase, 0         //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            str2_equalsIgnoreCase, 8         //Label str. Used by the frame pointer. Start of #str is at 0 bytes

    //String_copy
    .equ            str_copy, 0      //Label copyStr. Used by the frame pointer. Start of #copyStr is at 0 bytes
    .equ            len_copy, 8      //Label copyLen. Used by the from pointer. Start of #copyLen is at 8 bytes

    //String_substring_1
    .equ            str_substring_1, 0     //Label subs1Str. Used by the frame pointer. Start of #subs1Str is at 0 bytes
    .equ            index_substring_1, 8   //Label subs1Index. Used by the frame pointer. Start of #subs1Index is at 8 bytes
    .equ            len_substring_1, 16    //Label subs1Len. Used by the frame pointer. Start of #subs1Len is at 16 bytes

    //String_substring_2
    .equ            str_substring_2, 0     //Label Subs2Str. Used by the frame pointer. Start of #subs2Str is at 0 bytes
    .equ            index_substring_2, 8   //Label Subs2Index. Used by the frame pointer. Start of #subs2Index is at 8 bytes
    .equ            len_substring_2, 16    //Label Subs2Len. Used by the frame pointer. Start of #subs2Len is at 16 bytes

    //String_charAt
    .equ            str_charAt, 0      //Label charStr. Used by the frame pointer. Start of #charStr is at 0 bytes
    .equ            index_charAt, 8    //Label charIndex. Used by the frame pointer. Start of #charIndex is at 8 bytes

    //String_endsWith
    .equ            str_endsWith, 0        //Label ewStr. Used by the frame pointer. Start of #ewStr is at 0 bytes
    .equ            phr_endsWith, 8        //Label ewPhr. Used by the frame pointer. Start of #ewPhr is at 8 bytes
    .equ            len_endsWith, 16       //Label ewLen. Used by the frame pointer. Start of #ewLen is at 16 bytes

    //String_replace
    .equ            str_replace, 0      //Label replStr. Used by the frame pointer. Start of #replStr is at 0 bytes
    .equ            char1_replace, 8    //Label replChar1. Used by the frame pointer. Start of #replChar1 is at 8 bytes
    .equ            char2_replace, 16   //Label replChar2. Used by the frame pointer. Start of #replChar2 is at 16 bytes
    .equ            len_replace, 24     //Label replLen. Used by the from pointer. Start of #replLen is at 24 bytes

    //String_toLowerCase
    .equ            str_toLowerCase, 0          //Label lcaseStr. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            len_toLowerCase, 8          //Label len. Used by the from pointer. Start of #len is at 8 bytes

    //String_toUpperCase
    .equ            str_toUpperCase, 0          //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            len_toUpperCase, 8          //Label len. Used by the from pointer. Start of #len is at 8 bytes

    //String_concat
    .equ            str1_concat, 0         //Label str1. Used by the frame pointer. Start of #str1 is at 0 bytes
    .equ            str2_concat, 8         //Label str2. Used by the frame pointer. Start of #str2 is at 8 bytes
    .equ            len_concat, 16         //Label len. Used by the frame pointer. Start of #len is at 16 bytes



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
        cbnz W2, cont_length           //If W2 is a null character, jump to cont

        mov X0, X1              //Moving the counter from X1 to X0 (facilitates printing it out to the terminal)
        ret                     //Return back to main
cont_length:
        add X1, X1, #1          //Increment counter by 1
        b loop_length                  //Unconditional jump to loop



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
        ldrb W2, [X0], #1       //Loading W2 with the next byte from the first string
        ldrb W3, [X1], #1       //Loading W3 with the next byte from the second string

        cbz W2, checkOther_equals      //If W2 is a null character, check to see if we are at the end of the second string

        cmp W2, W3              //Checking to see if the character from the first string and second string match
        b.ne match_equals            //If they do not match, jump to noMatch (NOT setting the boolean to TRUE)

        b String_equals         //Unconditional jump to String_equals

checkOther_equals:
        cbz W3, match_equals            //If W3 is a null character, jump to same
        b noMatch_equals              //Unconditional jump to noMatch

match_equals:
        mov X0, #1              //Setting the boolean to TRUE
        ret                     //Return back to main

noMatch_equals:
        mov X0, #0              //Setting the boolean to FALSE
        ret                     //Return back to main



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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X1, [FP, #str2_equalsIgnoreCase]         //Storing the second string (X1) into the FP at position #str2

        bl String_toLowerCase              //Branching and linking to toLowerCase
        str X0, [FP, #str1_equalsIgnoreCase]         //Storing the first string (X0), now lowercased, into the FP at position #str1

        ldr X0, [FP, #str2_equalsIgnoreCase]         //Loading X0 with the address of the second string
        bl String_toLowerCase              //Branching and linking to toLowerCase
        str X0, [FP, #str2_equalsIgnoreCase]         //Storing the second string (X0), now lowercased, into the FP at position #str2

        ldr X0, [FP, #str1_equalsIgnoreCase]         //Loading X0 with the address of the lowercased first string
        ldr X1, [FP, #str2_equalsIgnoreCase]         //Loading X1 with the address of the lowercased second string
        bl String_equals            //Branching and linking to String_equals

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



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

        str X0, [FP, #str_copy]          //Storing the string (X0) into the FP at position #str
        bl String_length            //Branching and linking to String_length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_copy]          //Storing the length (X0) into the FP at position #len

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str_copy]          //Popping the stack and storing the string into X0

loop_copy:
        ldrb W2, [X1], #1           //Loading W2 with the next byte from the string
        strb W2, [X0], #1           //Storing W2 on the next byte into X0

        cbnz W2, loop_copy           //If W2 does not contains a null character, jump to copyLoop

        ldr X1, [FP, #len_copy]          //Loading the length from the FP to X1
        sub X0, X0, X1              //Moving the character pointer back to the start of the string

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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 32 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str_substring_1]          //Storing the string (X0) into the FP at position #str
        str X1, [FP, #index_substring_1]        //Storing the first index (X1) into the FP at position #index

        sub X0, X2, X1              //Changing the length to be only that of the substring
        str X0, [FP, #len_substring_1]          //Loading the length of the substring (X0) into the FP at position #len

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str_substring_1]          //Popping the stack and storing the string into X1
        ldr X2, [FP, #index_substring_1]        //Popping the stack and storing the first index into X2

        add X1, X1, X2              //Moving the string pointer to the first index
        ldr X2, [FP, #len_substring_1]          //Loading X0 with the substring length

loop_substring_1:
        ldrb W3, [X1], #1           //Loading W4 with the next byte from the string
        strb W3, [X0], #1           //Storing W5 on the next byte into X4

        sub X2, X2, #1              //Decrementing the counter
        cbnz X2, loop_substring_1               //If the counter is not 0, jump to loop

        ldr X1, [FP, #len_substring_1]          //Loading X1 with the substring length
        sub X0, X0, X1              //Moving back the string pointer back to the beginning of the string

        add SP, SP, #32             //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str_substring_2]          //Storing the string (X0) into the FP at position #str
        str X1, [FP, #index_substring_2]        //Storing the string (X1) into the FP at position #index

        bl String_length            //Branching and linking to String_length to determine the length of the function
        ldr X1, [FP, #index_substring_2]        //Loading X1 with the index from the FP
        sub X0, X0, X1              //Calculating the substring length
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_substring_2]          //Storing the substring lenth (X0) into the FP at position #len

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str_substring_2]          //Popping the stack and storing the string into X0
        ldr X2, [FP, #index_substring_2]        //Popping the stack and storing the index into X1

        add X1, X1, X2              //Moving the string pointer to the index

loop_substring_2:
        ldrb W3, [X1], #1           //Loading W5 with the next byte from the string
        strb W3, [X0], #1           //Storing W5 on the next byte into X4

        cbnz W3, loop_substring_2               //If W3 does not contain a null character, jump to loop

        ldr X1, [FP, #len_substring_2]          //Loading X1 with the substring length
        sub X0, X0, X1              //Moving back the string pointer back to the beginning of the string

        add SP, SP, #32             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str_charAt]          //Storing the string (X0) into the FP at position #str
        str X1, [FP, #index_charAt]        //Storing the index (X1) into the FP at position #index
        bl String_length                   //Branching and linking length to determine the length of the string+

        ldr X1, [FP, #index_charAt]        //Loading X1 with the address of the string from the FP

        sub X0, X0, X1              //Subtracting the index from the length of the string
        cmp X0, #0                  //Comparing the difference with 0
        b.lt outOfBounds_charAt            //If the difference comes out to be negative, jump to outOfBounds

        ldr X0, [FP, #str_charAt]          //Loading X0 with the address of the string from the FP

        add X0, X0, X1              //Moving the "pointer" up to the byte right before the byte that needs to be printed

        b charAtCont                      //Unconditional jump to cont

outOfBounds_charAt:
        mov X0, #0                  //Setting X0 to 0

cont_charAt:
        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str_endsWith]          //Storing the string (X0) into the FP at position #str
        str X1, [FP, #phr_endsWith]          //Storing the phrase (X1) into the FP at position #phr

        ldr X0, [FP, #phr_endsWith]          //Loading X0 with the address of the phrase from the FP
        bl String_length            //Branching and linking to String_length
        str X0, [FP, #len_endsWith]          //Storing the length of the phrase (X0) into the FP at position #len

        ldr X0, [FP, #str_endsWith]          //Loading X0 with the address of the string from the FP
        bl String_length            //Branching and linking to String_length
        ldr X1, [FP, #len_endsWith]          //Loading X1 with the length from the FP

        sub X2, X0, X1              //Finding the difference between the two lengths and storing the result in X2
        cmp X2, #0                  //Checking if the difference is negative
        b.lt notEndWith             //If it is, jump to notEndWith

        ldr X0, [FP, #str_endsWith]          //Loading X0 with the addres of the string from the FP
        ldr X1, [FP, #phr_endsWith]          //Loading X1 with the address of the phrase from the FP

        add X0, X0, X2              //Moving the string pointer to where the phrase starts

loop_endsWith:
        ldrb W2, [X0], #1           //Loading W3 with the ASCII value of the next byte from the string
        ldrb W3, [X1], #1           //Loading W3 with the ASCII value of the next byte from the phrase

        cmp W2, W3                  //Checking if W2 and W3 are holding the same character
        b.ne false_endsWith             //If not, jump to notEndWith

        cbz W3, check_endsWith               //Checking to see if we have reached the end of the phrase; if so, check to see if
                                    //the string has also ended

        b loop_endsWith                      //Unconditional jump to loop

check_endsWith:
        cbz W2, true_endsWith            //If W2 is a null character, meaning we are at the end of the string as well, jump
                                    //to endsWith
        b false_endsWith                //Unconditional jump to notEndWith

true_endsWith:
        mov X0, #1                  //Setting the boolean to TRUE
        b endsWithExit                      //Unconditional jump to exit

false_endsWith:
        mov X0, #0                  //Setting the boolean to FALSE

exit_endsWith:
        add SP, SP, #32             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 32 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str_replace]          //Storing the string (X0) into the FP at position #str
        str W1, [FP, #char1_replace]        //Storing the first index (X1) into the FP at position #index1
        str W2, [FP, #char2_replace]        //Storing the second index (X2) into the FP at position #index2

        bl String_length            //Branching and linking to String_length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_replace]          //Storing the length (X0) into the FP at position #len

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str_replace]          //Popping the stack and storing the string into X1
        ldr W2, [FP, #char1_replace]        //Popping the stack and storing the first character into X2
        ldr W3, [FP, #char2_replace]        //Popping the stack and storing the second character into X3

loop_replace:
        ldrb W4, [X1], #1           //Loading W5 with the next byte from the string

        cmp W4, W2                  //Comparing the current character (W4) with the character being replaced (W1)
        b.eq repl_replace                   //If they are equal, jump to repl

        b store_replace                     //Unconditional jump to store

repl_replace:
        strb W3, [X0], #1           //Storing the replacing character (W2) on the next byte into X3
        b checkEnd_replace                  //Unconditional jump to checkEnd

store_replace:
        strb W4, [X0], #1           //Storing W4 on the next byte into X3

checkEnd_replace:
        cbnz W4, loop_replace               //If W4 is not a null character, jump to loop

        ldr X1, [FP, #len_replace]
        sub X0, X0, X1

        add SP, SP, #32             //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str_toLowerCase]          //Storing the string (X0) into the FP at position #str
        bl String_length            //Branching and linking String_length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_toLowerCase]          //Storing the length (X0) into the FP at position #len

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str_toLowerCase]          //Popping the stack and storing the string into X0

loop_toLowerCase:
        ldrb W2, [X1], #1           //Loading W2 with the next byte from the string

        cmp W2, #'Z'                //Checking if W2 is greater than the ASCII value of 'Z'
        b.gt loopEnd_toLowerCase                //If it is, jump to loopEnd

        cmp W2, #'A'                //Checkinf if W2 is less than the ASCII value of 'A'
        b.lt loopEnd_toLowerCase                //If it is, jump to loopEnd

        add W2, W2, #('a' - 'A')    //Adding the difference between the ASCII values of upper and lower case and
                                    //adding it from the ASCII value of W2 to make it the lowercase of that letter

loopEnd_toLowerCase:
        strb W2, [X0], #1           //Storing W2 on the next byte into X1

        cbz W2, cont_toLowerCase                //If W2 is a null character, jump to cont

        b loop_toLowerCase                      //Unconditional jump to loop

cont_toLowerCase:
        ldr X1, [FP, #p20Len]          //Loading the length from the FP to X1
        sub X0, X0, X1              //Moving the character pointer back to the start of the string

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str_toUpperCase]          //Storing the string (X0) into the FP at position #str
        bl String_length           //Branching and linking String_length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_toUpperCase]          //Storing the length (X0) into the FP at position #len

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str_toUpperCase]          //Popping the stack and storing the string into X0

loop_toUpperCase:
        ldrb W2, [X1], #1           //Loading W2 with the next byte from the string

        cmp W2, #'z'                //Checking if W2 is greater than the ASCII value of 'z'
        b.gt loopEnd_toUpperCase               //If it is, jump to loopEnd

        cmp W2, #'a'                //Checkinf if W2 is less than the ASCII value of 'a'
        b.lt loopEnd_toUpperCase                //If it is, jump to loopEnd

        sub W2, W2, #('a' - 'A')    //Subtracting the difference between the ASCII values of upper and lower case and
                                    //subtracting it from the ASCII value of W2 to make it the uppercase of that letter

loopEnd_toUpperCase:
        strb W2, [X0], #1           //Storing W2 on the next byte into X1

        cbz W2, cont_toUpperCase                //If W2 is a null character, jump to cont

        b loop_toUpperCase                      //Unconditional jump to loop

cont_toUpperCase:
        ldr X1, [FP, #len_toUpperCase]          //Loading the length from the FP to X1
        sub X0, X0, X1              //Moving the character pointer back to the start of the string

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main



//*******************************************************************************
//* FUNCTION String_concat
//* -----------------------------------------------------------------------------
//* Sets all the characters of the string to uppercase.
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
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 32 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str1_concat]         //Storing the first string (X0) into the FP at position #str1
        str X1, [FP, #str2_concat]         //Storing the second string (X1) into the FP at position #str2

        bl String_length            //Branching and linking to String_length to determine the length of the function

        str X0, [FP, #len_concat]      //Storing the length of the first string (X0) into the FP at position #length1
        ldr X0, [FP, #str2_concat]         //Popping the stack and storing the second string into X0

        bl String_length            //Branching and linking to String_length

        ldr X1, [FP, #len_concat]      //Popping the stack and storing the length of the first string into X1
        add X0, X0, X1              //Adding X0 and X1 and storing the result in X0
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len_concat]

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str1_concat]         //Popping the stack and storing the string into X0
        ldr X2, [FP, #str2_concat]         //Popping the stack and storing the first character into X1

loop_concat:
        ldrb W3, [X1], #1           //Loading W3 with the next byte from the first string

        cbz W3, nextStr_concat             //If W3 is a null character, jump to nextStr

        strb W3, [X0], #1           //Storing W3 into the ptrString (X2) on the next byte over

        b loop_concat                      //Unconditional jump to loop

nextStr_concat:
        ldrb W3, [X2], #1           //Loading W3 with the next byte from the second string
        strb W3, [X0], #1           //Storing W3 into the ptrString (X2) on the next byte over

        cbz W3, cont_concat                //If W3 is a null character, jump to cont

        b nextStr_concat                   //Unconditional jump to nextStr

cont_concat:
        ldr X1, [FP, #len_concat]
        sub X0, X0, X1

        add SP, SP, #32             //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
