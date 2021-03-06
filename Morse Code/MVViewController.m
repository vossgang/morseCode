//
//  MVViewController.m
//  Morse Code
//
//  Created by Matthew Voss on 4/14/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import "MVViewController.h"
#import "NSString+MorseCodeString.h"
#import "MVTorchController.h"
#import <AVFoundation/AVFoundation.h>
#import <ProgressHUD/ProgressHUD.h>


@interface MVViewController () <UITextFieldDelegate, MVTorchControllerDelegate>

@property (weak, nonatomic) IBOutlet    UILabel             *currentLetterLabel;

@property (weak, nonatomic) IBOutlet    UITextField         *textEntryBox;
@property (weak, nonatomic) IBOutlet    UILabel             *translationLabel;
@property (nonatomic, strong)           NSOperationQueue    *flashQueue;
@property (weak, nonatomic) IBOutlet    UIButton            *translateButton;

@property (nonatomic, strong)           AVCaptureDevice     *myDevice;
@property (nonatomic, strong)           NSDictionary        *morseDictionary;

@property (nonatomic, strong)           ProgressHUD         *myHUD;
@property (nonatomic, strong)           MVTorchController   *myTorchController;

@end


@implementation MVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _myTorchController          = [MVTorchController new];
    _myTorchController.delegate = self;
    _translationLabel.text      = _currentLetterLabel.text = @" ";
    _textEntryBox.delegate      = self;
    _flashQueue                 = [NSOperationQueue new];
    _myDevice                   = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _morseDictionary            = [NSString morseDictionary];
    [_translateButton setEnabled:NO];
    [_flashQueue setMaxConcurrentOperationCount:1];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)translateToMorse:(id)sender
{
    [_translateButton setEnabled:NO];
    [_textEntryBox setEnabled:NO];
    
    NSString *uppercase         = [_textEntryBox.text uppercaseString];
    _textEntryBox.text          =  uppercase;
    
    NSString *transletedTexted  = [NSString convertStringToMorse:_textEntryBox.text];
    _translationLabel.text      = transletedTexted;
    
    [_myTorchController morseTorchThis:_textEntryBox.text];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
 
    if (_textEntryBox.text.length) {
        [self translateToMorse:textField];
    } else {
        [_translateButton setEnabled:NO];
    }

    return YES;
}

- (IBAction)cancelOperationQueue:(id)sender
{
    [_myTorchController.flashQueue cancelAllOperations];
    [_translateButton setEnabled:YES];
    [_textEntryBox setEnabled:YES];
    [ProgressHUD dismiss];
    _currentLetterLabel.text = @" ";
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (UITextFieldTextDidChangeNotification || (_textEntryBox.text.length)) {
        [_translateButton setEnabled:YES];
    }
    
    return YES;
}

- (IBAction)turnOnFlash:(id)sender
{
    if ([_myDevice hasTorch]){
        [_myDevice lockForConfiguration:nil];
        [_myDevice setTorchMode:AVCaptureTorchModeOn];
        [_myDevice unlockForConfiguration];
    }
}

- (IBAction)turnOffFalsh:(id)sender
{
    if ([_myDevice hasTorch]){
        [_myDevice lockForConfiguration:nil];
        [_myDevice setTorchMode:AVCaptureTorchModeOff];
        [_myDevice unlockForConfiguration];
    }
}

-(void)flashingCurentLetter:(NSString *)letter
{
    [ProgressHUD show:[NSString stringWithFormat:@"%@", letter]];
    _currentLetterLabel.text = [NSString stringWithFormat:@"%@", letter];
}

-(void)doneFlasing
{
    [self cancelOperationQueue:self];
}

@end