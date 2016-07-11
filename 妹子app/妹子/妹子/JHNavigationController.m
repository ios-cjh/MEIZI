//
//  JHNavigationController.m
//  妹子
//
//  Created by cjj on 16/6/28.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHNavigationController.h"

@interface JHNavigationController ()

@end

@implementation JHNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

/**
 * 只初始化一次
 */
+(void)initialize
{
    // 设置文字颜色
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.0 green:187 / 255.0 blue:156 / 255.0 alpha:1.0];
    [[UINavigationBar appearance] setTitleTextAttributes:attr];
    
    // 设置背景图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count > 0){
        //添加返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:GankMainColor forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor colorWithRed:0.000 green:0.613 blue:0.515 alpha:1.000] forState:UIControlStateHighlighted];
        [backBtn setImage:[UIImage imageNamed:@"comment_back"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"comment_back"] forState:UIControlStateHighlighted];
        
        backBtn.size = CGSizeMake(100, 30);
        //按钮内容做对齐
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //按钮大小随内容
        //[backBtn sizeToFit];
        //设置内边距:返回键距离左边更近
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //监听事件
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        
        //隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
    NSLog(@"返回");
}
@end
