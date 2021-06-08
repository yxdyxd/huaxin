//
//  ViewController.m
//  PotatoesCommunity
//
//  Created by apple on 2021/6/8.
//

#import "ViewController.h"
#import "BannerView.h"
#import "FoodTableViewCell.h"

@interface ViewController () <UISearchBarDelegate, UITextFieldDelegate, SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

/// 搜索框
@property (nonatomic, strong)  UISearchBar *customSearchBar;
/// btn
@property (nonatomic, strong) UIButton *proColumnBtn;
@property(nonatomic,strong) UIScrollView *scroll;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
/// 详情tableView
@property (nonatomic, strong) UITableView *mainTableView;
/// 滑动scrollView
@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation ViewController

{
    NSArray *_imagesURLStrings;
    SDCycleScrollView *_customCellScrollViewDemo;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.mainScrollView];
    
    [self addSearchBar];
    [self addBannerView];
    [self addSortBtn];
    [self.mainScrollView addSubview:self.mainTableView];
}

#pragma mark - 添加搜索框
- (void)addSearchBar {
    self.customSearchBar = [[UISearchBar alloc]init];
    self.customSearchBar.frame = CGRectMake(20, 0, screenWidth - 40, 100*ScaleSizeH);
    self.customSearchBar.delegate = self;
    self.customSearchBar.backgroundColor = UIColor.clearColor;
    
    [self.mainScrollView addSubview:self.customSearchBar];
}

#pragma mark - 添加banner
- (void)addBannerView {
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    [self.view addSubview:demoContainerView];
    
    CGFloat w = self.view.bounds.size.width;
    
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg"// 本地图片请填写全名
                            ];
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, self.customSearchBar.bottom - 30, w, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [demoContainerView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.cycleScrollView = cycleScrollView;
    
    [self.mainScrollView addSubview:self.cycleScrollView];
}

#pragma mark - 创建btn
#define distanceGap       33*ScaleSize
#define distanceToBtn     8*ScaleSize
#define nameLabHeight     30*ScaleSize
#define distanceToLab     5*ScaleSize
#define distanceToTop     25*ScaleSize
- (void)addSortBtn {
    
    _scroll = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, self.cycleScrollView.bottom, screenWidth, 100*ScaleSize))];
    
    CGFloat btnWidth = (screenWidth - 2*14*ScaleSize - 4*distanceGap)/5;
    NSArray *titleArr = @[@"一",@"二",@"三",@"四",@"五"];
    
    for (int i = 0; i < 5; i++) {
        
        self.proColumnBtn = [self addBtnWithframe:(CGRectMake(14*ScaleSize  + (distanceGap + btnWidth)*(i%5), distanceToTop+(btnWidth+distanceToLab+distanceToBtn+nameLabHeight+distanceToBtn)*(i/5), btnWidth, btnWidth)) title:titleArr[i] backgroundColor:[UIColor whiteColor] titleColor:[UIColor redColor] borderWidth:1 borderColor:[UIColor blackColor] cornerRadius:btnWidth/2 masksToBounds:YES titleFont:14*ScaleSize addView:self.scroll target:self action:@selector(proColumnBtnClick:) alpha:1];
        
        self.proColumnBtn.tag = 300 + i;
        
    }
    
    [self.mainScrollView addSubview:self.scroll];
}

- (void)proColumnBtnClick:(UIButton *)btn {
    NSLog(@"点击btn：%ld", (long)btn.tag);
}

#pragma mark - UITableView
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, self.scroll.bottom, screenWidth, 200))];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_mainTableView registerClass:[FoodTableViewCell class] forCellReuseIdentifier:FoodTableViewCell_Identify];
    }
    
    return _mainTableView;
}

#pragma mark -- UITableViewDelagate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FoodTableViewCell_Identify];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[FoodTableViewCell new] cellHeight];
}

#pragma mark - UIScrollView
- (UIScrollView *)mainScrollView {
    if (_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 0, screenWidth, screenHeight))];
    }
    
    return _mainScrollView;
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


@end
