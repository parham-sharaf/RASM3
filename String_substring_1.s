    .data
ptrString:          .quad   0       //Label ptrString. Contains .quad of 0. Pointer string

    .global String_substring_1      //Provide program starting address to linker

    .text

    .equ            str, 0          //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            index1, 8       //Label index1. Used by the frame pointer. Start of #index1 is at 8 bytes
    .equ            index2, 16      //Label index2. Used by the frame pointer. Start of #index2 is at 16 bytes

//FUNCTION String_substring_1======================================================================
//@PARAM:
//X0 holds the string
//X1 holds the first index
//X2 holds the second index
//
//@RETURN:
//X0 holds the substring from the string
//=====================================================================================

String_substring_1:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 32 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str]          //Storing the string (X0) into the FP at position #str
        str X1, [FP, #index1]       //Storing the first index (X1) into the FP at position #index1
        str X2, [FP, #index2]       //Storing the second index (X2) into the FP at position #index2

        bl length                   //Branching and linking length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character

        bl malloc                   //Branching and linking to malloc

        ldr X4, =ptrString          //Loading the address of ptrString into X4
        str X0, [X4]                //Storing X0 (ptr address of the string's length + 1) into ptrString

        ldr X0, [FP, #str]          //Popping the stack and storing the string into X0
        ldr X1, [FP, #index1]       //Popping the stack and storing the first index into X1
        ldr X2, [FP, #index2]       //Popping the stack and storing the second index into X2
        mov X3, #0                  //Setting the counter to 0

        ldr X4, [X4]                //Dereferencing ptrString to show the address of the string

loop:
        ldrb W5, [X0], #1           //Loading W5 with the next byte from the string

        cmp X3, X1                  //Comparing the counter with the first index
        b.lt increment              //If it is less than the first index, jump to increment

        cmp X3, X2                  //Comparing the counter with the second index
        b.eq cont                   //If they are equal, jump to cont

        strb W5, [X4], #1           //Storing W5 on the next byte into X4

increment:
        add X3, X3, #1              //Incrementing counter

        b loop                      //Unconditional jump to loop

cont:
        ldr X0, =ptrString          //Loading the address of ptrString into X0
        ldr X0, [X0]                //Dereferencing ptrString to show the address of the string

        add SP, SP, #32             //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
