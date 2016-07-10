//
//  JHStatusBarViewController.h
//  妹子
//
//  Created by cjj on 16/7/3.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHStatusBarViewController : UIViewController

/**
 * 获取单例
 */
+(instancetype)shareInstance;
/**
 * 状态栏的样式
 */
@property(nonatomic, assign)UIStatusBarStyle statusBarStyle;
/**
 * 是否隐藏
 */
@property(nonatomic, assign) BOOL statusBarHidden;

@end
