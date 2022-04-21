    .global String_copy             //Provide program starting address to linker

    .text

    .equ            str, 0          //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            len, 8          //Label len. Used by the from pointer. Start of #len is at 8 bytes

//FUNCTION String_copy======================================================================
//@PARAM:
//X0 holds the address of the string that needs to be copied
//
//@RETURN:
//X0 holds the address to the copied string
//=====================================================================================

String_copy:
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
        strb W2, [X0], #1           //Storing W2 on the next byte into X0

        cbnz W2, loop               //If W2 does not contains a null character, jump to loop

loopEnd:
        ldr X1, [FP, #len]          //Loading the length from the FP to X1
        sub X0, X0, X1              //Moving the character pointer back to the start of the string

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
