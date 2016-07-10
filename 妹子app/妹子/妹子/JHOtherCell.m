//
//  JHOtherCell.m
//  妹子
//
//  Created by cjj on 16/7/3.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHOtherCell.h"

@implementation JHOtherCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    JHOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHOtherCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
                
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

@end
