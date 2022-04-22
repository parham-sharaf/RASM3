    .global charAt                  //Provide program starting address to linker

    .text

    .equ            str, 0          //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            index, 8        //Label index. Used by the frame pointer. Start of #index is at 8 bytes

//FUNCTION charAt======================================================================
//@PARAM:
//X0 holds the string
//X1 holds the index of which the character is at
//
//@RETURN:
//X0 holds the character at the index
//=====================================================================================

charAt:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str]          //Storing the string (X0) into the FP at position #str
        str X1, [FP, #index]        //Storing the index (X1) into the FP at position #index
        bl length                   //Branching and linking length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character

        bl malloc                   //Branching and linking to malloc

        ldr X3, =ptrString          //Loading the address of ptrString into X3
        str X0, [X3]                //Storing X0 (ptr address of the string's length + 1) into ptrString

        ldr X0, [FP, #str]          //Popping the stack and storing the string into X0
        ldr X1, [FP, #index]        //Popping the stack and storing the index into X1
        mov X2, #0                  //Moving 0 into X2

        ldr X3, [X3]                //Dereferencing ptrString to show the address of the string

loop:
        cmp X2, X1                  //Comparing the counter (X2) with the wanted index (X1)
        b.gt loopEnd                //If they are equal, jump to loopEnd

        ldrb W4, [X0], #1           //Loading W4 with the next byte from the string

        //If the counter goes out of bounds
        cbz W4, fail                //If W4 is a null character, jump to fail

        add X2, X2, #1              //Incrementing counter

        b loop                      //Unconditional jump to loop

loopEnd:
        strb W4, [X3], #1           //Storing the character at the index (W4) into the ptrString
        b cont                      //Unconditional jump to cont

fail:
        strb wzr, [X3], #1          //Storing a null character into the ptrString

cont:
        ldr X0, =ptrString          //Loading the address of ptrString into X0
        ldr X0, [X0]                //Dereferencing ptrString to show the address of the string

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
