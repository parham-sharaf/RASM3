    .global length              //Provide program starting address to linker

    .text

//FUNCTION length======================================================================
//@PARAM:
//X0 holds the string whose length is to be determined
//X1 holds the counter
//
//@RETURN:
//X0 holds the length of the string
//=====================================================================================

length:
        ldrb W2, [X0], #1       //Loading W2 with the next byte from the string

        cmp W2, #0              //Checking if the character is a null character
        b.ne cont               //If it is a null character, jump to cont

        mov X0, X1              //Moving the counter from X1 to X0 (facilitates printing it out to the terminal)

        ret                     //Return back to main
cont:
        add X1, X1, #1          //Increment counter by 1

        b length                //Unconditional jump to length