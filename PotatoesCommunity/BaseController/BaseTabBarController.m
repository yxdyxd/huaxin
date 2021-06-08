//
//  BaseTabBarController.m
//  study
//
//  Created by 杨旭东 on 16/12/21.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "ViewController.h"
#import "TimeViewController.h"
#import "ShareViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //通过apperance统一设置所有UITabBarItem的文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，可以通过apperance对象来统一设置
    
    //设置选中前的字体
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor]; 
    //设置选中后的字体
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    //调用apperance来统一设置字体
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:(UIControlStateSelected)];
    
    //添加子控制器 cosmetics
    [self setupChildVc:[[ViewController alloc] init] title:@"首页" image:@"home" selectImage:@"home-1"];
    [self setupChildVc:[[TimeViewController alloc] init] title:@"时光" image:@"time" selectImage:@"time-1"];
    [self setupChildVc:[[ShareViewController alloc] init] title:@"分享" image:@"share" selectImage:@"share-1"];
    [self setupChildVc:[[MessageViewController alloc] init] title:@"消息" image:@"message" selectImage:@"message-1"];
    [self setupChildVc:[[MyViewController alloc] init] title:@"我的" image:@"MY" selectImage:@"MY-1"];

    //更换TabBar
//    [self setValue:[[BaseTabBar alloc]init] forKeyPath:@"tabBar"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    NSLog(@"%@",self.tabBar.subviews);
}

//初始化子控制器
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    //设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, 2, 0);
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    //防止系统渲染
    vc.tabBarItem.selectedImage = [vc.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = [vc.tabBarItem.image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];

    
    //包装一个导航控制器，添加导航控制器为TabBarContorller的子控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    
    
}

@end
