//
//  BannerView.h
//  DiscountProduct
//
//  Created by apple on 2020/12/29.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView

/// banner张数显示(可自定义调节lab大小)
@property (nonatomic, strong) UILabel *bannerNumshowLab;

/// 添加头部轮播图
/// @param bannerFrame banner位置
/// @param requestUrl 请求banner详细信息url
/// @param requestType 请求类型
/// @param mainView 添加的视图
/// @param isNum 是否数字显示张数
- (void)setBannerViewWithFrame:(CGRect)bannerFrame requesetUrl:(NSString *)requestUrl requestType:(NSString *)requestType mainView:(UIView *)mainView isNum:(BOOL)isNum;

@end
