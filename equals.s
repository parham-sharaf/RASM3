    .global equals              //Provide program starting address to linker

    .text

//FUNCTION equals======================================================================
//@PARAM:
//X0 holds the first string to be compared
//X1 holds the second string to be compared
//
//@RETURN:
//X0 holds the boolean (1 = TRUE, 0 = FALSE)
//=====================================================================================

equals:
        ldrb W2, [X0], #1       //Loading W2 with the next byte from the first string
        ldrb W3, [X1], #1       //Loading W3 with the next byte from the second string

        cbz W2, checkOther      //If W2 is a null character, check to see if we are at the end of the second string

        cmp W2, W3              //Checking to see if the character from the first string and second string match
        b.ne noMatch            //If they do not match, jump to noMatch (NOT setting the boolean to TRUE)

        b equals                //Unconditional jump to equals

checkOther:
        cbz W3, same            //If W3 is a null character, jump to same
        b noMatch               //Unconditional jump to noMatch

same:
        mov X0, #1              //Setting the boolean to TRUE
        ret                     //Return back to main

noMatch:
        mov X0, #0              //Setting the boolean to FALSE
        ret                     //Return back to main
