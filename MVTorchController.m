//
//  MVTorchController.m
//  Morse Code
//
//  Created by Matthew Voss on 4/16/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import "MVTorchController.h"
#import "NSString+MorseCodeString.h"


@implementation MVTorchController

-(id)init
{
    self = [super init];
    
    if (self) {
        self.myDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        self.flashQueue = [NSOperationQueue new];

    }
    
    
    return self;
}


-(void)flashOnFor:(NSInteger)microSeconds
{
    
    if ([_myDevice hasTorch]){
        [_myDevice lockForConfiguration:nil];
        
        [_myDevice setTorchMode:AVCaptureTorchModeOn];
        [_myDevice unlockForConfiguration];
    }
    usleep((unsigned int)microSeconds);
}

-(void)flashOffFor:(NSInteger)microSeconds
{

    if ([_myDevice hasTorch]){
        [_myDevice lockForConfiguration:nil];
        
        [_myDevice setTorchMode:AVCaptureTorchModeOff];
        [_myDevice unlockForConfiguration];
    }
    usleep((unsigned int)microSeconds);
}

-(void)morseTorchThis:(NSString *)string
{
    
    [_flashQueue setMaxConcurrentOperationCount:1];
    
    for (int i = 0; i < string.length; i++) {
        NSString *translatedChar = [NSString convertCharToMorse:[string characterAtIndex:i]];
        
        for (int j = 0; j < translatedChar.length; j++) {
            char currentLetter = [translatedChar characterAtIndex:j];
            
            
            
            [_flashQueue addOperationWithBlock:^{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.delegate flashingCurentLetter:[NSString stringWithFormat:@"%c", [string characterAtIndex:i]]];
                }];
                if (currentLetter != ' ') {
                    [self flashCharacter:currentLetter];
                    [self flashOffFor:100000];
                } else {
                    [self flashOffFor:400000];
                    NSLog(@"end off word");
                }
                if ((j == (translatedChar.length - 1)) && currentLetter != ' ') {
                    [self flashOffFor:200000];
                    NSLog(@"end of letter");
                }
                
            }];
        }
        
    }
    
    [_flashQueue addOperationWithBlock:^{
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.delegate doneFlasing];
        }];
    }];
    
}

-(void)flashCharacter:(char)letter
{
    NSLog(@"%c", letter);
    
    [self flashOnFor:[self getDelayForMorseItem:letter]];
    
}

-(NSInteger)getDelayForMorseItem:(char)item
{
    if (item == '.') {
        return 100000;
    } else {
        return 300000;
    }
}


@end
