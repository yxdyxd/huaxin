//
//  Header.h
//  TrainTicket
//
//  Created by 杨旭东 on 2017/11/27.
//  Copyright © 2017年 火眼征信. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define APPDELEGATE     ((AppDelegate*)[[UIApplication sharedApplication] delegate])

//打印全部信息
#define CLog(format, ...)  NSLog(format, ## __VA_ARGS__)
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

//适配屏幕
#define ScreenToTop 64
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

//设置放大或者缩小系数
#define ScaleSize [UIScreen mainScreen].bounds.size.width/414.0
#define ScrHScaleSize 736.0/[UIScreen mainScreen].bounds.size.height

//适配iPhone X （状态栏）
#define Statusbar [[UIApplication sharedApplication] statusBarFrame].size.height
#define Navigationbar self.navigationController.navigationBar.frame.size.height
//判断当前是否为iPhoneX
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//http://123.56.153.221:8001/
//http://123.56.153.221:8002/
//http://123.56.153.221:8003/
//http://123.56.153.221:7890/
//http://192.168.30.71:7890/ (本地)
#define url(type) [NSString stringWithFormat:@"http://123.56.153.221:8003/%@",type]

#import "UIView+STDYExtension.h"
#import "UITextField+CHTHealper.h"
#import "LoadMB.h"
#import "UIViewExt.h"
#import "SDCycleScrollView.h"
// 自封装AFN
#import "NetWorkRequest.h"
#import "SVProgressHUD.h"

// 导航栏高度
#define  MRNavBarHeight (isIphoneX ? 88.0 : 64.0)
// 底部TabBar高度
#define  MRTbaBarHeight (isIphoneX ? 83.0 : 49.0)
/// 底部安全区域高度
#define  MRSafeArea (isIphoneX ? 34 : 0)
/// 距离底部安全区域预留空间
#define  MRSafeAreaGap (isIphoneX ? 15 : 0)


// 宽度适配系数
//#define ScaleSize [UIScreen mainScreen].bounds.size.width/375.0
#define ScaleSizeW [UIScreen mainScreen].bounds.size.width/375.0
// 高度适配系数
#define ScaleSizeH [UIScreen mainScreen].bounds.size.height/667.0
// 屏幕宽高
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height


/**
 自定义RGB颜色
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 \
alpha:(a)]

#define Main_BG_color RGBCOLOR(248,248,248)
#define Main_BG_hotCollectionView_color RGBCOLOR(255,255,255)

// 判断是否为刘海屏
#define isIphoneX ({\
BOOL isiPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
UIWindow *window = [UIApplication sharedApplication].delegate.window;\
if (window.safeAreaInsets.bottom > 0.0) {\
isiPhoneX = YES;\
}\
}\
isiPhoneX;\
})


#endif /* Header_h */
