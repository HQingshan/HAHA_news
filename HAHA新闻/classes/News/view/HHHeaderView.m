//
//  HHHeaderView.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/25.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHHeaderView.h"

@implementation HHHeaderView


+ (HHHeaderView *)refreshHeaderView
{
    HHHeaderView *refreshHeaderView = [[self alloc] init];
    
    refreshHeaderView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 35);
    
    return refreshHeaderView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.opaque = YES;
    }
    
    return self;
}

#pragma mark - 设置子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /* 提示文字 */
    UILabel *label = [[UILabel alloc] init];
    
    // 位置位置和尺寸
    label.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width ,35);
    // 设置文字样式
    label.text = @"正在刷新数据";
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 获取文字宽度
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = label.font;
    CGFloat textWidth = [label.text sizeWithAttributes:attr].width;
    
    [self addSubview:label];
    
    /* 菊花 */
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activity.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width + textWidth) * 0.5, 0,35, 35);
    [activity startAnimating];
    
    [self addSubview:activity];
}
@end
