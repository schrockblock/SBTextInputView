//
//  SBBlurView.m
//  SBTextInputView
//
//  Created by Elliot Schrock on 12/4/14.
//  Copyright (c) 2014 Elliot Schrock. All rights reserved.
//

#import "SBBlurView.h"

@interface SBBlurView ()
@property (nonatomic) CGSize size;
@end

@implementation SBBlurView

- (void)setIntrinsicContentSize:(CGSize)size
{
    self.size = size;
}

- (CGSize)intrinsicContentSize
{
    if (self.size.height && self.size.width) return self.size;
    else return self.bounds.size;
}

@end
