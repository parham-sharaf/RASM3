    .data
ptrString:          .quad   0       //Label ptrString. Contains .quad of 0. Pointer string

    .global String_substring_2      //Provide program starting address to linker

    .text

    .equ            str, 0          //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            index, 8        //Label index1. Used by the frame pointer. Start of #index1 is at 8 bytes

//FUNCTION String_substring_2======================================================================
//@PARAM:
//X0 holds the string
//X1 holds the first index
//
//@RETURN:
//X0 holds the substring from the string
//=====================================================================================

String_substring_2:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str]          //Storing the string (X0) into the FP at position #str
        str X1, [FP, #index]       //Storing the string (X1) into the FP at position #index

        bl length                   //Branching and linking length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character

        bl malloc                   //Branching and linking to malloc

        ldr X3, =ptrString          //Loading the address of ptrString into X4
        str X0, [X3]                //Storing X0 (ptr address of the string's length + 1) into ptrString

        ldr X0, [FP, #str]          //Popping the stack and storing the string into X0
        ldr X1, [FP, #index]        //Popping the stack and storing the index into X1
        mov X2, #0                  //Setting the counter to 0

        ldr X3, [X3]                //Dereferencing ptrString to show the address of the string

loop:
        ldrb W4, [X0], #1           //Loading W5 with the next byte from the string

        cmp X2, X1                  //Comparing the counter with the first index
        b.lt increment              //If it is less than the first index, jump to increment

        cmp W4, #0                  //Comparing the counter with the second index
        b.eq cont                   //If they are equal, jump to cont

        strb W4, [X3], #1           //Storing W5 on the next byte into X4

increment:
        add X2, X2, #1              //Incrementing counter

        b loop                      //Unconditional jump to loop

cont:
        ldr X0, =ptrString          //Loading the address of ptrString into X0
        ldr X0, [X0]                //Dereferencing ptrString to show the address of the string

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
