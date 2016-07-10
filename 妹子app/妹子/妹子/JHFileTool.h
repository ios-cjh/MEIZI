//
//  JHFileTool.h
//  妹子
//
//  Created by cjj on 16/7/3.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHFileTool : NSObject

/**
 *  获取Document文件的路径
 *
 *  @param fileName 文件名字
 *
 *  @return 文件的路径
 */
+(NSString *)getDocumentPath:(NSString *)fileName;
/**
 * 获取缓存大小
 */
+(NSString *)getCacheSizeStr;


// ------------ 保存图片到本地 ---------
+(void)saveImageToLocal:(UIImage *)image imageName:(NSString *)imageName;
+(UIImage *)getImageFromLocalImageName:(NSString *)imageName;


@end
