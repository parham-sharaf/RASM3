// Programmer: Seth Tran & Parham Sharafoleslami
// RASM-3
// Purpose: Write string functions and run them with the provided strings
// Date: 2022-04-10

    .data
szPrompt:                   .asciz  "Please enter a string: "
szLength1:                  .asciz  "1)\ts1.length() = "
szLength2:                  .asciz  "\ts2.length() = "
szLength3:                  .asciz  "\ts3.length() = "
szStringEquals1:            .asciz  "2)\tString_equals(s1,s3) = "
szStringEquals2:            .asciz  "3)\tString_equals(s1,s1) = "
szStringEqualsIgnoreCase1:  .asciz  "4)\tString_equalsIgnoreCase(s1,s3) = "
szStringEqualsIgnoreCase2:  .asciz  "5)\tString_equalsIgnoreCase(s1,s2) = "
szCopy1:                    .asciz  "6)\ts4 = String_copy(s1)"
szCopy2:                    .asciz  "\ts1 = "
szCopy3:                    .asciz  "\ts4 = "
szStringSubstring1:         .asciz  "7)\tString_substring_1(s3,4,14) = "
szStringSubstring2:         .asciz  "8)\tString_substring_2(s3,7) = "
szCharAt:                   .asciz  "9)\tString_charAt(s2,4) = "
szStringStartsWith1:        .asciz  "10)\tString_startsWith_1(s1,11,'hat.') = "
szStringStartsWith2:        .asciz  "11)\tString_startsWith_2(s1,'Cat') = "
szStringEndsWith:           .asciz  "12)\tString_endsWith(s1,'in the hat.') = "
szStringIndexOf1:           .asciz  "13)\tString_indexOf_1(s2,'g') = "
szStringIndexOf2:           .asciz  "14)\tString_indexOf_2(s2,'g',9) = "
szStringIndexOf3:           .asciz  "15)\tString_indexOf_3(s2,'eggs') = "
szStringLastIndexOf1:       .asciz  "16)\tString_lastIndexOf_1(s2,'g') = "
szStringLastIndexOf2:       .asciz  "17)\tString_lastIndexOf_2(s2,'g',6) = "
szStringLastIndexOf3:       .asciz  "18)\tString_lastIndexOf_3(s2,'egg') = "
szStringReplace:            .asciz  "19)\tString_replace(s1,'a','o') = "
szStringToLowerCase:        .asciz  "20)\tString_toLowerCase(s1) = "
szStringToUpperCase:        .asciz  "21)\tString_toUpperCase(s1) = "
szStringConcat:             .asciz  "22)\tString_concat(s1, ' ');\n\tString_concat(s1, s2) = "
szTrue:                     .asciz  "TRUE\n"        //Label szTrue. Used for the output
szFalse:                    .asciz  "FALSE\n"       //Label szFalse. Used for the output
szStringStartWith1Phrase:   .asciz  "hat."
szStringStartWith2Phrase:   .asciz  "Cat"
szStringEndsWithPhrase:     .asciz  "in the hat."
szSpace:                    .asciz  " "             //Label szFalse. Used for String_concat function
ptrStr:                     .quad   0               //Label ptrString. Contains .quad of 0. Pointer string
szStr1:                     .asciz  "Cat in the hat."              //Label szStr1. Contains a buffer to store a string
szStr2:                     .asciz  "Green eggs and ham."              //Label szStr2. Contains a buffer to store a string
szStr3:                     .asciz  "cat in the hat."              //Label szStr3. Contains a buffer to store a string
szOut:                      .skip   21              //Label szOut. Contains a buffer to print to the terminal
cLF:                        .byte   10              //Label cLF. Contains .byte of "\n". Used to print line feed to the terminal

    .global _start                      //Provide program starting address to linker

    .text

_start:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //PRINTING LENGTH FUNCTIONS===============================================================
        ldr X0, =szLength1              //Loading X0 with the address of szLength1
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Loading X0 with the address of szStr1
        bl length                       //Branching and linking to length

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        ldr X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        bl int64asc                     //Executing int64asc to convert the int value to ASCII

        ldr X0, =szOut                  //Loading X0 with the address of the buffer
        bl putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        ldr X0, =szLength2              //Loading X0 with the address of szLength2
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr2                 //Loading X0 with the address of szStr2
        bl length                       //Branching and linking to length

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        ldr X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        bl int64asc                     //Executing int64asc to convert the int value to ASCII

        ldr X0, =szOut                  //Loading X0 with the address of the buffer
        bl putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        ldr X0, =szLength3              //Loading X0 with the address of szLength3
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr3                 //Loading X0 with the address of szStr3
        bl length                       //Branching and linking to length

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        ldr X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        bl int64asc                     //Executing int64asc to convert the int value to ASCII

        ldr X0, =szOut                  //Loading X0 with the address of the buffer
        bl putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_EQUALS FUNCTIONS===============================================================
        ldr X0, =szStringEquals1        //Loading X0 with the address of szStringEquals1
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Loading X0 with the address of szStr1
        ldr X1, =szStr3                 //Loading X1 with the address of szStr3
        bl equals                       //Branching and linking to equals

        cbz X0, false1                  //If the flag is false (X0 contains 0), jump to false1

        ldr X0, =szTrue                 //Loading X0 with the address of szTrue
        bl putstring                    //Branching and linking to putstring

        b continueAfterEquals1          //Unconditional jump to continueAfterEquals1

false1:
        ldr X0, =szFalse                //Loading X0 with the address of szFalse
        bl putstring                    //Branching and linking to putstring

continueAfterEquals1:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        ldr X0, =szStringEquals2        //Loading X0 with the address of szStringEquals2
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Loading X0 with the address of szStr1
        ldr X1, =szStr1                 //Loading X1 with the address of szStr1
        bl equals                       //Branching and linking to equals

        cbz X0, false2                  //If the flag is false (X0 contains 0), jump to false2

        ldr X0, =szTrue                 //Loading X0 with the address of szTrue
        bl putstring                    //Branching and linking to putstring

        b continueAfterEquals2          //Unconditional jump to continueAfterEquals2

false2:
        ldr X0, =szFalse                //Loading X0 with the address of szFalse
        bl putstring                    //Branching and linking to putstring

continueAfterEquals2:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_EQUALSIGNORECASE FUNCTIONS===============================================================
        ldr X0, =szStringEqualsIgnoreCase1      //Loading X0 with the address of szStringEqualsIgnoreCase1
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Loading X0 with the address of szStr1
        ldr X1, =szStr3                 //Loading X1 with the address of szStr3
        bl equalsIgnoreCase             //Branching and linking to equalsIgnoreCase

        cbz X0, false3                  //If the flag is false (X0 contains 0), jump to false3

        ldr X0, =szTrue                 //Loading X0 with the address of szTrue
        bl putstring                    //Branching and linking to putstring

        b continueAfterEquals3          //Unconditional jump to continueAfterEquals3

false3:
        ldr X0, =szFalse                //Loading X0 with the address of szFalse
        bl putstring                    //Branching and linking to putstring

continueAfterEquals3:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        ldr X0, =szStringEqualsIgnoreCase2      //Loading X0 with the address of szStringEqualsIgnoreCase2
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Loading X0 with the address of szStr1
        ldr X1, =szStr2                 //Loading X1 with the address of szStr2
        bl equals                       //Branching and linking to equals

        cbz X0, false4                  //If the flag is false (X0 contains 0), jump to false4

        ldr X0, =szTrue                 //Loading X0 with the address of szTrue
        bl putstring                    //Branching and linking to putstring

        b continueAfterEquals4          //Unconditional jump to continueAfterEquals4

false4:
        ldr X0, =szFalse                //Loading X0 with the address of szFalse
        bl putstring                    //Branching and linking to putstring

continueAfterEquals4:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING COPY FUNCTION===============================================================
        ldr X0, =szCopy1                //Loading X0 with the address of szCopy1
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        ldr X0, =szCopy2                //Loading X0 with the address of szCopy2
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        ldr X0, =szCopy3                //Loading x0 with the address of szCopy3
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_SUBSTRING_1 FUNCTION===============================================================
        ldr X0, =szStringSubstring1     //Loading X0 with the address of szstringSubstring1
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr3                 //Loading X0 with the address of szStr3
        mov X1, #4                      //Setting X1 to 4
        mov X2, #14                     //Setting X2 to 14
        bl String_substring_1           //Branching and linking to String_substring_1

        ldr X1, =ptrStr                 //Loading X1 with the address of ptrStr
        str X0, [X1]                    //Storing X0 into ptrStr

        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_SUBSTRING_2 FUNCTION===============================================================
        ldr X0, =szStringSubstring2     //Loading X0 with the address of szStringSubstring2
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr3                 //Loading X0 with the address of szStr3
        mov X1, #7                      //Setting X1 to 7
        bl String_substring_2           //Branching and linking to String_substring_2

        ldr X1, =ptrStr                 //Loading X1 with the address of ptrStr
        str X0, [X1]                    //Storing X0 into ptrStr

        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING CHARAT FUNCTION===============================================================
        ldr X0, =szCharAt               //Loading X0 with the address of szCharAt
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr2                 //Loading X0 with the address of szStr2
        mov X1, #4                      //Setting X1 to 4
        bl charAt                       //Branching and linking to charAt

        ldr X1, =ptrStr                 //Loading X1 with the address of ptrStr
        str X0, [X1]                    //Storing X0 into ptrStr

        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_STARTSWITH_1 FUNCTION===============================================================
        ldr X0, =szStringStartsWith1    //Loading X0 with the address of szStringStartsWith1
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Loading X0 with the address of szStr1
        mov X1, #11                     //Setting X1 with 11
        ldr X2, =szStringStartWith1Phrase       //Loading X2 with the address of szStringStartWith1Phrase
        bl String_startsWith_1          //Branching and linking to String_startsWith_1

        cbz X0, false5                  //If the flag is false (X0 contains 0), jump to false5

        ldr X0, =szTrue                 //Loading X0 with the address of szTrue
        bl putstring                    //Branching and linking to putstring

        b continueAfterEquals5          //Unconditional jump to continueAfterEquals5

false5:
        ldr X0, =szFalse                //Loading X0 with the address of szFalse
        bl putstring                    //Branching and linking to putstring

continueAfterEquals5:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_STARTSWITH_2 FUNCTION===============================================================
        ldr X0, =szStringStartsWith2    //Loading X0 with the address of szStringStartsWith2
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Loading X0 with the address of szstr1
        ldr X1, =szStringStartWith2Phrase       //Loading X1 with the address of szStringStartWith2Phrase
        bl String_startsWith_2          //Branching and linking to String_startsWith_2

        cbz X0, false6                  //If the flag is false (X0 contains 0), jump to false6

        ldr X0, =szTrue                 //Loading X0 with the address of szTrue
        bl putstring                    //Branching and linking to putstring

        b continueAfterEquals6          //Unconditional jump to continueAfterEquals6

false6:
        ldr X0, =szFalse                //Loading X0 with the address of szFalse
        bl putstring                    //Branching and linking to putstring

continueAfterEquals6:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_ENDSWITH FUNCTION===============================================================
        ldr X0, =szStringEndsWith       //Loading X0 with the address of szStringEndsWith
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Loading X0 with the address of szStr1
        ldr X1, =szStringEndsWithPhrase         //Loading X1 with the address of szStringEndsWithPhrase
        bl String_endsWith              //Branching and linking to String_endsWith

        cbz X0, false7                  //If they are not equal, jump to false7

        ldr X0, =szTrue                 //Loading X0 with the address of szTrue
        bl putstring                    //Branching and linking to putstring

        b continueAfterEquals7          //Unconditional jump to continueAfterEquals7

false7:
        ldr X0, =szFalse                //Loading X0 with the address of szFalse
        bl putstring                    //Branching and linking to putstring

continueAfterEquals7:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_1 FUNCTION===============================================================
        ldr X0, =szStringIndexOf1       //Loading X0 with the address of szStringIndexOf1
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_2 FUNCTION===============================================================
        ldr X0, =szStringIndexOf2       //Loading X0 with the address of szStringIndexOf2
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_3 FUNCTION===============================================================
        ldr X0, =szStringIndexOf3       //Loading X0 with the address of szStringIndexOf3
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_1 FUNCTION===============================================================
        ldr X0, =szStringLastIndexOf1   //Loading X0 with the address of szStringLastIndexOf1
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_2 FUNCTION===============================================================
        ldr X0, =szStringLastIndexOf2   //Loading X0 with the address of szStringLastIndexOf2
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_3 FUNCTION===============================================================
        ldr X0, =szStringLastIndexOf3   //Loading X0 with the address of szStringLastIndexOf3
        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_REPLACE FUNCTION===============================================================
        ldr X0, =szStringReplace        //Loading X0 with the address of szStringReplace
        bl putstring                    //Branching and linking to putstring

        ldr X0, =szStr1                 //Lopading X0 with the address of szStr1
        mov X1, #'a'                    //Setting X1 to the ASCII value of 'a'
        mov X2, #'o'                    //Setting X2 to the ASCII value of 'o'
        bl replace                      //Branching and linking to replace

        ldr X1, =ptrStr                 //Loading X1 with the address of ptrStr
        str X0, [X1]                    //Storing X0 into ptrStr

        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_TOLOWERCASE FUNCTION===============================================================
        ldr X0, =szStringToLowerCase    //Loading X0 with the address of szStringToLowerCase
        bl putstring                    //Branching and linking to putstring

        ldr X0, =ptrStr                 //Loading X0 with the address of ptrStr
        ldr X0, [X0]                    //Dereferencing ptrStr and loading the string address in X0
        bl toLowerCase                  //Branching and linking to toLowerCase

        ldr X1, =ptrStr                 //Loading X1 with the address of ptrStr
        str X0, [X1]                    //Storing X0 into ptrStr

        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_TOUPPERCASE FUNCTION===============================================================
        ldr X0, =szStringToUpperCase    //Loading X0 with the address of szStringToUpperCase
        bl putstring                    //Branching and linking to putstring

        ldr X0, =ptrStr                 //Loading X0 with the address of ptrStr
        ldr X0, [X0]                    //Dereferencing ptrStr and loading the string address in X0
        bl toUpperCase                  //Branching and linking to toUpperCase

        ldr X1, =ptrStr                 //Loading X1 with the address of ptrStr
        str X0, [X1]                    //Storing X0 into ptrStr

        bl putstring                    //Branching and linking to putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_CONCAT FUNCTION===============================================================
        ldr X0, =szStringConcat         //Loading X0 with the address of szStringConcat
        bl putstring                    //Branching and linking to putstring

        ldr X0, =ptrStr                 //Loading X0 with the address of ptrStr
        ldr X0, [X0]                    //Dereferencing ptrStr and loading the string address in X0
        ldr X1, =szSpace                //Loading X1 with the address of szSpace
        bl String_concat                //Branching and linking to String_concat

        ldr X1, =ptrStr                 //Loading X1 with the address of ptrStr
        str X0, [X1]                    //Storing X0 into ptrStr

        ldr X0, =ptrStr                 //Loading X0 with the address of ptrStr
        ldr X0, [X0]                    //Dereferencing ptrStr and loading the string address in X0
        ldr X1, =szStr2                 //Loading X1 with the address of szStr2
        bl String_concat                //Branching and linking to String_concat

        ldr X1, =ptrStr                 //Loading X1 with the address of ptrStr
        str X0, [X1]                    //Storing X0 into ptrStr

        bl putstring                    //Branching and linking to putstring

        ldr X0, =ptrStr                 //Loading X0 with the address of ptrStr
        ldr X0, [X0]                    //Dereferencing ptrStr and loading the string address in X0
        bl free                         //Branching and linking to free

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Setup the parameters to exit the program and then call Linux to do it.
        mov X0, #0                      //Use 0 return code
        mov X8, #93                     //Service command code 93 terminates this program
        svc 0                           //Call linux to output the string

    .end                                //End program
