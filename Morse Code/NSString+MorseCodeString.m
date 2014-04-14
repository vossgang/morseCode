//
//  NSString+MorseCodeString.m
//  Morse Code
//
//  Created by Matthew Voss on 4/14/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import "NSString+MorseCodeString.h"
#include <ctype.h>


@implementation NSString (MorseCodeString)


+(NSString *)convertStringToMorse:(NSString *)string
{
    NSString *morseString = @" ";
    
    for (int i = 0; i < string.length; i++) {
        NSString *addedString = [self convertCharToMorse:[string characterAtIndex:i]];
        morseString = [NSString stringWithFormat:@"%@ %@", morseString, addedString];
    }
    return morseString;
}

+(NSString *)convertCharToMorse:(char)letter
{
    NSString *morseString = @" ";

    if (isalnum(letter)) {
        NSLog(@"is alpha numeric");
        
        switch (letter) {
            case 'A':
            case 'a':
                morseString = @".-";
                //do stuff AAA
                break;
            case 'B':
            case 'b':
                morseString = @"-...";
                //do stuff BBB
                break;
            case 'C':
            case 'c':
                morseString = @"-.-.";
                //do stuff CCC
                break;
            case 'D':
            case 'd':
                morseString = @"-..";
                //do stuff DDD
                break;
            case 'E':
            case 'e':
                morseString = @".";
                //do stuff EEE
                break;
            case 'F':
            case 'f':
                morseString = @"..-.";
                //do stuff FFF
                break;
            case 'G':
            case 'g':
                morseString = @"--.";
                //do stuff GGG
                break;
            case 'H':
            case 'h':
                morseString = @"....";
                //do stuff HHH
                break;
            case 'I':
            case 'i':
                morseString = @"..";
                //do stuff III
                break;
            case 'J':
            case 'j':
                morseString = @".---";
                //do stuff JJJ
                break;
            case 'K':
            case 'k':
                morseString = @"-.-";
                //do stuff KKK
                break;
            case 'L':
            case 'l':
                morseString = @".-..";
                //do stuff LLL
                break;
            case 'M':
            case 'm':
                morseString = @"--";
                //do stuff MMM
                break;
            case 'N':
            case 'n':
                morseString = @"-.";
                //do stuff NNN
                break;
            case 'O':
            case 'o':
                morseString = @"---";
                //do stuff OOO
                break;
            case 'P':
            case 'p':
                morseString = @".--.";
                //do stuff PPP
                break;
            case 'Q':
            case 'q':
                morseString = @"--.-";
                //do stuff QQQ
                break;
            case 'R':
            case 'r':
                morseString = @".-.";
                //do stuff RRR
                break;
            case 'S':
            case 's':
                morseString = @"...";
                //do stuff SSS
                break;
            case 'T':
            case 't':
                morseString = @"-";
                //do stuff TTT
                break;
            case 'U':
            case 'u':
                morseString = @"..-";
                //do stuff UUU
                break;
            case 'V':
            case 'v':
                morseString = @"...-";
                //do stuff VVV
                break;
            case 'W':
            case 'w':
                morseString = @".--";
                //do stuff WWW
                break;
            case 'X':
            case 'x':
                morseString = @"-..-";
                //do stuff XXX
                break;
            case 'Y':
            case 'y':
                morseString = @"-.--";
                //do stuff YYY
                break;
            case 'Z':
            case 'z':
                morseString = @"--..";
                //do stuff ZZZ
                break;
                
                
                
            case '0':
                morseString = @"-----";
                //do stuff 000
                break;
            case '1':
                morseString = @".----";
                //do stuff 111
                break;
            case '2':
                morseString = @"..---";
                //do stuff 222
                break;
            case '3':
                morseString = @"...--";
                //do stuff 333
                break;
            case '4':
                morseString = @"....-";
                //do stuff 444
                break;
            case '5':
                morseString = @".....";
                //do stuff 555
                break;
            case '6':
                morseString = @"-....";
                //do stuff 666
                break;
            case '7':
                morseString = @"--...";
                //do stuff 777
                break;
            case '8':
                morseString = @"---..";
                //do stuff 888
                break;
            case '9':
                morseString = @"----.";
                //do stuff 999
                break;
                
            default:
                break;
        }
        
        
        
    }
    
    
    
    return morseString;
}


@end
