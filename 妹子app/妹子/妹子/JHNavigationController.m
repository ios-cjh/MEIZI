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

@end
