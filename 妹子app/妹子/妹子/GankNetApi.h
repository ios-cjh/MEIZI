//
//  GankNetApi.h
//  妹子
//
//  Created by cjj on 16/6/28.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GankNetApi : NSObject
/**
 *  获取Gank数据接口
 *
 *  @param type      数据类型：福利 | Android | iOS | 休息视频 | 拓展资源 | 前端 | all
 *  @param pageSize  请求个数
 *  @param pageIndex 第几页
 */

+(void)getGankDataWithType:(NSString *)type pageSize:(NSUInteger)pageSize pageIndex:(NSInteger)pageIndex success:(void(^)(NSDictionary *dict))success failure:(void(^)(NSString *text))failure;
@end
