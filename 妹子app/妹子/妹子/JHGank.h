//
//  JHGank.h
//  妹子
//
//  Created by cjj on 16/6/29.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHGank : NSObject
/**
 *  id
 */
@property (nonatomic, copy) NSString *_id;
/**
 *  资源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  谁发布的
 */
@property (nonatomic, copy) NSString *who;

/**
 *  发布时间
 */
@property (nonatomic, copy) NSString *publishedAt;
/**
 *  used;
 */
@property (nonatomic, assign) BOOL used;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *createdAt;
/**
 *  类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  地址Url
 */
@property (nonatomic, copy) NSString *url;

@end
