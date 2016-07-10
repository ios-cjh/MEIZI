//
//  JHGirlCell.m
//  妹子
//
//  Created by cjj on 16/6/29.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHGirlCell.h"
#import "UIImageView+WebCache.h"
#import "JHGank.h"
#import "UIView+Additions.h"

@interface JHGirlCell()

@property (weak, nonatomic) IBOutlet UIImageView *girlImageView;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation JHGirlCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setGank:(JHGank *)gank
{
    _gank = gank;
    _timeLabel.text = [gank.publishedAt componentsSeparatedByString:@"T"][0];
    

    [self.girlImageView sd_setImageWithURL:[NSURL URLWithString:gank.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(_girlImageView.size, YES, 0.0);
        
        // 将下载的图片下载到绘制的图形上下文中
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 获取图片
        UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
        self.girlImageView.image = currentImage;
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
    } ];

//    [self.girlImageView setImage:[UIImage imageNamed:@"02.png"]];
}


@end
