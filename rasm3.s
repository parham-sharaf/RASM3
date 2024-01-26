// Programmer: Seth Tran & Parham Sharafoleslami
// RASM-3
// Purpose: Write string functions and run them with the provided strings
// Date: 2022-04-10

    .data
szOpeningMsg:               .asciz  "Names: Seth Tran & Parham Sharafoleslami\nClass: CS 3B\nLab: rasm3.asm\nDate: April 10, 2022\n\n"       //Label szOpeningMsg. Used to print out the opening information to the terminal
szPrompt:                   .asciz  "Please enter a string: "                                   //Prompt used in output
szPmpt1a:                   .asciz  "1.\ts1.length() = "                                        //Prompt used in output
szPmpt1b:                   .asciz  "\ts2.length() = "                                          //Prompt used in output
szPmpt1c:                   .asciz  "\ts3.length() = "                                          //Prompt used in output
szPmpt2:                    .asciz  "2.\tString_equals(s1,s3) = "                               //Prompt used in output
szPmpt3:                    .asciz  "3.\tString_equals(s1,s1) = "                               //Prompt used in output
szPmpt4:                    .asciz  "4.\tString_equalsIgnoreCase(s1,s3) = "                     //Prompt used in output
szPmpt5:                    .asciz  "5.\tString_equalsIgnoreCase(s1,s2) = "                     //Prompt used in output
szPmpt6a:                   .asciz  "6.\ts4 = String_copy(s1)"                                  //Prompt used in output
szPmpt6b:                   .asciz  "\ts1 = "                                                   //Prompt used in output
szPmpt6c:                   .asciz  "\ts4 = "                                                   //Prompt used in output
szPmpt7:                    .asciz  "7.\tString_substring_1(s3,4,14) = "                        //Prompt used in output
szPmpt8:                    .asciz  "8.\tString_substring_2(s3,7) = "                           //Prompt used in output
szPmpt9:                    .asciz  "9.\tString_charAt(s2,4) = "                                //Prompt used in output
szPmpt10a:                  .asciz  "10.\tString_startsWith_1(s1,11,"                           //Prompt used in output
szPmpt10b:                  .asciz  "hat."                                                      //Prompt used in output
szPmpt10c:                  .asciz  ") = "                                                      //Prompt used in output
szPmpt11a:                  .asciz  "11.\tString_startsWith_2(s1,"                              //Prompt used in output
szPmpt11b:                  .asciz  "Cat"                                                       //Prompt used in output
szPmpt11c:                  .asciz  ") = "                                                      //Prompt used in output
szPmpt12a:                  .asciz  "12.\tString_endsWith(s1,"                                  //Prompt used in output
szPmpt12b:                  .asciz  "in the hat."                                               //Prompt used in output
szPmpt12c:                  .asciz  ") = "                                                      //Prompt used in output
szPmpt13a:                  .asciz  "13.\tString_indexOf_1(s2,'g') = "                          //Prompt used in output
szPmpt14:                   .asciz  "14.\tString_indexOf_2(s2,'g',9) = "                        //Prompt used in output
szPmpt15a:                  .asciz  "15.\tString_indexOf_3(s2,"                                 //Prompt used in output
szPmpt15b:                  .asciz  "eggs"                                                      //Prompt used in output
szPmpt15c:                  .asciz  ") = "                                                      //Prompt used in output
szPmpt16:                   .asciz  "16.\tString_lastIndexOf_1(s2,'g') = "                      //Prompt used in output
szPmpt17:                   .asciz  "17.\tString_lastIndexOf_2(s2,'g',6) = "                    //Prompt used in output
szPmpt18a:                  .asciz  "18.\tString_lastIndexOf_3(s2,"                             //Prompt used in output
szPmpt18b:                  .asciz  "egg"                                                       //Prompt used in output
szPmpt18c:                  .asciz  ") = "                                                      //Prompt used in output
szPmpt19:                   .asciz  "19.\tString_replace(s1,'a','o') = "                        //Prompt used in output
szPmpt20:                   .asciz  "20.\tString_toLowerCase(s1) = "                            //Prompt used in output
szPmpt21:                   .asciz  "21.\tString_toUpperCase(s1) = "                            //Prompt used in output
szPmpt22a:                  .asciz  "22.\tString_concat(s1, "                                   //Prompt used in output
szPmpt22b:                  .asciz  ");\n\tString_concat(s1, s2) = "                            //Prompt used in output
szTrue:                     .asciz  "TRUE\n"            //Label szTrue. Used for the output
szFalse:                    .asciz  "FALSE\n"           //Label szFalse. Used for the output
szInput10:                  .asciz  "hat."              //Label szInput10. Used for input in Function 10
szInput11:                  .asciz  "Cat"               //Label szInput11. Used for input in Function 11
szInput12:                  .asciz  "in the hat."       //Label szInput12. Used for input in Function 12
szInput22:                  .asciz  " "                 //Label szInput22. Used for input in Function 22
szInput15:                  .asciz  "eggs"              //Label szInput15. Used for input in Function 15
szInput18:                  .asciz  "egg"               //Label szInput15. Used for input in Function 18
szStr1:                     .skip   21                  //Label szStr1. Contains a buffer to store a string
szStr2:                     .skip   21                  //Label szStr2. Contains a buffer to store a string
szStr3:                     .skip   21                  //Label szStr3. Contains a buffer to store a string
szStr4:                     .skip   21                  //Label szStr4. Contains a buffer to store a string
szOut:                      .skip   21                  //Label szOut. Contains a buffer to print to the terminal
cQuotes:                    .byte   34                  //Label cQuotes. Contains .byte of '"'. Used to print " to the terminal
cQuote:                     .byte   39                  //Label cQuote. Contains .byte of '''. Used to print " to the terminal
cSpace:                     .byte   32                  //Label cSpace. Contains .byte of ' '. Used to print a space to the terminal
cLF:                        .byte   10                  //Label cLF. Contains .byte of "\n". Used to print line feed to the terminal

    .global _start                      //Provide program starting address to linker

    .text

_start:
        //Printing out information to the terminal
        ldr X0, =szOpeningMsg           //Loading X0 with the address of szOpeningMsg
        bl putstring                    //Branching and linking to putstring

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
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        //PRINTING LENGTH FUNCTIONS===============================================================
        LDR X0, =szPmpt1a               //Loading X0 with the address of szPmpt1a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        BL String_length                //Branching and linking to String_length

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        LDR X0, =szPmpt1b               //Loading X0 with the address of szPmpt1b
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr2                 //Loading X0 with the address of szStr2
        BL String_length                //Branching and linking to String_length

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        LDR X0, =szPmpt1c               //Loading X0 with the address of szPmpt1c
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr3                 //Loading X0 with the address of szStr3
        BL String_length                //Branching and linking to String_length

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_EQUALS FUNCTIONS===============================================================
        LDR X0, =szPmpt2                //Loading X0 with the address of szPmpt2
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        LDR X1, =szStr3                 //Loading X1 with the address of szStr3
        BL String_equals                //Branching and linking to equals

        //Printing result
        BL printTorF                    //Printing TRUE or FALSE based off the function output

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        LDR X0, =szPmpt3                //Loading X0 with the address of szPmpt3
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        LDR X1, =szStr1                 //Loading X1 with the address of szStr1
        BL String_equals                //Branching and linking to String_equals

        //Printing result
        BL printTorF                    //Printing TRUE or FALSE based off the function output

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_EQUALSIGNORECASE FUNCTIONS===============================================================
        LDR X0, =szPmpt4                //Loading X0 with the address of szPmpt4
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        LDR X1, =szStr3                 //Loading X1 with the address of szStr3
        BL String_equalsIgnoreCase      //Branching and linking to String_equalsIgnoreCase

        //Printing result
        BL printTorF                    //Printing TRUE or FALSE based off the function output

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        LDR X0, =szPmpt5                //Loading X0 with the address of szPmpt5
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        LDR X1, =szStr2                 //Loading X1 with the address of szStr2
        BL String_equalsIgnoreCase      //Branching and linking to String_equalsIgnoreCase

        //Printing result
        BL printTorF                    //Printing TRUE or FALSE based off the function output

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_COPY FUNCTION===============================================================
        LDR X0, =szPmpt6a               //Loading X0 with the address of szPmpt6a
        BL putstring                    //Branching and linking to putstring

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        LDR X0, =szPmpt6b               //Loading X0 with the address of szPmpt6b
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        BL putstring                    //Branching and linking to putstring

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        LDR X0, =szPmpt6c               //Loading X0 with the address of szPmpt6c
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        BL String_copy                  //Branching linking to putstring

        LDR X1, =szStr4                 //Loading X1 with the address of szStr4

loop:
        LDRB W2, [X0], #1               //Loading W2 with the next byte from the string (X0)
        STRB W2, [X1], #1               //Storing W2 in the next byte of the buffer (X1)

        CBNZ W2, loop                   //If W2 does not contain a null character, jump to loop

        LDR X0, =szStr4                 //Loading X0 with the address of szStr4
        BL putstring                    //Bracnhing and linking to putstring

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_SUBSTRING_1 FUNCTION===============================================================
        LDR X0, =szPmpt7                //Loading X0 with the address of szPmpt7
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szStr3                 //Loading X0 with the address of szStr3
        MOV X1, #4                      //Setting X1 to 4
        MOV X2, #14                     //Setting X2 to 14
        BL String_substring_1           //Branching and linking to String_substring_1

        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_SUBSTRING_2 FUNCTION===============================================================
        LDR X0, =szPmpt8                //Loading X0 with the address of szPmpt8
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szStr3                 //Loading X0 with the address of szStr3
        MOV X1, #7                      //Setting X1 to 7
        BL String_substring_2           //Branching and linking to String_substring_2

        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING CHARAT FUNCTION===============================================================
        LDR X0, =szPmpt9                //Loading X0 with the address of szPmpt9
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuote                 //Loading X0 with the address of cQuote
        BL putch                        //Branching and linking to putch

        LDR X0, =szStr2                 //Loading X0 with the address of szStr2
        MOV X1, #4                      //Setting X1 to 4
        BL String_charAt                //Branching and linking to String_charAt

        cbnz X0, printChar              //Checking if X0 contains 0; if so, jump to printChar

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal
        //=============================================================================

        b continueAfterPrintChar        //Unconditional jump to continueAfterPrintChar

printChar:
        BL putch                        //Branching and linking to putch

        LDR X0, =cQuote                 //Loading X0 with the address of cQuote
        BL putch                        //Branching and linking to putch

continueAfterPrintChar:
        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_STARTSWITH_1 FUNCTION===============================================================
        LDR X0, =szPmpt10a              //Loading X0 with the address of szPmpt10a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt10b              //Loading X0 with the address of szPmpt10b
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt10c              //Loading X0 with the address of szPmpt10c
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        MOV X1, #11                     //Setting X1 with 11
        LDR X2, =szInput10              //Loading X2 with the address of szStringStartWith1Phrase
        BL String_startsWith_1          //Branching and linking to String_startsWith_1

        //Printing result
        BL printTorF                    //Printing TRUE or FALSE based off the function output

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_STARTSWITH_2 FUNCTION===============================================================
        LDR X0, =szPmpt11a              //Loading X0 with the address of szPmpt11a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt11b              //Loading X0 with the address of szPmpt11b
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt11c              //Loading X0 with the address of szPmpt11c
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szstr1
        LDR X1, =szInput11              //Loading X1 with the address of szInput11
        BL String_startsWith_2          //Branching and linking to String_startsWith_2

        //Printing result
        BL printTorF                    //Printing TRUE or FALSE based off the function output

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_ENDSWITH FUNCTION===============================================================
        LDR X0, =szPmpt12a              //Loading X0 with the address of szPmpt12a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt12b              //Loading X0 with the address of szPmpt12b
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt12c              //Loading X0 with the address of szPmpt12c
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr1                 //Loading X0 with the address of szStr1
        LDR X1, =szInput12              //Loading X1 with the address of szInput12
        BL String_endsWith              //Branching and linking to String_endsWith

        //Printing result
        BL printTorF                    //Printing TRUE or FALSE based off the function output

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_1 FUNCTION===============================================================
        LDR X0, =szPmpt13a              //Loading X0 with the address of szPmpt13a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr2                 //Loading X0 with the address of szStr2
        MOV X1, #'g'                    //Setting X1 to the ASCII value of 'g'
        BL String_indexOf_1             //Branching and linking to String_indexOf_1

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_2 FUNCTION===============================================================
        LDR X0, =szPmpt14               //Loading X0 with the address of szPmpt14a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr2                 //Loading X0 with the address of szStr2
        MOV X1, #'g'                    //Setting X1 to the ASCII value of 'g'
        MOV X2, #9                      //Setting X2 to 9
        BL String_indexOf_2             //Branching and linking to String_indexOf_2

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_INDEXOF_3 FUNCTION===============================================================
        LDR X0, =szPmpt15a              //Loading X0 with the address of szPmpt15a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt15b              //Loading X0 with the address of szPmpt15b
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt15c              //Loading X0 with the address of szPmpt15c
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr2                 //Loading X0 with the address of szStr2
        LDR X1, =szInput15              //Loading X1 with the address of szInput15
        BL String_indexOf_3             //Branching and linking to String_indexOf_3

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_1 FUNCTION===============================================================
        LDR X0, =szPmpt16               //Loading X0 with the address of szPmpt16
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr2                 //Loading X0 with the address of szStr2
        MOV X1, #'g'                    //Setting X1 to the ASCII value of 'g'
        BL String_lastIndexOf_1         //Branching and linking to String_lastIndexOf_1

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_2 FUNCTION===============================================================
        LDR X0, =szPmpt17               //Loading X0 with the address of szPmpt17
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr2                 //Loading X0 with the address of szStr2
        MOV X1, #'g'                    //Setting X1 to the ASCII value of 'g'
        MOV X2, #6                      //Setting X2 to 6
        BL String_lastIndexOf_2         //Branching and linking to String_lastIndexOf_2

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_LASTINDEXOF_3 FUNCTION===============================================================
        LDR X0, =szPmpt18a              //Loading X0 with the address of szPmpt18a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt18b              //Loading X0 with the address of szPmpt18b
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt18c              //Loading X0 with the address of szPmpt18c
        BL putstring                    //Branching and linking to putstring

        LDR X0, =szStr2                 //Loading X0 with the address of szStr2
        LDR X1, =szInput18              //Loading X1 with the address of szInput18
        BL String_lastIndexOf_3         //Branching and linking to String_lastIndexOf_3

        //CONVERTING TO ASCII CHARACTERS TO DISPLAY ON TERMINAL========================
        LDR X1, =szOut                  //Loading X1 with the address of the buffer
                                        //X0 already contains the int value from the calculations
        BL int64asc                     //Executing int64asc to convert the int value to ASCII

        LDR X0, =szOut                  //Loading X0 with the address of the buffer
        BL putstring                    //Executing putstring to print answer to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_REPLACE FUNCTION===============================================================
        LDR X0, =szPmpt19               //Loading X0 with the address of szPmpt19
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szStr1                 //Lopading X0 with the address of szStr1
        MOV X1, #'a'                    //Setting X1 to the ASCII value of 'a'
        MOV X2, #'o'                    //Setting X2 to the ASCII value of 'o'
        BL String_replace               //Branching and linking to String_replace

        MOV X3, X0                      //Moving X0 to X3
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_TOLOWERCASE FUNCTION===============================================================
        LDR X0, =szPmpt20               //Loading X0 with the address of szPmpt20
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        MOV X0, X3                      //Moving X0 to X3
        BL String_toLowerCase           //Branching and linking to String_toLowerCase

        MOV X3, X0                      //Moving X3 to X0
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_TOUPPERCASE FUNCTION===============================================================
        LDR X0, =szPmpt21               //Loading X0 with the address of szPmpt21
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        MOV X0, X3                      //Moving X0 to X3
        BL String_toUpperCase           //Branching and linking to String_toUpperCase

        MOV X3, X0                      //Moving X3 to X0
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //PRINTING STRING_CONCAT FUNCTION===============================================================
        LDR X0, =szPmpt22a              //Loading X0 with the address of szPmpt11a
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =cSpace                 //Loading X0 with the address of cSpace
        BL putch                        //Branching and linking to putch

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        LDR X0, =szPmpt22b              //Loading X0 with the address of szPmpt11b
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        MOV X0, X3                      //Moving X0 to X3
        LDR X1, =szInput22              //Loading X1 with the address of szInput22
        BL String_concat                //Branching and linking to String_concat

        LDR X1, =szStr2                 //Loading X1 with the address of szStr2
        BL String_concat                //Branching and linking to String_concat

        MOV X3, X0                      //Moving X0 to X3
        BL putstring                    //Branching and linking to putstring

        LDR X0, =cQuotes                //Loading X0 with the address of cQuotes
        BL putch                        //Branching and linking to putch

        MOV X0, X3                      //Moving X3 to X0
        BL free                         //Branching and linking to free

        //Printing endline
        LDR X0, =cLF                    //Loading X0 with the address of cLF
        BL putch                        //Executing putch to print the line feed to the terminal
        //=============================================================================

        //Setup the parameters to exit the program and then call Linux to do it.
        MOV X0, #0                      //Use 0 return code
        MOV X8, #93                     //Service command code 93 terminates this program
        SVC 0                           //Call linux to output the string

        //PRINT TRUE/FALSE FUNCTION===============================================================
printTorF:
        STR LR, [SP, #-16]!             //Pushing LR onto the stack

        CBZ X0, printFalse              //If X0 is 0, jump to printFalse to print FALSE

        LDR X0, =szTrue                 //Loading X0 with the address of szTrue
        BL putstring                    //Branching and linking to putstring

        B exit                          //Unconditional jump to exit

printFalse:
        LDR X0, =szFalse                //Loading X0 with the address of szFalse
        BL putstring                    //Branching and linking to putstring

exit:
        LDR LR, [SP], #16               //Popping the stack and loading LR -> LR
        RET                             //Return
        //=============================================================================

    .end                                //End program
