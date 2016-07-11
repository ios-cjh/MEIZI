//
//  JHWebViewController.m
//  妹子
//
//  Created by cjj on 16/7/11.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHWebViewController.h"

@interface JHWebViewController ()

@end

@implementation JHWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化导航栏
    [self setupNav];

}
/**
 * 初始化导航栏
 */
-(void)setupNav
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"gank_more_vert" highImage:@"gank_more_vert" target:self action:@selector(rightClick)];
}

-(void)rightClick
{
    NSLog(@"rightClick---");
}

@end
