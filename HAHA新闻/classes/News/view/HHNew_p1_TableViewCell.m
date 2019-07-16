//
//  HHNew_p1_TableViewCell.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/14.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHNew_p1_TableViewCell.h"
#import "HHNewsModel.h"


@interface HHNew_p1_TableViewCell()
/*    新闻标题   */
@property(nonatomic,weak) UILabel  *titleLabel;

/*    新闻发布者   */
@property(nonatomic,weak) UILabel  *posterScreenNameLabel;

/*    新闻发布时间   */
@property(nonatomic,weak) UILabel  *publishDateStrLabel;

/*    图片          */
@property(nonatomic,weak) UIImageView  *HHImageView;



@end


@implementation HHNew_p1_TableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView  *HHImageView = [[UIImageView alloc] init];
        HHImageView.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView];
        self.HHImageView = HHImageView;
        
        UILabel  *titleLabel =  [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:16 ];
        titleLabel.textAlignment = NSTextAlignmentJustified;
//        titleLabel.textColor = [UIColor redColor];
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
    
    CGFloat   HHh  = contentViewH-10*3;
    CGFloat   HHw  = HHh/0.618;
    CGFloat   HHx  = contentViewW-7-HHw;
    CGFloat   HHy  = 15;
    
    self.HHImageView.frame = CGRectMake(HHx, HHy, HHw, HHh);
    
    CGFloat   TTx  = 10;
    CGFloat   TTy  = 5 ;
    CGFloat   TTw  = contentViewW-10*3-HHw;
    CGFloat   TTh  = contentViewH-10*2-5;
    self.titleLabel.frame = CGRectMake(TTx, TTy, TTw, TTh);
    
    CGFloat   PSx  = 10;
    CGFloat   PSy  = contentViewH-10*2;
    CGFloat   PSw  = (contentViewW-HHw)/2.0-30;
    CGFloat   PSh  = 10;
    self.posterScreenNameLabel.frame = CGRectMake(PSx, PSy, PSw, PSh);
    
    CGFloat   PNw  = (contentViewW-HHw)/2.0+10;
    CGFloat   PNh  = 10;
    CGFloat   PNx  = (contentViewW-HHw-10)/2.0-30;
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



-(void)setHHUIImage:(UIImage *)HHUIImage
{
    
    self.HHImageView.image = HHUIImage;
    
}


@end
