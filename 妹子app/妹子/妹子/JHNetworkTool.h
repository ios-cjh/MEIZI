//
//  JHNetworkTool.h
//  妹子
//
//  Created by cjj on 16/7/2.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHNetworkTool : NSObject

/**
 * 判断有无网络
 */ 
+ (BOOL)isExistenceNetwork;


/**
 * 是否显示网络指示器状态
 */
+(void)showNetWorkActivityIndicator:(BOOL)flag;

@end
