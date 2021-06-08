//
//  NonNetWorkViewController.h
//  DiscountProduct
//
//  Created by apple on 2020/11/2.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NonNetWorkViewController : UIViewController

/// 网络错误图片
@property (nonatomic, strong) UIImageView *nonNetWorkView;
/// 网络错误提示语
@property (nonatomic, strong) UILabel *netLab;
/// 添加通知的界面
@property (nonatomic, strong) NSString *notiStr;
/// 网络错误原因
@property (nonatomic, strong) NSString *errorStr;
/// 刷新btn
@property (nonatomic, strong) UIButton *refreshBtn;

@end

NS_ASSUME_NONNULL_END
