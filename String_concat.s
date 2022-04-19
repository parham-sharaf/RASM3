    .data
ptrString:          .quad   0       //Label ptrString. Contains .quad of 0. Pointer string

    .global String_concat           //Provide program starting address to linker

    .text

    .equ            str1, 0         //Label str1. Used by the frame pointer. Start of #str1 is at 0 bytes
    .equ            str2, 8         //Label str2. Used by the frame pointer. Start of #str2 is at 8 bytes
    .equ            length1, 16     //Label length1. Used by the frame pointer. Start of #length1 is at 16 bytes

//FUNCTION String_concat======================================================================
//@PARAM:
//X0 holds the first string
//X1 holds the second string
//
//@RETURN:
//X0 holds the concatenated string
//=====================================================================================

String_concat:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 32 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str1]         //Storing the first string (X0) into the FP at position #str1
        str X1, [FP, #str2]         //Storing the second string (X1) into the FP at position #str2

        bl length                   //Branching and linking length to determine the length of the function

        str X0, [FP, #length1]      //Storing the length of the first string (X0) into the FP at position #length1
        ldr X0, [FP, #str2]         //Popping the stack and storing the second string into X0

        bl length                   //Branching and linking to length

        ldr X1, [FP, #length1]      //Popping the stack and storing the length of the first string into X1
        add X0, X0, X1              //Adding X0 and X1 and storing the result in X0
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character

        bl malloc                   //Branching and linking to malloc

        ldr X2, =ptrString          //Loading the address of ptrString into X4
        str X0, [X2]                //Storing X0 (ptr address of the string's length + 1) into ptrString

        ldr X0, [FP, #str1]         //Popping the stack and storing the string into X0
        ldr X1, [FP, #str2]         //Popping the stack and storing the first character into X1

        ldr X2, [X2]                //Dereferencing ptrString to show the address of the string

loop:
        ldrb W3, [X0], #1           //Loading W3 with the next byte from the first string

        cbz W3, nextStr             //If W3 is a null character, jump to nextStr

        strb W3, [X2], #1           //Storing W3 into the ptrString (X2) on the next byte over

        b loop                      //Unconditional jump to loop

nextStr:
        ldrb W3, [X1], #1           //Loading W3 with the next byte from the second string
        strb W3, [X2], #1           //Storing W3 into the ptrString (X2) on the next byte over

        cbz W3, cont                //If W3 is a null character, jump to cont

        b nextStr                   //Unconditional jump to nextStr

cont:
        ldr X0, =ptrString          //Loading the address of ptrString into X0
        ldr X0, [X0]                //Dereferencing ptrString to show the address of the string

        add SP, SP, #32             //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
