//
//  JHTabBarController.m
//  妹子
//
//  Created by cjj on 16/6/28.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHTabBarController.h"
#import "JHOtherViewController.h"
#import "JHGirlViewController.h"
#import "JHGankViewController.h"
#import "JHNavigationController.h"

@interface JHTabBarController ()

@end

@implementation JHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置tabbar
    [self setTabbar];
    
    // 2.初始化子控制器
    [self setUpChildVC];
    
}

/**
 * 1.设置tabbar颜色
 */
-(void)setTabbar
{
    UIView *bg = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bg.backgroundColor = [UIColor colorWithWhite:0.950 alpha:0.8];
    [self.tabBar insertSubview:bg atIndex:0];
    self.tabBar.opaque = YES;
}

/**
 *  2.初始化子控制器
 */
-(void)setUpChildVC
{
    JHGirlViewController *vc1 = [[JHGirlViewController alloc] init];
    [self setupChildVc:vc1 imageName:@"tabBar_girls" selectImageName:@"tabBar_girls_selected" title:@"美女"];
    
    JHGankViewController *vc2 = [[JHGankViewController alloc] init];
    [self setupChildVc:vc2 imageName:@"tabBar_gank" selectImageName:@"tabBar_gank_selected" title:@"干货"];
    
    JHOtherViewController *vc3 = [[JHOtherViewController alloc] init];
    [self setupChildVc:vc3 imageName:@"tabBar_setting" selectImageName:@"tabBar_setting_selected" title:@"其他"];
}

-(void)setupChildVc:(UIViewController *)vc imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName title:(NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 创建导航控制器
    JHNavigationController *nav3 = [[JHNavigationController alloc] initWithRootViewController:vc];
    
    // 添加子控制器
    [self addChildViewController:nav3];
}
/**
 * 只会初始化一次
 */
+(void)initialize
{
    UITabBarItem *item = [UITabBarItem appearance];
    
    // 默认
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:169 / 255.0 green:183 / 255.0 blue:183 / 255.0 alpha:1.0];
    
    // 选中
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.0 green:187 / 255.0 blue:156 / 255.0 alpha:1.0];
    
    // 设置tabbar文字属性
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
@end







