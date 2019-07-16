//
//  HHNew_p0_TableViewCell.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/14.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHNew_p0_TableViewCell.h"
#import "HHNewsModel.h"

@interface HHNew_p0_TableViewCell()
/*    新闻标题   */
@property(nonatomic,weak) UILabel  *titleLabel;

/*    新闻发布者   */
@property(nonatomic,weak) UILabel  *posterScreenNameLabel;

/*    新闻发布时间   */
@property(nonatomic,weak) UILabel  *publishDateStrLabel;


@end


@implementation HHNew_p0_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel  *titleLabel =  [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:17 ];
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview: titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel  *posterScreenNameLabel = [[UILabel alloc] init];
//        posterScreenNameLabel.textAlignment = NSTextAlignmentRight;
        posterScreenNameLabel.textColor = [UIColor darkGrayColor];
        posterScreenNameLabel.font = [UIFont systemFontOfSize:12 ];
        [self.contentView addSubview: posterScreenNameLabel];
        self.posterScreenNameLabel = posterScreenNameLabel;
        
        
        UILabel  *publishDateStrLabel = [[UILabel alloc] init];
        publishDateStrLabel.textAlignment = NSTextAlignmentRight;
        publishDateStrLabel.textColor = [UIColor darkGrayColor];
        publishDateStrLabel.font = [UIFont systemFontOfSize:12 ];
        [self.contentView addSubview: publishDateStrLabel];
        self.publishDateStrLabel = publishDateStrLabel;
        
        
    }
    
    
    return self;
    
    
}

- (void)layoutSubviews
{

    [super layoutSubviews];
    
    CGFloat contentViewH =self.contentView.frame.size.height;
    CGFloat contentViewW =self.contentView.frame.size.width;

    
    CGFloat   TTx  = 10;
    CGFloat   TTy  = 5;
    CGFloat   TTw  = contentViewW-10*3;
    CGFloat   TTh  = contentViewH-10*2-5;
    self.titleLabel.frame = CGRectMake(TTx, TTy, TTw, TTh);
    
    CGFloat   PSx  = 10;
    CGFloat   PSy  = contentViewH-10*2;
    CGFloat   PSw  = contentViewW/2.0;
    CGFloat   PSh  = 10;
    self.posterScreenNameLabel.frame = CGRectMake(PSx, PSy, PSw, PSh);
    
    CGFloat   PNw  = contentViewW/2.0-10;
    CGFloat   PNh  = 10;
    CGFloat   PNx  = contentViewW/2.0;
    CGFloat   PNy  = contentViewH-10*2;
    self.publishDateStrLabel.frame = CGRectMake(PNx, PNy, PNw, PNh);
}


-(void)setNews:(HHNewsModel *)news
{
    _news = news;
    
    NSString *title = [news.title stringByReplacingOccurrencesOfString:@"&quot;"withString:@"\""];
//    NSLog(@"******---%@--******",title);
    
    self.titleLabel.text = title;
    self.posterScreenNameLabel.text = news.posterScreenName;
    NSString *publishDateStr=[news.publishDateStr stringByReplacingOccurrencesOfString:@"T"withString:@" "];
    self.publishDateStrLabel.text = publishDateStr;
    
}




@end
