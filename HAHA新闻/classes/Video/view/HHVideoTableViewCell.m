//
//  HHVideoTableViewCell.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/22.
//  Copyright © 2019 你好帅！. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "HHVideoTableViewCell.h"

#import "HHVideoModel.h"
@interface HHVideoTableViewCell()

/*   视频标题   */
@property(nonatomic,weak) UILabel  *title_Label;

/*    视频发布者   */
@property(nonatomic,weak) UILabel  *posterScreenNameLabel;

/*    图片          */
@property(nonatomic,weak) UIView  *HHvideoView;

/*    头像          */
@property(nonatomic,weak) UIImageView  *HHtouxiangView;

@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property (nonatomic,strong)AVPlayerItem *currentPlayerItem;
@property (nonatomic,strong)UIButton *playBtn;

@end


@implementation HHVideoTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView  *HHImageView = [[UIView alloc] init];
//        HHImageView.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHImageView];
        self.HHvideoView = HHImageView;
        
        UILabel  *titleLabel =  [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:16 ];
        titleLabel.textAlignment = NSTextAlignmentJustified;
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview: titleLabel];
        self.title_Label = titleLabel;
        
        
        UILabel  *posterScreenNameLabel = [[UILabel alloc] init];
        posterScreenNameLabel.textColor = [UIColor darkGrayColor];
        posterScreenNameLabel.font = [UIFont systemFontOfSize:14 ];
        [self.contentView addSubview: posterScreenNameLabel];
        self.posterScreenNameLabel = posterScreenNameLabel;
        
        UIImageView  *HHtouxiangView = [[UIImageView alloc] init];
        HHtouxiangView.contentMode = UIViewContentModeScaleToFill ;
        [self.contentView addSubview: HHtouxiangView];
        self.HHtouxiangView = HHtouxiangView;
        
        
        
        
    }
    
    
    return self;
    
    
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    CGFloat contentViewW =self.contentView.frame.size.width;
    
    CGFloat   TXwh  = 32;
    CGFloat   TXx  = 10;
    CGFloat   TXy  = 5;
    self.HHtouxiangView.frame = CGRectMake(TXx, TXy, TXwh, TXwh);
    
    CGFloat   PSx  = CGRectGetMaxX(self.HHtouxiangView.frame);
    CGFloat   PSy  = 5;
    CGFloat   PSw  = contentViewW-50;
    CGFloat   PSh  = 32;
    self.posterScreenNameLabel.frame = CGRectMake(PSx, PSy, PSw, PSh);

    
    CGFloat   TTx  = 10;
    CGFloat   TTy  = CGRectGetMaxY(self.HHtouxiangView.frame) ;
    CGFloat   TTw  = contentViewW-20;
    CGFloat   TTh  = 30;
    self.title_Label.frame = CGRectMake(TTx, TTy, TTw, TTh);
    
    CGFloat   HHw  = contentViewW;
    CGFloat   HHh  = contentViewW*0.618;
    CGFloat   HHx  = 0;
    CGFloat   HHy  = CGRectGetMaxY(self.title_Label.frame) ;;
    self.HHvideoView.frame = CGRectMake(HHx, HHy, HHw, HHh);
    
    

    
}


-(void)setvideo:(HHVideoModel *)video
{
    _video = video;
    NSString *title = [_video.title stringByReplacingOccurrencesOfString:@"&quot;"withString:@"\""];
//    NSLog(@"******---%@--******",title);
    self.title_Label.text = title;
    self.posterScreenNameLabel.text = video.posterScreenName;
    self.HHtouxiangView.image =[UIImage imageNamed: @"touxiang" ];

}



-(void)setHHUIImage:(UIImage *)HHUIImage
{
    //    NSLog(@"******---%@--******",self.video.title);
    self.title_Label.text = self.video.title;
    self.posterScreenNameLabel.text = self.video.posterScreenName;

    self.HHtouxiangView.image =[UIImage imageNamed: @"touxiang" ];

//    [self.HHvideoView setBackgroundColor:[UIColor colorWithPatternImage:HHUIImage ]];
//    @"https://api.youku.com/videos/player/file?data=WE5ERTVORGd6T0RBMU5nPT18MnwxfDEwMDgxNDd8MAO0O0OO0O0O"

    //网络视频路径
    NSString *webVideoPath = @"https://api.youku.com/videos/player/file?data=WE5ERTVORGd6T0RBMU5nPT18MnwxfDEwMDgxNDd8MAO0O0OO0O0O" ;
    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];

    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:webVideoUrl];
    self.currentPlayerItem = playerItem;
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];

//    NSString* localFilePath=@"/Users/nihaoshuai/Desktop/chengxuyuan.mp4";
//    NSURL *localVideoUrl = [NSURL fileURLWithPath:localFilePath];
//    self.player = [AVPlayer playerWithURL:localVideoUrl];
//    self.player = [[AVPlayer alloc] initWithURL:localVideoUrl];



    AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer: self.player ];
    avLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    avLayer.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.618);
    
    [ _HHvideoView.layer  addSublayer: avLayer ];

    [self.player play];
    
    
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    
     [_HHvideoView addGestureRecognizer:tapGesturRecognizer];
    
    
    [self.player pause];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.backgroundColor = [UIColor clearColor];
    [self.playBtn addTarget:self action:@selector(playBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.playBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2.0-32, [UIScreen mainScreen].bounds.size.width*0.618/2.0 - 32, 64, 64) ;
    [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self.HHvideoView addSubview:_playBtn];
    

}


-(void)tapAction:(id)tap{
    
    
    if (self.player.rate == 1.0) {
        self.playBtn.hidden = NO;
        [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.player pause];
        
    }

//    NSLog(@"点击了tapView");
   
}

- (void)playBtnClicked:(UIButton *)sender{
    if (self.player.rate == 0.0) {
        self.playBtn.hidden = NO;
        [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.HHvideoView setBackgroundColor:[UIColor whiteColor]];
        [self.player play];
        [self.HHvideoView setBackgroundColor:[UIColor whiteColor ]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.playBtn.hidden = YES;});
    }else{
        self.playBtn.hidden = NO;
        [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.player pause];
        
        
        
    }
}

-(void)stop{
    
    self.playBtn.hidden = NO;
    [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self.player pause];
    
}

@end
