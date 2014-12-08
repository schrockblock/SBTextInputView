//
//  SBTextInputView.m
//  Candle
//
//  Created by Ellidi Jatgeirsson on 8/8/14.
//  Copyright (c) 2014 Ellidi Jatgeirsson. All rights reserved.
//

#import "SBTextInputView.h"
#import "SBBlurView.h"

@interface SBTextInputView () <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) UITextField *hiddenTextField;
@property (nonatomic) CGFloat contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;

- (IBAction)sendPressed:(id)sender;

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
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
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
    self.textViewHeight.constant = self.frame.size.height - 2 * self.inputTextView.frame.origin.y;
    
    if (!self.blurBackground) {
        self.blurBackground = [[SBBlurView alloc] initWithFrame:self.bounds];
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
    [self.inputTextView layoutIfNeeded];
    self.contentHeight = self.inputTextView.contentSize.height;
    [self invalidateIntrinsicContentSize];
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

- (void)notifyTextChange
{
    [self.inputTextView layoutIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self textViewDidChange:self.inputTextView];
    });
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
    if (delta) {
        self.textViewHeight.constant += delta;
        [self invalidateIntrinsicContentSize];
        [self updateLayout];
    }
}

- (CGSize)intrinsicContentSize
{
    CGFloat height = self.contentHeight + 2 * self.inputTextView.frame.origin.y;
    if (height > SBTextInputViewMaxHeight) {
        height = SBTextInputViewMaxHeight;
    }
    CGSize size = CGSizeMake(self.frame.size.width, height);
    return size;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat height = self.inputTextView.contentSize.height;
    if (self.contentHeight != height && height <= SBTextInputViewMaxHeight - 2 * self.inputTextView.frame.origin.y) {
        CGFloat deltaHeight = height - self.contentHeight;
        [self heightChangedBy:deltaHeight];
        
        self.contentHeight = height;
        
        [self updateLayout];
    }
}

#pragma mark - actions

- (IBAction)sendPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(textInputButtonPressed:)]) [self.delegate textInputButtonPressed:self.inputTextView.text];
}

@end
