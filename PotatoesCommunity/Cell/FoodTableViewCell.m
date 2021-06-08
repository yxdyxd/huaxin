//
//  FoodTableViewCell.m
//  PotatoesCommunity
//
//  Created by apple on 2021/6/8.
//

#import "FoodTableViewCell.h"

@implementation FoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self drawFrame];
    }
    return self;
}

- (void)drawFrame {
    self.titleLabel = [self setStaticLabelWithFrame:(CGRectMake(15, 10, screenWidth - 30, 50)) text:@"我们吃过的美食" textColor:UIColor.blackColor font:17 backgroundColor:UIColor.orangeColor type:NSTextAlignmentLeft addView:self.contentView];
}

/// 返回动态行高
-(CGFloat)cellHeight {
    return self.titleLabel.bottom + 10;
}

#pragma mark - 设置label
- (UILabel *)setStaticLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)font backgroundColor:(UIColor *)color type:(enum NSTextAlignment)type addView:(UIView *)view
{
    UILabel *label = [[UILabel alloc]init];
    label.adjustsFontSizeToFitWidth = YES;
    label.frame = frame;
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.backgroundColor = color;
    label.textAlignment = type;
    [view addSubview:label];
    
    return label;
}

@end
