//
//  MVViewController.m
//  Morse Code
//
//  Created by Matthew Voss on 4/14/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import "MVViewController.h"
#import "NSString+MorseCodeString.h"
#import <AVFoundation/AVFoundation.h>

@interface MVViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView    *imageView;
@property (weak, nonatomic) IBOutlet UITextField    *textEntryBox;
@property (weak, nonatomic) IBOutlet UILabel        *translationLabel;
@property (nonatomic, strong) NSOperationQueue      *flashQueue;

@property (nonatomic, strong) AVCaptureDevice       *myDevice;
@property (nonatomic, strong) NSDictionary          *morseDictionary;



@end


@implementation MVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageView.backgroundColor = [UIColor lightGrayColor];
    
    _translationLabel.text = @" ";
    
    _textEntryBox.delegate = self;
    
    _flashQueue = [NSOperationQueue new];
    [_flashQueue setMaxConcurrentOperationCount:1];
   
    
    _myDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    _morseDictionary =[NSString morseDictionary];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)flashOnFor:(NSInteger)microSeconds
{
    NSLog(@"on %ld", microSeconds);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _imageView.backgroundColor = [UIColor whiteColor];
    }];
    
    if ([_myDevice hasTorch] && [_myDevice hasFlash]){
        [_myDevice lockForConfiguration:nil];
        
        [_myDevice setTorchMode:AVCaptureTorchModeOn];
        [_myDevice unlockForConfiguration];
    }
    usleep(microSeconds);

    
}

-(void)flashOffFor:(NSInteger)microSeconds
{
    NSLog(@"off %ld", microSeconds);


    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _imageView.backgroundColor = [UIColor blackColor];
    }];
    
    if ([_myDevice hasTorch] && [_myDevice hasFlash]){
        [_myDevice lockForConfiguration:nil];
        
        [_myDevice setTorchMode:AVCaptureTorchModeOff];
        [_myDevice unlockForConfiguration];
    }
    usleep(microSeconds);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)translateToMorse:(id)sender
{
    NSString *transletedTexted = [NSString convertStringToMorse:_textEntryBox.text];

    _translationLabel.text = transletedTexted;
    
    for (int i = 0; i < transletedTexted.length; i++) {
        char currentLetter = [transletedTexted characterAtIndex:i];
        [_flashQueue addOperationWithBlock:^{
            if (currentLetter != ' ') {
                [self flashCharacter:currentLetter];
                [self flashOffFor:100000];
            } else {
                [self flashOffFor:600000];
            }
           
        }];
    }
    
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self translateToMorse:textField];
    return YES;
}












-(void)Queuestuff
{
    
    
    NSOperationQueue *imageQueue = [NSOperationQueue new];
    
    [imageQueue setMaxConcurrentOperationCount:1]; //this makes at a serial queue --- one at a time
    
    [imageQueue addOperationWithBlock:^{
        //do background stuff
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //do UI stuff
        }];
    }];
    
    
    
    
    
    NSBlockOperation *crazy = [NSBlockOperation blockOperationWithBlock:^{
        //do background stuff
    }];
    
    [crazy setCompletionBlock:^{
        //
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //do UI stuff
        }];
    }];
    
    
    
    //concurent Queue
    [imageQueue addOperationWithBlock:^{
        //first thing
    }];
    //
    [imageQueue addOperationWithBlock:^{
        // second thing
    }];
    
    //this kills all UNSTARTED blocks
    [imageQueue performSelector:@selector(cancelAllOperations) withObject:nil afterDelay:4.0];
    
    
    
    
}
- (IBAction)turnOnFlash:(id)sender
{
    
    AVCaptureDevice *myDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([myDevice hasTorch] && [myDevice hasFlash]){
        [myDevice lockForConfiguration:nil];
        
        [myDevice setTorchMode:AVCaptureTorchModeOn];
        [myDevice unlockForConfiguration];
    }
    
    
    
}
- (IBAction)turnOffFalsh:(id)sender
{
    AVCaptureDevice *myDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([myDevice hasTorch] && [myDevice hasFlash]){
        [myDevice lockForConfiguration:nil];
        
        [myDevice setTorchMode:AVCaptureTorchModeOff];
        
        [myDevice unlockForConfiguration];
    }
    
    
}

@end
