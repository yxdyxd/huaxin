//
//  BaseNavigationController.m
//  study
//
//  Created by 杨旭东 on 17/2/20.
//  Copyright © 2017年 杨旭东. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    self.navigationBar.tintColor = [UIColor blackColor];
    //设置导航栏不透明
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
}

//在这个方法中可以拦截所有push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
       
        //如果push进来的不是第一个控制器，设置左侧自定义按钮
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setTitle:@"返回" forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"左箭头"] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"左箭头-2"] forState:(UIControlStateHighlighted)];
        //设置button的尺寸
        btn.size = CGSizeMake(70, 30);
        //将button中所有内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置button字体的颜色
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        //设置button高亮字体的颜色
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        //减小button的左边距
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //添加button点击事件
        [btn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        
        //跳转的时候隐藏底部TabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //添加到左侧的按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    
    //这句代码放在后边，让后边的可以覆盖上边的代码
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}



@end
