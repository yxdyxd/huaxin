//
//  FoodTableViewCell.h
//  PotatoesCommunity
//
//  Created by apple on 2021/6/8.
//

#import <UIKit/UIKit.h>

#define FoodTableViewCell_Identify  @"FoodTableViewCell_Identify"

NS_ASSUME_NONNULL_BEGIN

@interface FoodTableViewCell : UITableViewCell

/// food文案
@property (nonatomic, strong) UILabel *titleLabel;

/// 返回动态行高
-(CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
