//
//  JHGankViewController.m
//  妹子
//
//  Created by cjj on 16/6/28.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHGankViewController.h"
#import "JHGankBaseController.h"

@interface JHGankViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
/**
 *  标签栏底部的指示器
 */
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, strong) UILabel *currentSelectLabel;
@end


@implementation JHGankViewController
// lazy init
-(UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil) {
        _contentScrollView.pagingEnabled = YES;
    }
    return _contentScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 不自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = YES;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    // 初始化导航栏
    [self setupNav];
    
    // 初始化控制器
    [self setupChildViewController];
    
    // 初始化标题
    [self setupTitleLabel];
}


/**
 * 初始化标题
 */
-(void)setupTitleLabel
{
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    // 基本变量
    CGFloat labelW = JHScreenWidth / self.childViewControllers.count;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollView.height;
    
    // 在文字滚动视图添加标题
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.tag = i;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [titleLabel setTextColor:GankTabBarGrayColor];
        [titleLabel setHighlightedTextColor:GankMainColor];
        titleLabel.text = self.childViewControllers[i].title;
        CGFloat labelX = i * labelW;
        titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.userInteractionEnabled = YES;
        
        // 手势
        [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)]];
        [self.titleScrollView addSubview:titleLabel];
        
        // 设置默认为第一个按钮
        if (i == 0) {
            titleLabel.highlighted = YES;
            _currentSelectLabel = titleLabel;
            titleLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    //标签的Indicator
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = GankMainColor;
    indicatorView.height = 2;
    indicatorView.y = labelH - indicatorView.height;
    self.indicatorView = indicatorView;
    //让按钮内部的lable的字计算尺寸
    self.indicatorView.width = 60;
    self.indicatorView.centerX = self.titleScrollView.subviews[0].centerX;
    [self.topView addSubview:self.indicatorView];
    
    
    self.titleScrollView.contentSize = CGSizeMake(self.childViewControllers.count * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * JHScreenWidth, 0);
}

-(void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    NSInteger index = recognizer.view.tag;
    CGPoint contentOffset;
    contentOffset.x = index * self.contentScrollView.width;
    [self.contentScrollView setContentOffset:contentOffset animated:YES];
    NSLog(@"--- %.1f",contentOffset.x);
}


/**
 * 初始化控制器
 */
-(void)setupChildViewController
{
    /**
     *  福利 | Android | iOS | 休息视频 | 拓展资源 | 前端 | all
     */
    JHGankBaseController *vc1 = [[JHGankBaseController alloc] init];
    vc1.gankDataType = @"Android";
    [self setupChildViewController:vc1 title:@"android"];
    
    JHGankBaseController *vc2 = [[JHGankBaseController alloc] init];
    vc2.gankDataType = @"iOS";
    [self setupChildViewController:vc2 title:@"iOS"];
    
    JHGankBaseController *vc3 = [[JHGankBaseController alloc] init];
    vc3.gankDataType = @"休息视频";
    [self setupChildViewController:vc3 title:@"视频"];
    
    JHGankBaseController *vc4 = [[JHGankBaseController alloc] init];
    vc4.gankDataType = @"拓展资源";
    [self setupChildViewController:vc4 title:@"拓展"];
    
    JHGankBaseController *vc5 = [[JHGankBaseController alloc] init];
    vc5.gankDataType = @"前端";
    [self setupChildViewController:vc5 title:@"前端"];
    
}
-(void)setupChildViewController:(UIViewController *)vc title:(NSString *)title
{
    vc.title = title;
    [self addChildViewController:vc];
}


/**
 * 初始化导航栏
 */
-(void)setupNav
{
    self.navigationItem.title = @"干货";
}

#pragma mark - UIScrollViewDelegate

#pragma mark 人为滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating--");
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

    NSLog(@"scrollViewDidEndScrollingAnimation---");
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    
    //控制器的索引
    NSInteger index = scrollView.contentOffset.x / JHScreenWidth;
//
//    //控制标题
    UILabel *titleLable = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    NSLog(@"---%@",NSStringFromCGPoint(titleOffset));
    titleOffset.x = titleLable.center.x - width * 0.5;
    if(titleOffset.x <= 0){
        titleOffset.x = 0 ;
    }
    if(titleOffset.x >= self.titleScrollView.contentSize.width - width){
        titleOffset.x = self.titleScrollView.contentSize.width - width ;
    }
    [self.titleScrollView setContentOffset:titleOffset];
    
    //指示器的移动
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = titleLable.centerX - titleOffset.x;
        
    }];
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = titleLable.centerX;
    }];
    
    //设置标题
    _currentSelectLabel.font = [UIFont systemFontOfSize:14];
    _currentSelectLabel.highlighted = NO;
    _currentSelectLabel = titleLable;
    _currentSelectLabel.highlighted = YES;
    _currentSelectLabel.font = [UIFont systemFontOfSize:16];
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    
    
    // 当前控制器已经显示过了
    if ([vc isViewLoaded]) {
        NSLog(@"当前控制器已经显示过了---");
        return;
        
    }
    
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    
    [scrollView addSubview:vc.view];
}
@end
