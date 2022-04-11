    .global length                      //Provide program starting address to linker

    .text

//X4 holds the string
//X0 holds the counter

length:
        ldrb W5, [X4], #1

        cmp W5, #0              //Checking if the character is a null character
        b.ne cont               //If it is a null character, return back

        ret
cont:
        //Increment counter
        add X0, X0, #1

        b length
