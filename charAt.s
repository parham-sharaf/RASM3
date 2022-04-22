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
        bl length                   //Branching and linking length to determine the length of the string+

        ldr X1, [FP, #index]        //Loading X1 with the address of the string from the FP

        sub X0, X0, X1              //Subtracting the index from the length of the string
        cmp X0, #0                  //Comparing the difference with 0
        b.lt outOfBounds            //If the difference comes out to be negative, jump to outOfBounds

        ldr X0, [FP, #str]          //Loading X0 with the address of the string from the FP

        add X0, X0, X1              //Moving the "pointer" up to the byte right before the byte that needs to be printed

        b cont                      //Unconditional jump to cont

outOfBounds:
        mov X0, #0                  //Setting X0 to 0

cont:
        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
