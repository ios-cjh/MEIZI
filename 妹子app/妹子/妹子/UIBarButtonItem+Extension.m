//
//  UIBarButtonItem+Extension.m
//  妹子
//
//  Created by cjj on 16/7/11.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] init];
    
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    // 监听点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentImage.size;
    
    return [[self alloc] initWithCustomView:btn];
}
@end
