// Programmer: Seth Tran
// RASM-3
// Purpose: Input numeric information from the keyboard, perform addition, subtraction,  multiplication, and division.
//          Check for overflow upon all operations.
// Date: 2022-04-10

    .data

    .global _start                      //Provide program starting address to linker

    .text

_start:



        //Setup the parameters to exit the program and then call Linux to do it.
        mov X0, #0                      //Use 0 return code
        mov X8, #93                     //Service command code 93 terminates this program
        svc 0                           //Call linux to output the string

    .end                                //End program
