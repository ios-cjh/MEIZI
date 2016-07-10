//
//  JHGankBaseCell.m
//  妹子
//
//  Created by cjj on 16/7/9.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHGankBaseCell.h"
#import "JHGank.h"

@interface JHGankBaseCell()
/** 标题描述*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 名字*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation JHGankBaseCell

-(void)setGank:(JHGank *)gank
{
    _gank = gank;
    
    self.titleLabel.text = _gank.desc;
    self.nameLabel.text = _gank.who;
    self.timeLabel.text = [_gank.publishedAt componentsSeparatedByString:@"T" ].firstObject;
    
}

@end
