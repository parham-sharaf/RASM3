    .global toUpperCase             //Provide program starting address to linker

    .text

    .equ            str, 0          //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            len, 8          //Label len. Used by the from pointer. Start of #len is at 8 bytes

//FUNCTION toUpperCase======================================================================
//@PARAM:
//X0 holds the string to have its characters converted to uppercase
//
//@RETURN:
//X0 holds the address to the pointer string that contains the string with all its characters being uppercase
//=====================================================================================

toUpperCase:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str]          //Storing the string (X0) into the FP at position #str
        bl length                   //Branching and linking length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character
        str X0, [FP, #len]          //Storing the length (X0) into the FP at position #len

        bl malloc                   //Branching and linking to malloc

        ldr X1, [FP, #str]          //Popping the stack and storing the string into X0

loop:
        ldrb W2, [X1], #1           //Loading W2 with the next byte from the string

        cmp W2, #'z'                //Checking if W2 is greater than the ASCII value of 'z'
        b.gt loopEnd                //If it is, jump to loopEnd

        cmp W2, #'a'                //Checkinf if W2 is less than the ASCII value of 'a'
        b.lt loopEnd                //If it is, jump to loopEnd

        sub W2, W2, #('a' - 'A')    //Subtracting the difference between the ASCII values of upper and lower case and
                                    //subtracting it from the ASCII value of W2 to make it the uppercase of that letter

loopEnd:
        strb W2, [X0], #1           //Storing W2 on the next byte into X1

        cbz W2, cont                //If W2 is a null character, jump to cont

        b loop                      //Unconditional jump to loop

cont:
        ldr X1, [FP, #len]          //Loading the length from the FP to X1
        sub X0, X0, X1              //Moving the character pointer back to the start of the string

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
