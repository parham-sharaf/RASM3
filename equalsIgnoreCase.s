    .global equalsIgnoreCase        //Provide program starting address to linker

    .text

    .equ            str1, 0         //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            str2, 8         //Label str. Used by the frame pointer. Start of #str is at 0 bytes

//FUNCTION equalsIgnoreCase======================================================================
//@PARAM:
//X0 holds the first string to be compared
//X1 holds the second string to be compared
//
//@RETURN:
//X0 holds the boolean (1 = TRUE, 0 = FALSE)
//=====================================================================================

equalsIgnoreCase:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X1, [FP, #str2]         //Storing the second string (X1) into the FP at position #str2

        bl toLowerCase              //Branching and linking to toLowerCase
        str X0, [FP, #str1]         //Storing the first string (X0), now lowercased, into the FP at position #str1

        ldr X0, [FP, #str2]         //Loading X0 with the address of the second string
        bl toLowerCase              //Branching and linking to toLowerCase
        str X0, [FP, #str2]         //Storing the second string (X0), now lowercased, into the FP at position #str2

        ldr X0, [FP, #str1]         //Loading X0 with the address of the lowercased first string
        ldr X1, [FP, #str2]         //Loading X1 with the address of the lowercased second string
        bl equals                   //Branching and linking to equals

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
