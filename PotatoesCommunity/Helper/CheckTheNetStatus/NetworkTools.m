//
//  NetworkTools.m
//  DetectTheNetWork
//
//  Created by 费城 on 2020/1/14.
//  Copyright © 2020 BUG-Company. All rights reserved.
//

#import "NetworkTools.h"
#import "AFNetworkReachabilityManager.h"
#import <objc/runtime.h>

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface NetworkTools ()

@property (nonatomic, strong) NSString *netStr;
@property (nonatomic, strong) NSTimer *JJTimer;
@property (nonatomic, assign) BOOL isAlert;
// 弹窗的时间间隔
@property (nonatomic, assign) NSInteger alertTime;

@end

@implementation NetworkTools

- (void)AfnGetNetworkStates {
//    __weak typeof(self) ws = self;
    // 监控网络状态
    self.alertTime = 60;
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"状态不知道");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没网络");
                self.JJTimer = [NSTimer scheduledTimerWithTimeInterval:self.alertTime target:self selector:@selector(kkk) userInfo:nil repeats:YES];
                self.isAlert = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                [self.JJTimer invalidate];
                self.JJTimer = nil;
                self.isAlert = NO;
                self.alertTime = 60;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"流量");
                [self.JJTimer invalidate];
                self.JJTimer = nil;
                self.isAlert = NO;
                self.alertTime = 60;
                break;
            default:
                break;
        }
    }];
    //开始监控
    [reachability startMonitoring];
}

- (void)kkk {
    if (self.isAlert) {
        [self setAlertControllerWithTitle:@"网络连接失败" message:@"请检查你的网络设置" okAction:@"确定" cancelAction:@"取消" addView:[[UIApplication sharedApplication] keyWindow].rootViewController];
        if (self.alertTime > 21) {
            self.alertTime = self.alertTime - 10;
        }
        NSLog(@"当前弹窗的时间为：%ld",(long)self.alertTime);
        
        // 重新定义定时器
        [self.JJTimer invalidate];
        self.JJTimer = nil;
        self.JJTimer = [NSTimer scheduledTimerWithTimeInterval:self.alertTime target:self selector:@selector(kkk) userInfo:nil repeats:YES];
    
        self.isAlert = NO;
    }
}

// 检测具体的网络状态
+ (NSString *)systemGetNetworkType

{

    UIApplication *app = [UIApplication sharedApplication];

    id statusBar = [app valueForKeyPath:@"statusBar"];

    NSString *network = @"";

     

    if (KIsiPhoneX) {

//        iPhone X

        id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
        UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
        NSArray *subviews = [[foregroundView subviews][2] subviews];

        for (id subview in subviews) {

            if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                
                network = @"WIFI";
            }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                
                network = [subview valueForKeyPath:@"originalText"];

            }
        }
    }else {

        // 非iPhone X

        UIView *foregroundView = [statusBar valueForKeyPath:@"foregroundView"];
        NSArray *subviews = [foregroundView subviews];
        for (id subview in subviews) {

            if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {

                int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];

                switch (networkType) {

                    case 0:
                        network = @"NONE";
                        break;

                    case 1:
                        network = @"2G";
                        break;

                    case 2:
                        network = @"3G";
                        break;

                    case 3:
                        network = @"4G";
                        break;

                    case 5:
                        network = @"WIFI";
                        break;

                    default:
                        break;

                }
            }
        }
    }

    if ([network isEqualToString:@""]) {
        network = @"NO DISPLAY";
    }
    
    return network;
}

#pragma mark - 设置alertView
// 在设置时，需要设置rootViewController
- (UIAlertController *)setAlertControllerWithTitle:(NSString *)title message:(NSString *)message okAction:(NSString *)okAction cancelAction:(NSString *)cancelAction addView:(UIViewController *)view
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *w = [UIAlertAction actionWithTitle:okAction style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        self.isAlert = YES;
        
        // 跳转到网络设置界面：https://www.jianshu.com/p/5fd0ac245e85
        
        // iOS 11+ 现在只允许跳转到系统设置首页/该应用的设置界面
        // 跳转到设置 - wifi / 该应用的设置界面
//        NSURL *url1 = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
        NSURL *url1 = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        // iOS10也可以使用url2访问，不过使用url1更好一些，可具体根据业务需求自行选择
        NSURL *url2 = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if (@available(iOS 11.0, *)) {
            if ([[UIApplication sharedApplication] canOpenURL:url2]){
                [[UIApplication sharedApplication] openURL:url2 options:@{} completionHandler:nil];
            }
        } else {
            if ([[UIApplication sharedApplication] canOpenURL:url1]){
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url1 options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:url1];
                }
            }
        }
        
    }];
    
    UIAlertAction *q = [UIAlertAction actionWithTitle:cancelAction style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        self.isAlert = YES;
    }];
    
    [alert addAction:w];
    [alert addAction:q];
    
    [view presentViewController:alert animated:YES completion:nil];
    
    return alert;
}

@end
