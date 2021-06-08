//
//  UIBarButtonItem+STDYExtension.h
//  study
//
//  Created by 杨旭东 on 17/2/15.
//  Copyright © 2017年 杨旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (STDYExtension)

+ (instancetype)itemWithImage:(NSString *)image target:(id)target highImage:(NSString *)highImage action:(SEL)action;

@end
