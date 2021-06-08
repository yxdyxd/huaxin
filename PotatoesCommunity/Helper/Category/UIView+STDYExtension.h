//
//  UIView+STDYExtension.h
//  study
//
//  Created by 杨旭东 on 17/2/9.
//  Copyright © 2017年 杨旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (STDYExtension)
/* 在分类中声明@property，只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量 */
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;

@end
