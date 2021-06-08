//
//  NonNetWorkViewController.m
//  DiscountProduct
//
//  Created by apple on 2020/11/2.
//  Copyright © 2020 apple. All rights reserved.
//

#import "NonNetWorkViewController.h"
//#import "GlobalGoodsViewController.h"

@interface NonNetWorkViewController ()

@end

@implementation NonNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 当前网络加载失败
    self.nonNetWorkView = [[UIImageView alloc]initWithFrame:(CGRectMake(80*ScaleSize, 150*ScaleSize, screenWidth - 160*ScaleSize, screenWidth - 160*ScaleSize))];
    self.view.backgroundColor = [UIColor whiteColor];
    self.nonNetWorkView.image = [UIImage imageNamed:@"blank_icon_nonetwork"];
    [self.view addSubview:self.nonNetWorkView];
    
    
    self.netLab = [self setStaticLabelWithFrame:(CGRectMake(self.nonNetWorkView.x, self.nonNetWorkView.bottom, self.nonNetWorkView.width, 40*ScaleSize)) text:@"网络好像走丢了，请刷新重试" textColor:[UIColor blackColor] font:18*ScaleSize backgroundColor:[UIColor whiteColor] type:NSTextAlignmentCenter addView:self.view];
    self.netLab.width = (int)self.netLab.width;
    self.netLab.height = (int)self.netLab.height;
    
    // 点击刷新
    self.refreshBtn = [self addBtnWithframe:CGRectMake(self.nonNetWorkView.x, self.netLab.bottom + 10*ScaleSize, self.nonNetWorkView.width, 40*ScaleSize) title:@"刷新重试" backgroundColor:[UIColor redColor] titleColor:[UIColor whiteColor] borderWidth:0 borderColor:[UIColor whiteColor] cornerRadius:20*ScaleSize masksToBounds:YES titleFont:18*ScaleSize addView:self.view target:self action:@selector(refreshClick) alpha:1];
    
    
}

- (void)refreshClick {
    [SVProgressHUD show];
    // 发送重新请求数据通知
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"requestNetAgain_%@", self.notiStr] object:nil];
    // 退出当前界面
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置Button
- (UIButton *)addBtnWithframe:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds titleFont:(CGFloat)titleFont addView:(UIView *)view target:(id)target action:(SEL)action alpha:(CGFloat)alpha
{
    UIButton *btn = [[UIButton alloc] init];
    
    btn.frame = frame;
    
    [btn setTitle:title forState:(UIControlStateNormal)];
    
    btn.backgroundColor = backgroundColor;
    
    btn.alpha = alpha;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitleColor:titleColor forState:(UIControlStateNormal)];
    btn.layer.borderWidth = borderWidth;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.masksToBounds = masksToBounds;
    
    [view addSubview:btn];
    
    return btn;
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
