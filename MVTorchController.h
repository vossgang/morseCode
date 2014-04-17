//
//  MVTorchController.h
//  Morse Code
//
//  Created by Matthew Voss on 4/16/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol MVTorchControllerDelegate <NSObject>

@optional
-(void)flashingCurentLetter:(NSString *)letter;
-(void)doneFlasing;

@end


@interface MVTorchController : NSObject

@property (nonatomic, unsafe_unretained) id<MVTorchControllerDelegate>  delegate;
@property (nonatomic, strong)               NSOperationQueue            *flashQueue;
@property (nonatomic, strong)               AVCaptureDevice             *myDevice;

-(void)morseTorchThis:(NSString *)String;


@end
