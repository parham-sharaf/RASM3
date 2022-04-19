    .data
ptrString:          .quad   0       //Label ptrString. Contains .quad of 0. Pointer string

    .global replace                 //Provide program starting address to linker

    .text

    .equ            str, 0          //Label str. Used by the frame pointer. Start of #str is at 0 bytes
    .equ            char1, 8        //Label char1. Used by the frame pointer. Start of #char1 is at 8 bytes
    .equ            char2, 16       //Label char2. Used by the frame pointer. Start of #char2 is at 16 bytes

//FUNCTION replace======================================================================
//@PARAM:
//X0 holds the string
//X1 holds the character that is being replaced
//X2 holds the character that is replacing
//
//@RETURN:
//X0 holds the string with the replaced characters
//=====================================================================================

replace:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 32 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str]          //Storing the string (X0) into the FP at position #str
        str W1, [FP, #char1]        //Storing the first index (X1) into the FP at position #index1
        str W2, [FP, #char2]        //Storing the second index (X2) into the FP at position #index2

        bl length                   //Branching and linking length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character

        bl malloc                   //Branching and linking to malloc

        ldr X3, =ptrString          //Loading the address of ptrString into X4
        str X0, [X3]                //Storing X0 (ptr address of the string's length + 1) into ptrString

        ldr X0, [FP, #str]          //Popping the stack and storing the string into X0
        ldr W1, [FP, #char1]        //Popping the stack and storing the first character into X1
        ldr W2, [FP, #char2]        //Popping the stack and storing the second character into X2

        ldr X3, [X3]                //Dereferencing ptrString to show the address of the string

loop:
        ldrb W4, [X0], #1           //Loading W5 with the next byte from the string

        cmp W4, W1                  //Comparing the current character (W4) with the character being replaced (W1)
        b.eq repl                   //If they are equal, jump to repl

        b store                     //Unconditional jump to store

repl:
        strb W2, [X3], #1           //Storing the replacing character (W2) on the next byte into X3

        b checkEnd                  //Unconditional jump to checkEnd

store:
        strb W4, [X3], #1           //Storing W4 on the next byte into X3

checkEnd:
        cbnz W4, loop               //If W4 is not a null character, jump to loop

cont:
        ldr X0, =ptrString          //Loading the address of ptrString into X0
        ldr X0, [X0]                //Dereferencing ptrString to show the address of the string

        add SP, SP, #32             //Adding 32 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
