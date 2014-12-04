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
    
    self.replyView = [[SBTextInputView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 35) superView:self.view delegate:self];
    self.replyView.inputTextView.text = @"mmmmmmmmmmmmmmmmmmm";
    [self.replyView.button setTitle:@"Post" forState:UIControlStateNormal];
    
    self.replyView.inputTextView.layer.borderColor = [UIColor colorWithRed:175.0f/255.0f green:172.0f/255.0f blue:181.0f/255.0f alpha:1].CGColor;
    self.replyView.inputTextView.layer.borderWidth = .5;
    self.replyView.inputTextView.layer.cornerRadius = 5;
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, self.replyView.blurBackground.bounds.size.width, .25);
    topBorder.backgroundColor = [UIColor colorWithRed:175.0f/255.0f green:172.0f/255.0f blue:181.0f/255.0f alpha:1].CGColor;
    [self.replyView.blurBackground.layer addSublayer:topBorder];
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
