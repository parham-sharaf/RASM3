    .data
ptrString:          .quad   0       //Label ptrString. Contains .quad of 0. Pointer string

    .global equalsIgnoreCase        //Provide program starting address to linker

    .text

    .equ            str1, 0         //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            str2, 8         //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            flag, 16

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
        sub SP, SP, #32             //Moving the SP down by 32 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X1, [FP, #str2]         //Storing the second string (X1) into the FP at position #str2

        bl toLowerCase              //Branching and linking to toLowerCase
        str X0, [FP, #str1]         //Storing the first string (X0), now lowercased, into the FP at position #str1

        ldr X0, [FP, #str2]
        bl toLowerCase              //Branching and linking to toLowerCase
        str X0, [FP, #str2]         //Storing the second string (X0), now lowercased, into the FP at position #str2

        ldr X0, [FP, #str1]         //Popping the stack and storing the lowercased first string into X0
        ldr X1, [FP, #str2]         //Popping the stack and storing the lowercased second string into X1
        bl equals                   //Branching and linking to equals

        str X0, [FP, #flag]         //Storing the flag (X0) into the FP at position #flag

        ldr X0, =ptrString          //Loading the address of ptrString into X0
        ldr X0, [X0]                //Dereferencing X0 and storing it in X0
        bl free                     //Branching and linking to free

        ldr X0, [FP, #flag]         //Popping the stack and storing the flag into X0

        add SP, SP, #32             //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
