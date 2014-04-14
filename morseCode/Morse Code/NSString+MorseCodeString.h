//
//  NSString+MorseCodeString.h
//  Morse Code
//
//  Created by Matthew Voss on 4/14/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MorseCodeString)

+(NSString *)convertStringToMorse:(NSString *)string;
+(NSString *)convertCharToMorse:(char)letter;

@end
