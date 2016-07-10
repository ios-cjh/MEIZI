//
//  JHNetworkTool.m
//  妹子
//
//  Created by cjj on 16/7/2.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHNetworkTool.h"
#import "Reachability.h"

@implementation JHNetworkTool

/**
 * 判断有无网络
 */
+ (BOOL) isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *ablity = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch (ablity.currentReachabilityStatus) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            
        default:
            break;
    }
    return isExistenceNetwork;
}


/**
 * 是否显示网络指示器状态
 */
+(void)showNetWorkActivityIndicator:(BOOL)flag
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:flag];
}

@end

