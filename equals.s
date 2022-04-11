    .global equals                      //Provide program starting address to linker

    .text

    //X3 holds the first string
    //X4 holds the second string

equals:
        ldrb W5, [X3], #1
        ldrb W6, [X4], #1

        cmp W5, #0              //Checking if the character is a null character
        b.eq checkOther              //If it is a null character, return back

        cmp W5, W6
        b.ne exit

        b equals

checkOther:
        cmp W6, #0              //Checking if the character is a null character
        b.eq same               //If it is a null character, return back

        b exit

same:
        mov X6, #1

exit:
        ret
