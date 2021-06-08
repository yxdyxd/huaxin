//
//  UIView+STDYExtension.m
//  study
//
//  Created by 杨旭东 on 17/2/9.
//  Copyright © 2017年 杨旭东. All rights reserved.
//

#import "UIView+STDYExtension.h"

@implementation UIView (STDYExtension)

- (void)setSize:(CGSize)size
{
    CGRect fram = self.frame;
    fram.size = size;
    self.frame = fram;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

@end
