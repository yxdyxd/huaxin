//
//  BannerView.m
//  DiscountProduct
//
//  Created by apple on 2020/12/29.
//  Copyright © 2020 apple. All rights reserved.
//

#import "BannerView.h"
//#import "FirstLevelBaseViewController.h"
//#import "BannerWebPageViewController.h"

@interface BannerView () <SDCycleScrollViewDelegate>

/// 点击事件
@property (nonatomic, strong) NSMutableArray *clickUrlArray;
/// 图片地址
@property (nonatomic, strong) NSMutableArray *picUrlArray;
/// 轮播图view
@property (nonatomic, strong) UIScrollView *demoContainerView;
/// bannerView
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView3;
/// 是否数字统计张数
@property (nonatomic, assign) BOOL isShowNum;

@end

@implementation BannerView

- (void)setBannerViewWithFrame:(CGRect)bannerFrame requesetUrl:(NSString *)requestUrl requestType:(NSString *)requestType mainView:(UIView *)mainView isNum:(BOOL)isNum {
    
    self.isShowNum = isNum;
    self.frame = bannerFrame;
    self.height = self.height/1.45;
    
    if ([requestType isEqualToString:@"get"]) {
        
        NetWorkRequest *request = [[NetWorkRequest alloc]init];
        [request requestWithUrl:requestUrl parameters:nil successResponse:^(NSDictionary *dic) {
            //            NSLog(@"轮播图请求成功：%@", dic);
            self.clickUrlArray = @[].mutableCopy;
            self.picUrlArray = @[].mutableCopy;
            for (NSDictionary *tmpDict in [dic objectForKey:@"advert_list"]) {
                [self.clickUrlArray addObject:[tmpDict objectForKey:@"url"]];
                [self.picUrlArray addObject:[tmpDict objectForKey:@"path"]];
            }
            
            self.demoContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(bannerFrame.origin.x, 0, bannerFrame.size.width, bannerFrame.size.height)];
            
            self.demoContainerView.height = self.demoContainerView.height/1.45;
            self.demoContainerView.layer.cornerRadius = 10.0f;
            self.demoContainerView.layer.masksToBounds = YES;
            [self addSubview:self.demoContainerView];
            
            self.cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, bannerFrame.size.width, bannerFrame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
            self.cycleScrollView3.height = self.cycleScrollView3.height/1.45;
            
            
            // 当前轮播图片张数样式
            if (isNum) {
                self.bannerNumshowLab.text = [NSString stringWithFormat:@"1/%ld", (long)self.clickUrlArray.count];
            }else {
                // 选中分页自定义图片(小圆点显示)
//                self.cycleScrollView3.currentPageDotImage = [UIImage svgImageNamed:@"circle_sel" size:(CGSizeMake(30, 30))];
//                self.cycleScrollView3.pageDotImage = [UIImage svgImageNamed:@"circle_nor" size:(CGSizeMake(20, 20))];
            }
            
            self.cycleScrollView3.imageURLStringsGroup = self.picUrlArray;
            self.cycleScrollView3.layer.cornerRadius = 10.0f;
            self.cycleScrollView3.layer.masksToBounds = YES;
            
            [self.demoContainerView addSubview:self.cycleScrollView3];
            if ([mainView isKindOfClass:[UITableView class]]) {
                UITableView *tabView = (UITableView *)mainView;
                tabView.tableHeaderView = self;
            }
        
            [SVProgressHUD dismiss];
        } failureResponse:^(NSError *error) {
            NSLog(@"轮播图请求失败：%@", error);
        }];
    }
    
}

#pragma mark -- 轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    // 上报点击轮播图事件
//    [ActionReportManager reportTheActionWithThing:[NSString stringWithFormat:@"click_homepage_lunbo_%ld", (long)index]];
//    
//    if (![self.clickUrlArray[(long)index] containsString:@"http"]) {
//        // 不包含URL，搜索接口，复用列表A
//        FirstLevelBaseViewController *searchVC = [[FirstLevelBaseViewController alloc]init];
//        
//        // 当前请求的接口为search
//        searchVC.requestUrl = suiShen_Search_Url;
//        searchVC.requesetParam = self.clickUrlArray[(long)index];
//        searchVC.reportType = [NSString stringWithFormat:@"click_homepage_lunbo_%ld_error", index];
//        
//        [[self topViewController].navigationController pushViewController:searchVC animated:YES];
//    }else {
//        BannerWebPageViewController *bannerVC = [[BannerWebPageViewController alloc]init];
//        bannerVC.detailWebUrl = self.clickUrlArray[(long)index];
//        bannerVC.reportType = [NSString stringWithFormat:@"click_homepage_lunbo_%ld_error", index];
//        [[self topViewController].navigationController pushViewController:bannerVC animated:YES];
//    }
}

#pragma mark -- 当前显示张数
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
    if (self.isShowNum) {
        // 展示label
        self.bannerNumshowLab.text = [NSString stringWithFormat:@"%ld/%ld", (long)index + 1, (long)self.clickUrlArray.count];
    }
}

- (UILabel *)bannerNumshowLab {
    if (!_bannerNumshowLab) {
        _bannerNumshowLab = [[UILabel alloc]initWithFrame:(CGRectMake(self.demoContainerView.width - 55*ScaleSize, self.demoContainerView.height - 55*ScaleSize, 40*ScaleSize, 40*ScaleSize))];
        _bannerNumshowLab.layer.cornerRadius = _bannerNumshowLab.width/2;
        _bannerNumshowLab.textAlignment = NSTextAlignmentCenter;
        _bannerNumshowLab.backgroundColor = [UIColor lightGrayColor];
        _bannerNumshowLab.alpha = 0.5;
        _bannerNumshowLab.font = [UIFont systemFontOfSize:17*ScaleSize];
        _bannerNumshowLab.layer.masksToBounds = YES;
        [_cycleScrollView3 addSubview:self.bannerNumshowLab];
    }
    return _bannerNumshowLab;
}

#pragma mark -- 获取当前控制器（实用版）
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
