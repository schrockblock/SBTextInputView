//
//  SBTextInputView.m
//  Candle
//
//  Created by Ellidi Jatgeirsson on 8/8/14.
//  Copyright (c) 2014 Ellidi Jatgeirsson. All rights reserved.
//

#import "SBTextInputView.h"

@interface SBTextInputView () <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) UITextField *hiddenTextField;
@property (nonatomic) CGFloat contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;

- (IBAction)sendPressed;
@end

static CGFloat const SBTextInputViewMaxHeight = 80;

@implementation SBTextInputView

- (id)initWithFrame:(CGRect)frame
          superView:(UIView *)superView
           delegate:(NSObject<SBTextInputViewDelegate> *)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self setup:superView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup:nil];
    }
    return self;
}

- (void)setup:(UIView *)superView
{
    [[NSBundle mainBundle] loadNibNamed:@"SBTextInputView" owner:self options:nil];
    [self addSubview:self.view];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_view]|"
                                                                 options:0
                                                                 metrics:0
                                                                   views:NSDictionaryOfVariableBindings(_view)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_view]|"
                                                                 options:0
                                                                 metrics:0
                                                                   views:NSDictionaryOfVariableBindings(_view)]];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.inputTextView.delegate = self;
    if (!self.blurBackground) {
        self.blurBackground = [[UIToolbar alloc] initWithFrame:self.bounds];
        [self insertSubview:self.blurBackground atIndex:0];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_blurBackground]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(_blurBackground)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_blurBackground]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(_blurBackground)]];
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self updateLayout];
    
    if (superView) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.hidden = YES;
        textField.inputAccessoryView = self;
        [superView addSubview:textField];
        self.hiddenTextField = textField;
    }
}

- (void)didMoveToWindow
{
    self.contentHeight = [self measureTextViewHeight];
}

// Code from apple developer forum - @Steve Krulewitz, @Mark Marszal, @Eric Silverberg
- (CGFloat)measureTextViewHeight
{
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        return ceilf([self.inputTextView sizeThatFits:self.inputTextView.frame.size].height);
    }else {
        return self.inputTextView.contentSize.height;
    }
}

- (BOOL)resignFirstResponder
{
    [self.inputTextView resignFirstResponder];
    [self.hiddenTextField resignFirstResponder];
    return [super resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self.hiddenTextField becomeFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.inputTextView becomeFirstResponder];
    });
    return [super becomeFirstResponder];
}

- (void)updateLayout
{
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)heightChangedBy:(CGFloat)delta
{
    self.textViewHeight.constant += delta;
    [self invalidateIntrinsicContentSize];
    [self updateLayout];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = CGSizeMake(self.frame.size.width, self.contentHeight > 80 ? 80 : self.contentHeight);
    return size;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat height = [self measureTextViewHeight];
    if (self.contentHeight != height && height <= SBTextInputViewMaxHeight) {
        CGFloat deltaHeight = height - self.contentHeight;
        [self heightChangedBy:deltaHeight];
        
        self.textViewHeight.constant = height;
        self.contentHeight = height;
        
        [self updateLayout];
    }
}

- (IBAction)sendPressed
{
    if ([self.delegate respondsToSelector:@selector(buttonPressed:)]) [self.delegate buttonPressed:self.inputTextView.text];
}

@end
