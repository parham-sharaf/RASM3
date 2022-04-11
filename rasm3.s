// Programmer: Seth Tran & Parham sharafoleslami
// RASM-3
// Purpose: Write string functions and run them with the provided strings
// Date: 2022-04-10

    .data
szStr1:         .asciz  "Cat in the hat."
szStr2:         .asciz  "Green eggs and ham."
szStr3:         .asciz  "cat in the hat."
szTest:         .asciz  "Seth"
szOut:          .skip   21
cLF:            .byte   10              //Label cLF. Contains .byte of "\n". Used to print line feed to the terminal

    .global _start                      //Provide program starting address to linker

    .text

_start:
        mov X0, #0
        ldr X4, =szStr1
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

        //Setup the parameters to exit the program and then call Linux to do it.
        mov X0, #0                      //Use 0 return code
        mov X8, #93                     //Service command code 93 terminates this program
        svc 0                           //Call linux to output the string

    .end                                //End program
