//
//  SBViewController.m
//  SBTextInputView
//
//  Created by Elliot Schrock on 10/12/14.
//  Copyright (c) 2014 Elliot Schrock. All rights reserved.
//

#import "SBViewController.h"
#import "SBTextInputView.h"

@interface SBViewController () <SBTextInputViewDelegate>
@property (nonatomic, strong) UITextField *hiddenTextField;
@property (nonatomic, strong) SBTextInputView *replyView;

- (IBAction)dismiss;
- (IBAction)show;
@end

@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.replyView = [[SBTextInputView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44) superView:self.view delegate:self];
    self.replyView.inputTextView.text = @"mmmmmmmmmmmmmmmmmmm";
}

- (IBAction)dismiss
{
    [self.replyView resignFirstResponder];
}

- (IBAction)show
{
    [self.replyView becomeFirstResponder];
}
@end
