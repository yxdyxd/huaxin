//
//  LoadMB.m
//  TrainTicket
//
//  Created by 杨旭东 on 2018/1/5.
//  Copyright © 2018年 火眼征信. All rights reserved.
//

#import "LoadMB.h"
#import "MBProgressHUD.h"

#define kGloomyBlackColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]

#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width
#define kDefaultRect     CGRectMake(0, 0, kScreen_width, kScreen_height)

#define kDefaultView [[UIApplication sharedApplication] keyWindow]

#define kGloomyBlackColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
#define kGloomyClearCloler  [UIColor colorWithRed:1 green:1 blue:1 alpha:0]

/* 默认网络提示，可在这统一修改 */
static NSString *const kLoadingMessage = @"加载中...";
/* 默认简短提示语显示的时间，在这统一修改 */
static CGFloat const   kShowTime  = 2.0f;
/* 手势是否可用，默认yes，轻触屏幕提示框隐藏 */
static BOOL isAvalibleTouch = YES;


UIView *gloomyView;//深色背景
UIView *prestrainView;//预加载view
BOOL isShowGloomy;//是否显示深色背景
//UIView *GloomyView;

@implementation LoadMB

//初始化背景图片
+ (void)initialize
{
    if (self == [LoadMB self]) {

        //只会走一次的方法
        [self customView];
    }
}

#pragma mark - 初始化gloomyView
+(void)customView {
    //添加手势
    gloomyView = [[LoadMB alloc] initWithFrame:kDefaultRect];
    //设置加载的背景图片
    gloomyView.backgroundColor = kGloomyBlackColor;
    gloomyView.hidden = YES;
    //是否显示深色背景，初始设置为YES
    isShowGloomy = YES;
}
+ (void)showGloomy:(BOOL)isShow {
    isShowGloomy = isShow;
}

#pragma mark - 简短提示语
//自己封装定义消失时间
+ (void) showBriefAlert:(NSString *) message inView:(UIView *) view {
    [self showBriefAlert:message time:kShowTime inView:view isHerizotal:NO];
}
//外界定义消失时间
+ (void)showBriefAlert:(NSString *)message time:(NSInteger)showTime inView:(UIView *)view {
    [self showBriefAlert:message time:showTime inView:view isHerizotal:YES];
}

+ (void)showBriefAlert:(NSString *)message time:(NSInteger)showTime inView:(UIView *)view isHerizotal:(BOOL)isHerizontal {
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont systemFontOfSize:14];
        hud.animationType = MBProgressHUDAnimationZoom;
        //这种模式是只显示文字
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        //HUD.yOffset = 200;
        
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:NO afterDelay:showTime];
        //横屏的时候开启
//        if (isHerizontal) {
//            hud.transform = CGAffineTransformMakeRotation(M_PI_2);
//        }
    });
}
#pragma mark - 长时间的提示语
+ (void) showPermanentMessage:(NSString *)message inView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:gloomyView animated:YES];
        hud.label.text = message;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeText;
        [gloomyView addSubview:hud];
        [self showClearGloomyView];
        [hud showAnimated:YES];
    });
}
#pragma mark - 网络加载提示用
+ (void) showLoadingInView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.label.text = kLoadingMessage;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
    });
}
//添加文字描述的加载框
+ (void)showWaitingWithTitle:(NSString *)title inView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.label.text = title;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        hud.frame = CGRectMake(0, 0, gloomyView.width, gloomyView.height);
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
    });
}
//添加文字描述的加载框，并且添加取消按钮
+ (void)showWaitingWithTitle:(NSString *)title action:(SEL)action inView:(UIView *)view addView:(UIViewController *)addView {
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.label.text = title;
        hud.removeFromSuperViewOnHide = YES;
        //添加取消按钮
        [hud.button setTitle:NSLocalizedString(@"Cancel", @"HUD cancel button title") forState:UIControlStateNormal];
        [hud.button addTarget:addView action:action forControlEvents:UIControlEventTouchUpInside];
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        hud.frame = CGRectMake(0, 0, gloomyView.width, gloomyView.height);
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
    });
}
//自定义加载等待的图片，延迟消失类型
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title inView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:imageName];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.label.text = title;
        hud.mode = MBProgressHUDModeCustomView;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:kShowTime];
    });
}
#pragma mark - 加载在window上的提示框
+(void)showLoading{
    [self showLoadingInView:nil];
}
+ (void)showWaitingWithTitle:(NSString *)title{
    [self showWaitingWithTitle:title inView:nil];
}
+ (void)showWaitingWithTitle:(NSString *)title action:(SEL)action addView:(UIViewController *)addView
{
    [self showWaitingWithTitle:title action:action inView:nil addView:addView];
}
+(void)showBriefAlert:(NSString *)alert{
    [self showBriefAlert:alert inView:nil];
}
+(void)showPermanentAlert:(NSString *)alert{
    [self showPermanentMessage:alert inView:nil];
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title {
    [self showAlertWithCustomImage:imageName title:title inView:nil];
}
+ (void)showBriefAlert:(NSString *)message time:(NSInteger)showTime {
    [self showBriefAlert:message time:showTime inView:nil isHerizotal:YES];
}
#pragma mark -   GloomyView背景色
+ (void)showBlackGloomyView {
    gloomyView.backgroundColor = kGloomyBlackColor;
    [self gloomyConfig];
}
+ (void)showClearGloomyView {
    gloomyView.backgroundColor = kGloomyClearCloler;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self gloomyConfig];
    });
}
#pragma mark -   决定GloomyView add到已给view或者window上
+ (void)gloomyConfig {
    gloomyView.hidden = NO;
    gloomyView.alpha = 1;
    if (prestrainView) {
        [prestrainView addSubview:gloomyView];
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:gloomyView]) {
            [window addSubview:gloomyView];
        }
    }
}

#pragma mark - 隐藏提示框
+(void)hideAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [LoadMB HUDForView:gloomyView];
#if 1
        gloomyView.frame = CGRectZero;
        gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
        gloomyView.alpha = 0;
        [hud removeFromSuperview];
        [gloomyView removeFromSuperview];
#else
        [UIView animateWithDuration:0.5 animations:^{
            gloomyView.frame = CGRectZero;
            gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
            gloomyView.alpha = 0;
            hud.alpha = 0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
#endif
    });
}
#pragma mark -   获取view上的hud
+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (isAvalibleTouch) {
//        [LoadMB hideAlert];
//    }
//}

@end
