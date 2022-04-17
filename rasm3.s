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
szTrue:                     .asciz  "TRUE\n"
szFalse:                    .asciz  "FALSE\n"
szSpace:                    .asciz  " "
ptrStr:                     .quad   0               //Label ptrString. Contains .quad of 0. Pointer string
szStr1:                     .asciz  "Cat in the hat."
szStr2:                     .asciz  "Green eggs and ham."
szStr3:                     .asciz  "cat in the hat."
szOut:                      .skip   21
cLF:                        .byte   10              //Label cLF. Contains .byte of "\n". Used to print line feed to the terminal

    .global _start                      //Provide program starting address to linker

    .text

_start:
        //FOR STRING 1===============================================================
        //Prompting the user to input a string
        ldr X0, =szPrompt               //Loading X0 with the address of szPrompt
        bl putstring                    //Branching and linking to putstring

        //Getting number from the keyboard
        ldr X0, =szStr1                 //Loading X0 with the address of the buffer
        mov X1, #21                     //String length = 21 bytes
        bl getstring                    //Branching and linking to getstring
        //=============================================================================

        //FOR STRING 2===============================================================
        //Prompting the user to input a string
        ldr X0, =szPrompt               //Loading X0 with the address of szPrompt
        bl putstring                    //Branching and linking to putstring

        //Getting number from the keyboard
        ldr X0, =szStr2                 //Loading X0 with the address of the buffer
        mov X1, #21                     //String length = 21 bytes
        bl getstring                    //Branching and linking to getstring
        //=============================================================================

        //FOR STRING 3===============================================================
        //Prompting the user to input a string
        ldr X0, =szPrompt               //Loading X0 with the address of szPrompt
        bl putstring                    //Branching and linking to putstring

        //Getting number from the keyboard
        ldr X0, =szStr3                 //Loading X0 with the address of the buffer
        mov X1, #21                     //String length = 21 bytes
        bl getstring                    //Branching and linking to getstring
        //=============================================================================

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //PRINTING LENGTH FUNCTIONS===============================================================
        ldr X0, =szLength1
        bl putstring

        ldr X0, =szStr1
        bl length

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

        ldr X0, =szLength2
        bl putstring

        ldr X0, =szStr2
        bl length

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

        ldr X0, =szLength3
        bl putstring

        ldr X0, =szStr3
        bl length

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
        ldr X0, =szStringEquals1
        bl putstring

        ldr X0, =szStr1
        ldr X1, =szStr3
        bl equals

        cmp X0, #1
        b.ne false1

        ldr X0, =szTrue
        bl putstring

        b continueAfterEquals1

false1:
        ldr X0, =szFalse
        bl putstring

continueAfterEquals1:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        ldr X0, =szStringEquals2
        bl putstring

        ldr X0, =szStr1
        ldr X1, =szStr1
        bl equals

        cmp X0, #1
        b.ne false2

        ldr X0, =szTrue
        bl putstring

        b continueAfterEquals2

false2:
        ldr X0, =szFalse
        bl putstring

continueAfterEquals2:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_EQUALS FUNCTIONS===============================================================
        ldr X0, =szStringEqualsIgnoreCase1
        bl putstring

        ldr X0, =szStr1
        ldr X1, =szStr3
        bl equalsIgnoreCase

        cmp X0, #1
        b.ne false3

        ldr X0, =szTrue
        bl putstring

        b continueAfterEquals3

false3:
        ldr X0, =szFalse
        bl putstring

continueAfterEquals3:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        ldr X0, =szStringEqualsIgnoreCase2
        bl putstring

        ldr X0, =szStr1
        ldr X1, =szStr2
        bl equals

        cmp X0, #1
        b.ne false4

        ldr X0, =szTrue
        bl putstring

        b continueAfterEquals4

false4:
        ldr X0, =szFalse
        bl putstring

continueAfterEquals4:
        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING COPY FUNCTION===============================================================
        ldr X0, =szCopy1
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        ldr X0, =szCopy2
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        ldr X0, =szCopy3
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_SUBSTRING_1 FUNCTION===============================================================
        ldr X0, =szStringSubstring1
        bl putstring

        ldr X0, =szStr3
        mov X1, #4
        mov X2, #14
        bl String_substring_1

        ldr X1, =ptrStr
        str X0, [X1]

        bl putstring

        ldr X0, =ptrStr
        ldr X0, [X0]
        bl free

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_SUBSTRING_2 FUNCTION===============================================================
        ldr X0, =szStringSubstring2
        bl putstring

        ldr X0, =szStr3
        mov X1, #7
        bl String_substring_2

        ldr X1, =ptrStr
        str X0, [X1]

        bl putstring

        ldr X0, =ptrStr
        ldr X0, [X0]
        bl free

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING CHARAT FUNCTION===============================================================
        ldr X0, =szCharAt
        bl putstring

        ldr X0, =szStr2
        mov X1, #4
        bl charAt

        ldr X1, =ptrStr
        str X0, [X1]

        bl putstring

        ldr X0, =ptrStr
        ldr X0, [X0]
        bl free

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_STARTSWITH_1 FUNCTION===============================================================
        ldr X0, =szStringStartsWith1
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_STARTSWITH_2 FUNCTION===============================================================
        ldr X0, =szStringStartsWith2
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_ENDSWITH FUNCTION===============================================================
        ldr X0, =szStringEndsWith
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_1 FUNCTION===============================================================
        ldr X0, =szStringIndexOf1
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_2 FUNCTION===============================================================
        ldr X0, =szStringIndexOf2
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_3 FUNCTION===============================================================
        ldr X0, =szStringIndexOf3
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_1 FUNCTION===============================================================
        ldr X0, =szStringLastIndexOf1
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_2 FUNCTION===============================================================
        ldr X0, =szStringLastIndexOf2
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_3 FUNCTION===============================================================
        ldr X0, =szStringLastIndexOf3
        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_REPLACE FUNCTION===============================================================
        ldr X0, =szStringReplace
        bl putstring

        ldr X0, =szStr1
        mov X1, #'a'
        mov X2, #'o'
        bl replace

        ldr X1, =ptrStr
        str X0, [X1]

        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_TOLOWERCASE FUNCTION===============================================================
        ldr X0, =szStringToLowerCase
        bl putstring

        ldr X0, =ptrStr
        ldr X0, [X0]
        bl toLowerCase

        ldr X1, =ptrStr
        str X0, [X1]

        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_TOUPPERCASE FUNCTION===============================================================
        ldr X0, =szStringToUpperCase
        bl putstring

        ldr X0, =ptrStr
        ldr X0, [X0]
        bl toUpperCase

        ldr X1, =ptrStr
        str X0, [X1]

        bl putstring

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_CONCAT FUNCTION===============================================================
        ldr X0, =szStringConcat
        bl putstring

        ldr X0, =ptrStr
        ldr X0, [X0]
        ldr X1, =szSpace
        bl String_concat

        ldr X1, =ptrStr
        str X0, [X1]

        ldr X0, =ptrStr
        ldr X0, [X0]
        ldr X1, =szStr2
        bl String_concat

        ldr X1, =ptrStr
        str X0, [X1]

        bl putstring

        ldr X0, =ptrStr
        ldr X0, [X0]
        bl free

        //Printing endline
        ldr X0, =cLF                    //Loading X0 with the address of cLF
        bl putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Setup the parameters to exit the program and then call Linux to do it.
        mov X0, #0                      //Use 0 return code
        mov X8, #93                     //Service command code 93 terminates this program
        svc 0                           //Call linux to output the string

    .end                                //End program
