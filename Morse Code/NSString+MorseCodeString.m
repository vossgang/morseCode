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
        switch (letter) {
            case 'A': case 'a': morseString = @".-";    break;
            case 'B': case 'b': morseString = @"-...";  break;
            case 'C': case 'c': morseString = @"-.-.";  break;
            case 'D': case 'd': morseString = @"-..";   break;
            case 'E': case 'e': morseString = @".";     break;
            case 'F': case 'f': morseString = @"..-.";  break;
            case 'G': case 'g': morseString = @"--.";   break;
            case 'H': case 'h': morseString = @"....";  break;
            case 'I': case 'i': morseString = @"..";    break;
            case 'J': case 'j': morseString = @".---";  break;
            case 'K': case 'k': morseString = @"-.-";   break;
            case 'L': case 'l': morseString = @".-..";  break;
            case 'M': case 'm': morseString = @"--";    break;
            case 'N': case 'n': morseString = @"-.";    break;
            case 'O': case 'o': morseString = @"---";   break;
            case 'P': case 'p': morseString = @".--.";  break;
            case 'Q': case 'q': morseString = @"--.-";  break;
            case 'R': case 'r': morseString = @".-.";   break;
            case 'S': case 's': morseString = @"...";   break;
            case 'T': case 't': morseString = @"-";     break;
            case 'U': case 'u': morseString = @"..-";   break;
            case 'V': case 'v': morseString = @"...-";  break;
            case 'W': case 'w': morseString = @".--";   break;
            case 'X': case 'x': morseString = @"-..-";  break;
            case 'Y': case 'y': morseString = @"-.--";  break;
            case 'Z': case 'z': morseString = @"--..";  break;
                
            case '0':           morseString = @"-----"; break;
            case '1':           morseString = @".----"; break;
            case '2':           morseString = @"..---"; break;
            case '3':           morseString = @"...--"; break;
            case '4':           morseString = @"....-"; break;
            case '5':           morseString = @"....."; break;
            case '6':           morseString = @"-...."; break;
            case '7':           morseString = @"--..."; break;
            case '8':           morseString = @"---.."; break;
            case '9':           morseString = @"----."; break;
                
            default:
                break;
        }
        
    }
    
    return morseString;
}



+(NSDictionary *)morseDictionary
{
    return                   @{@"A": @".-",
                               @"B": @"-...",
                               @"C": @"-.-.",
                               @"D": @"-..",
                               @"E": @".",
                               @"F": @"..-.",
                               @"G": @"--.",
                               @"H": @"....",
                               @"I": @"..",
                               @"J": @".---",
                               @"K": @"-.-",
                               @"L": @".-..",
                               @"M": @"--",
                               @"N": @"-.",
                               @"O": @"---",
                               @"P": @".--.",
                               @"Q": @"--.-",
                               @"R": @".-.",
                               @"S": @"...",
                               @"T": @"-",
                               @"U": @"..-",
                               @"V": @"...-",
                               @"W": @".--",
                               @"X": @"-..-",
                               @"Y": @"-.--",
                               @"Z": @"--..",
                               
                               @"0": @"-----",
                               @"1": @".----",
                               @"2": @"..---",
                               @"3": @"...--",
                               @"4": @"....-",
                               @"5": @".....",
                               @"6": @"-....",
                               @"7": @"--...",
                               @"8": @"---..",
                               @"9": @"----.",
                               
                               @" ": @" "};
}


@end
