//
//  HHNew_p3_TableViewCell.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/14.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHNew_p3_TableViewCell.h"
#import "HHNewsModel.h"

@interface HHNew_p3_TableViewCell()
/*    新闻标题   */
@property(nonatomic,weak) UILabel  *titleLabel;

/*    新闻发布者   */
@property(nonatomic,weak) UILabel  *posterScreenNameLabel;

/*    新闻发布时间   */
@property(nonatomic,weak) UILabel  *publishDateStrLabel;

/*    图片          */
@property(nonatomic,weak) UIImageView  *HHImageView1;
@property(nonatomic,weak) UIImageView  *HHImageView2;
@property(nonatomic,weak) UIImageView  *HHImageView3;

@end


@implementation HHNew_p3_TableViewCell



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
        
        UIImageView  *HHImageView1 = [[UIImageView alloc] init];
        HHImageView1.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView1];
        self.HHImageView1 = HHImageView1;
        
        UIImageView  *HHImageView2 = [[UIImageView alloc] init];
        HHImageView2.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView2];
        self.HHImageView2 = HHImageView2;
        
        UIImageView  *HHImageView3 = [[UIImageView alloc] init];
        HHImageView3.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView3];
        self.HHImageView3 = HHImageView3;
        
    }
    
    
    return self;
    
    
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    CGFloat contentViewH =self.contentView.frame.size.height;
    CGFloat contentViewW =self.contentView.frame.size.width;
    CGFloat HHw = (self.contentView.frame.size.width -40) / 3;
    CGFloat HHh = HHw*0.618;
    
    CGFloat   TTx  = 10;
    CGFloat   TTy  = 10;
    CGFloat   TTw  = contentViewW-10*3;
    CGFloat   TTh  = 43;
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
    
    


    CGFloat   HH1x  = 15;
    CGFloat   HHy  = 43+10;
    self.HHImageView1.frame = CGRectMake(HH1x, HHy, HHw, HHh);
    

    CGFloat   HH2x  = HH1x+5+HHw;
    self.HHImageView2.frame = CGRectMake(HH2x, HHy, HHw, HHh);
    

    CGFloat   HH3x  = HH2x+5+HHw;
    self.HHImageView3.frame = CGRectMake(HH3x, HHy, HHw, HHh);
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

-(void)setHHUIImage1:(UIImage *)HHUIImage1
{
    
    self.HHImageView1.image = HHUIImage1;
    
}
-(void)setHHUIImage2:(UIImage *)HHUIImage2
{
    
    self.HHImageView2.image = HHUIImage2;
    
}
-(void)setHHUIImage3:(UIImage *)HHUIImage3
{
    
    self.HHImageView3.image = HHUIImage3;
    
}


@end
