//
//  HHNewdetailTableViewCell.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/21.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHNewdetailTableViewCell.h"
#import "HHNewsModel.h"

@interface HHNewdetailTableViewCell()
/*    新闻标题   */
@property(nonatomic,weak) UILabel  *title_Label;

/*    新闻发布者   */
@property(nonatomic,weak) UILabel  *content_Label;

/*    新闻发布时间   */
@property(nonatomic,weak) UILabel  *publishDateStrLabel;

/*    图片          */
@property(nonatomic,weak) UIImageView  *HHImageView1;
@property(nonatomic,weak) UIImageView  *HHImageView2;
@property(nonatomic,weak) UIImageView  *HHImageView3;
@property(nonatomic,weak) UIImageView  *HHImageView4;
@property(nonatomic,weak) UIImageView  *HHImageView5;
@property(nonatomic,weak) UIImageView  *HHImageView6;
@property(nonatomic,weak) UIImageView  *HHImageView7;
@property(nonatomic,weak) UIImageView  *HHImageView8;
@property(nonatomic,weak) UIImageView  *HHImageView9;


/*  其他图片。 */
@property (nonatomic,strong) NSMutableArray  *Oimageviews;



@end


@implementation HHNewdetailTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel  *content_Label =  [[UILabel alloc] init];
        content_Label.font = [UIFont systemFontOfSize:15 ];
        content_Label.textAlignment = NSTextAlignmentJustified;
        content_Label.numberOfLines = 0;
        [self.contentView addSubview: content_Label];
        self.content_Label = content_Label;
        
        UIImageView  *HHImageView1 = [[UIImageView alloc] init];
        HHImageView1.contentMode =  UIViewContentModeScaleAspectFit ;
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
        
        UIImageView  *HHImageView4 = [[UIImageView alloc] init];
        HHImageView4.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView4];
        self.HHImageView4 = HHImageView4;
        
        UIImageView  *HHImageView5 = [[UIImageView alloc] init];
        HHImageView5.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView5];
        self.HHImageView5 = HHImageView5;
        
        UIImageView  *HHImageView6 = [[UIImageView alloc] init];
        HHImageView6.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView6];
        self.HHImageView6 = HHImageView6;
        
        UIImageView  *HHImageView7 = [[UIImageView alloc] init];
        HHImageView7.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView7];
        self.HHImageView7 = HHImageView7;
        
        UIImageView  *HHImageView8 = [[UIImageView alloc] init];
        HHImageView8.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView8];
        self.HHImageView8 = HHImageView8;
        
        UIImageView  *HHImageView9 = [[UIImageView alloc] init];
        HHImageView9.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView9];
        self.HHImageView9 = HHImageView9;
        
        

        
    }
    
    
    return self;
    
    
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    CGFloat   CellW =self.contentView.frame.size.width;
    CGFloat   space = 10;
    
    CGFloat   Image_1x  = 0;
    CGFloat   Image_1y  = space;
    CGFloat   Image_1w  = CellW;
    CGFloat   Image_1h  = CellW*0.618;
    if (self.news.imageUrls) {
        self.HHImageView1.frame = CGRectMake(Image_1x, Image_1y, Image_1w, Image_1h);
    }else{
        self.HHImageView1.frame = CGRectMake(0, 0, 0, 0);
    }

    CGFloat contentX = space;
    CGFloat contentY = CGRectGetMaxY(self.HHImageView1.frame)  + space;
    CGFloat contentW = CellW -2.0*space;
    // 文本高度
    NSDictionary *teatAtt = @{NSFontAttributeName : [UIFont systemFontOfSize:15 ]};
    CGSize textSize = CGSizeMake(contentW, MAXFLOAT);
    CGFloat textH = [self.news.content boundingRectWithSize:textSize options: NSStringDrawingUsesLineFragmentOrigin attributes: teatAtt context:nil].size.height;
    CGFloat contentH = textH ;
    self.content_Label.frame =CGRectMake(contentX, contentY, contentW, contentH);
    
    
    
    if (self.news.imageUrls.count >= 2) {
        CGFloat   Image_2y  = CGRectGetMaxY(self.content_Label.frame)  + space + 0 * (CellW*0.618 +space);
        self.HHImageView2.frame = CGRectMake(Image_1x, Image_2y, Image_1w, Image_1h);
    }

    if (self.news.imageUrls.count >= 3) {
        CGFloat   Image_3y  = CGRectGetMaxY(self.content_Label.frame)  + space + 1 * (CellW*0.618 +space);
        self.HHImageView3.frame = CGRectMake(Image_1x, Image_3y, Image_1w, Image_1h);
    }
    
    if (self.news.imageUrls.count >= 4) {
        CGFloat   Image_4y  = CGRectGetMaxY(self.content_Label.frame)  + space + 2 * (CellW*0.618 +space);
        self.HHImageView4.frame = CGRectMake(Image_1x, Image_4y, Image_1w, Image_1h);
    }
    
    if (self.news.imageUrls.count >= 5) {
        CGFloat   Image_5y  = CGRectGetMaxY(self.content_Label.frame)  + space + 3 * (CellW*0.618 +space);
        self.HHImageView5.frame = CGRectMake(Image_1x, Image_5y, Image_1w, Image_1h);
    }
    
    if (self.news.imageUrls.count >= 6) {
        CGFloat   Image_6y  = CGRectGetMaxY(self.content_Label.frame)  + space + 4 * (CellW*0.618 +space);
        self.HHImageView6.frame = CGRectMake(Image_1x, Image_6y, Image_1w, Image_1h);
    }
    
    if (self.news.imageUrls.count >= 7) {
        CGFloat   Image_7y  = CGRectGetMaxY(self.content_Label.frame)  + space + 5 * (CellW*0.618 +space);
        self.HHImageView7.frame = CGRectMake(Image_1x, Image_7y, Image_1w, Image_1h);
    }
    
    
    if (self.news.imageUrls.count >= 8) {
        CGFloat   Image_8y  = CGRectGetMaxY(self.content_Label.frame)  + space + 6 * (CellW*0.618 +space);
        self.HHImageView8.frame = CGRectMake(Image_1x, Image_8y, Image_1w, Image_1h);
    }
    
    if (self.news.imageUrls.count >= 9) {
        CGFloat   Image_9y  = CGRectGetMaxY(self.content_Label.frame)  + space + 7 * (CellW*0.618 +space);
        self.HHImageView9.frame = CGRectMake(Image_1x, Image_9y, Image_1w, Image_1h);
    }
    
    
}


-(void)setNews:(HHNewsModel *)news
{
    _news = news;
    NSString *title = [news.title stringByReplacingOccurrencesOfString:@"&quot;"withString:@"\""];
    self.title_Label.text = title;
    
    NSString *content = [news.content stringByReplacingOccurrencesOfString:@"&quot;"withString:@"\""];
    self.content_Label.text = content;
    
    
    
    
}



-(void)setImage_1:(UIImage *)image_1
{
    self.HHImageView1.image = image_1;
    
}

-(void)setOtherimages:(NSMutableDictionary *)otherimages{

    NSLog(@"=====%zd=====",otherimages.count);
    
    for (int i=1; i<self.news.imageUrls.count; i++) {
        UIImage *image = [otherimages objectForKey: self.news.imageUrls[i] ];
        
    if (image == nil) {
       image =[UIImage imageNamed: @"jiazai" ];
    }
        
        if (i == 1) {
            self.HHImageView2.image =image ;
        }
        if (i == 2) {
            self.HHImageView3.image =image ;
        }
        if (i == 3) {
            self.HHImageView4.image =image ;
        }
        if (i == 4) {
            self.HHImageView5.image =image ;
        }
        if (i == 5) {
            self.HHImageView6.image =image ;
        }
        if (i == 6) {
            self.HHImageView7.image =image ;
        }
        if (i == 7) {
            self.HHImageView8.image =image ;
        }
        if (i == 8) {
            self.HHImageView9.image =image ;
        }
        
        
        
        
    }


}


@end
