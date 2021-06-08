//
//  UIBarButtonItem+STDYExtension.m
//  study
//
//  Created by 杨旭东 on 17/2/15.
//  Copyright © 2017年 杨旭东. All rights reserved.
//

#import "UIBarButtonItem+STDYExtension.h"

@implementation UIBarButtonItem (STDYExtension)

+ (instancetype)itemWithImage:(NSString *)image target:(id)target highImage:(NSString *)highImage action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:(UIControlStateHighlighted)];
    button.size = button.currentBackgroundImage.size;
    //添加点击事件
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return [[self alloc]initWithCustomView:button];
}

@end
