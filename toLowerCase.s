    .data
ptrString:          .quad   0       //Label ptrString. Contains .quad of 0. Pointer string

    .global toLowerCase             //Provide program starting address to linker

    .text

    .equ            str, 0          //Label str. Used by the frame pointer. Start of #str is at 0 bytes

//FUNCTION toLowerCase======================================================================
//@PARAM:
//X0 holds the string to have its characters converted to lowercase
//
//@RETURN:
//X0 holds the address to the pointer string that contains the string with all its characters being lowercase
//=====================================================================================

toLowerCase:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #16             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str]          //Storing the string (X0) into the FP at position #str
        bl length                   //Branching and linking length to determine the length of the function
        add X0, X0, #1              //Adding 1 to the length to compensate for the null character

        bl malloc                   //Branching and linking to malloc

        ldr X1, =ptrString          //Loading the address of ptrString into X1
        str X0, [X1]                //Storing X0 (ptr address of the string's length + 1) into ptrString

        ldr X0, [FP, #str]          //Popping the stack and storing the string into X0
        ldr X1, [X1]                //Dereferencing ptrString to show the address of the string

loop:
        ldrb W2, [X0], #1           //Loading W2 with the next byte from the string

        cmp W2, #'Z'                //Checking if W2 is greater than the ASCII value of 'Z'
        b.gt loopEnd                //If it is, jump to loopEnd

        cmp W2, #'A'                //Checkinf if W2 is less than the ASCII value of 'A'
        b.lt loopEnd                //If it is, jump to loopEnd

        add W2, W2, #('a' - 'A')    //Adding the difference between the ASCII values of upper and lower case and
                                    //adding it from the ASCII value of W2 to make it the lowercase of that letter

loopEnd:
        strb W2, [X1], #1           //Storing W2 on the next byte into X1

        cbz W2, cont                //If W2 is a null character, jump to cont

        b loop                      //Unconditional jump to loop

cont:
        ldr X0, =ptrString          //Loading the address of ptrString into X0
        ldr X0, [X0]                //Dereferencing ptrString to show the address of the string

        add SP, SP, #16             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #16       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
