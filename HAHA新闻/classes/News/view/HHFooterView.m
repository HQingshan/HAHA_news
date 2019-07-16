//
//  HHFooterView.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/19.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHFooterView.h"

@implementation HHFooterView


+ (HHFooterView *)refreshFooterView
{
    HHFooterView *refreshFooterView = [[self alloc] init];
    
    refreshFooterView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 35);
    
    return refreshFooterView;
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
    label.text = @"正在加载更多数据";
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
