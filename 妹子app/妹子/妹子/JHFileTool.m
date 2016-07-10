//
//  JHFileTool.m
//  妹子
//
//  Created by cjj on 16/7/3.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHFileTool.h"
#import "SDImageCache.h"

@implementation JHFileTool

/**
 *  获取Document文件的路径
 *
 *  @param fileName 文件名字
 *
 *  @return 文件的路径
 */
+(NSString *)getDocumentPath:(NSString *)fileName
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [doc stringByAppendingPathComponent:fileName];
    return filePath;
}

//获得缓存大小
+(NSString *)getCacheSizeStr
{
    CGFloat cacheSize =[[SDImageCache sharedImageCache]getSize ] / 1024 / 1024;
    NSString *clearCacheSizeStr;
    if (cacheSize >= 1) {
        clearCacheSizeStr = [NSString stringWithFormat:@"%.1fM",cacheSize];
    } else {
        clearCacheSizeStr = [NSString stringWithFormat:@"%.1fK",cacheSize * 1024];
//        if ([clearCacheSizeStr isEqualToString:@"0.0K"]) {
//            clearCacheSizeStr = @"";
//        }

    }
    return clearCacheSizeStr;
}





+(void)saveImageToLocal:(UIImage *)image imageName:(NSString *)imageName
{
    //设置一个图片的存储路径
    NSString *imagePath = [JHFileTool getDocumentPath:imageName];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
}

+(UIImage *)getImageFromLocalImageName:(NSString *)imageName
{
    NSString *filePath = [JHFileTool getDocumentPath:imageName];
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
}
@end
