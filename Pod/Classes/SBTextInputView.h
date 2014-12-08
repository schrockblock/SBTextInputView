//
//  SBTextInputView.h
//  Candle
//
//  Created by Ellidi Jatgeirsson on 8/8/14.
//  Copyright (c) 2014 Ellidi Jatgeirsson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTextInputView;
@class SBBlurView;

@protocol SBTextInputViewDelegate
@optional
- (void)textInputButtonPressed:(NSString *)text;
@end

@interface SBTextInputView : UIView
@property (nonatomic, weak) NSObject<SBTextInputViewDelegate> *delegate;
@property (strong, nonatomic) IBOutlet UITextView *inputTextView;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet SBBlurView *blurBackground;

- (id)initWithFrame:(CGRect)frame superView:(UIView *)superView delegate:(NSObject<SBTextInputViewDelegate> *)delegate;
- (void)notifyTextChange;
@end
