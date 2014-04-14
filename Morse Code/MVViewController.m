//
//  MVViewController.m
//  Morse Code
//
//  Created by Matthew Voss on 4/14/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import "MVViewController.h"
#import "NSString+MorseCodeString.h"

@interface MVViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *textEntryBox;
@property (weak, nonatomic) IBOutlet UILabel *translationLabel;

@end

@implementation MVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageView.backgroundColor = [UIColor lightGrayColor];
    
    _translationLabel.text = @" ";
    
    _textEntryBox.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)translateToMorse:(id)sender
{
    
    _translationLabel.text = [NSString convertStringToMorse:_textEntryBox.text];
    
    _imageView.backgroundColor = [self randomColor];
    
}

-(UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(101) / (float)100;
    CGFloat g = arc4random_uniform(101) / (float)100;
    CGFloat b = arc4random_uniform(101) / (float)100;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
