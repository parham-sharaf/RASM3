    .global String_endsWith          //Provide program starting address to linker

    .text

    .equ            str, 0          //Label str1. Used by the frame pointer. Start of #str1 is at 0 bytes
    .equ            phr, 8          //Label str2. Used by the frame pointer. Start of #str2 is at 8 bytes
    .equ            len, 16          //Label len. Used by the frame pointer. Start of #len is at 16 bytes

//FUNCTION String_endsWith======================================================================
//@PARAM:
//X0 holds the string
//X1 holds the sentence phrase
//
//@RETURN:
//X0 holds the boolean (1 = TRUE, 0 = FALSE)
//=====================================================================================

String_endsWith:
        stp LR, FP, [SP, #-16]!     //Loading the LR and FP onto the stack
        sub SP, SP, #32             //Moving the SP down by 16 bytes
        mov FP, SP                  //Moving the FP to match the SP

        str X0, [FP, #str]          //Storing the string (X0) into the FP at position #str
        str X1, [FP, #phr]          //Storing the phrase (X1) into the FP at position #phr

        ldr X0, [FP, #phr]          //Loading X0 with the address of the phrase from the FP
        bl length                   //Branching and linking to length
        str X0, [FP, #len]          //Storing the length of the phrase (X0) into the FP at position #len

        ldr X0, [FP, #str]          //Loading X0 with the address of the string from the FP
        bl length                   //Branching and linking to length
        ldr X1, [FP, #len]          //Loading X1 with the length from the FP

        sub X2, X0, X1              //Finding the difference between the two lengths and storing the result in X2
        cmp X2, #0                  //Checking if the difference is negative
        b.lt exit                   //If it is, set the boolean to false (X0 =/= 1) and exit

        ldr X0, [FP, #str]          //Loading X0 with the addres of the string from the FP
        ldr X1, [FP, #phr]          //Loading X1 with the address of the phrase from the FP

loop:
        cbz X2, loopEnd             //Checking if X2 is equal to 0; if so, jump to loopEnd
        ldrb W3, [X0], #1           //Loading W3 with the ASCII value of the next byte
        sub X2, X2, #1              //Decrementing counter (X2)
        b loop                      //Unconditional jump to loop

loopEnd:
        ldrb W2, [X0], #1           //Loading W3 with the ASCII value of the next byte from the string
        ldrb W3, [X1], #1           //Loading W3 with the ASCII value of the next byte from the phrase

        cmp W2, W3                  //Checking if W2 and W3 are holding the same character
        b.ne exit                   //If not, set the boolean to false (X0 =/= 1) and exit

        cbz W3, check               //Checking to see if we have reached the end of the phrase; if so, check to see if
                                    //the string has also ended

        b loopEnd                   //Unconditional jump to loopEnd

check:
        cbz W2, true                //If W2 is a null character, meaning we are at the end of the string as well, jump
                                    //to true
        b exit                      //Unconditional jump to exit

true:
        mov X0, #1                  //Setting the boolean to TRUE

exit:
        add SP, SP, #32             //Adding 16 to the SP (FP gets garbage collected)
        ldp LR, FP, [SP], #32       //Restoring previous LR and FP from the stack
        ret                         //Return back to main
