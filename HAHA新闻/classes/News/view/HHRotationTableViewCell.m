//
//  HHRotationTableViewCell.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/6/4.
//  Copyright © 2019 你好帅！. All rights reserved.
//
#import "HHNewsModel.h"
#import "HHRotationTableViewCell.h"


@interface HHRotationTableViewCell()<UIScrollViewDelegate>

@property (nonatomic, retain)NSTimer* rotateTimer;  //让视图自动切换
@property (nonatomic, retain)UIPageControl *myPageControl;
@property (nonatomic, retain)UIScrollView *rotateScrollView;
@property (nonatomic, strong) NSArray *getLabelArrayFromSubviews;

@end

@implementation HHRotationTableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        CGFloat ViewH =[UIScreen mainScreen].bounds.size.width*0.618;
        CGFloat ViewW =[UIScreen mainScreen].bounds.size.width;
        //初始化scrollView 大小为屏幕大小
        UIScrollView *rotateScrollView = [[UIScrollView alloc] init];
        rotateScrollView.frame = CGRectMake(0, 0,ViewW  , ViewH);
        //设置滚动范围
        rotateScrollView.contentSize = CGSizeMake(ViewW *5, ViewH);
        //设置分页效果
        rotateScrollView.pagingEnabled = YES;
        //水平滚动条隐藏
        rotateScrollView.showsHorizontalScrollIndicator = NO;
        self.rotateScrollView =rotateScrollView;
        //添加三个子视图  UILabel类型
        for (int i = 0; i< 5; i++) {
            
            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewW*i, 0, ViewW, ViewH)];
            subLabel.tag = 1000+i;
            [subLabel setFont:[UIFont systemFontOfSize:19]];
            subLabel.numberOfLines = 0;
            subLabel.userInteractionEnabled=YES;
            UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
            [subLabel addGestureRecognizer:labelTapGestureRecognizer];
            
            [rotateScrollView addSubview:subLabel];
        }
        
        UILabel *tempLabel = [rotateScrollView viewWithTag:1000];
        //为滚动视图的右边添加一个视图，使得它和第一个视图一模一样。
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ViewW*5, 0, ViewW, ViewH)];
        label.tag = 100;
        label.font = tempLabel.font;
        label.adjustsFontSizeToFitWidth = YES;
        [rotateScrollView addSubview:label];
        
        
        [self.contentView addSubview:rotateScrollView];
        
        
        self.myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, ViewH-50, ViewW, 50)];
        self.myPageControl.numberOfPages = 5;
        self.myPageControl.currentPage = 0;
        [self.contentView addSubview:self.myPageControl];
        
        //启动定时器
        self.rotateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
        //为滚动视图指定代理
        self.rotateScrollView.delegate = self;
        
        
        
    }
    
    
    return self;
    
    
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
}

#pragma mark -- 滚动视图的代理方法
//开始拖拽的代理方法，在此方法中暂停定时器。
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //setFireDate：设置定时器在什么时间启动
    //[NSDate distantFuture]:将来的某一时刻
    [self.rotateTimer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat ViewW =[UIScreen mainScreen].bounds.size.width;

    if (decelerate == NO) {
        int i = self.rotateScrollView.contentOffset.x / ViewW ;
        if (i != self.myPageControl.currentPage) {
            //            NSLog(@"----加载%i页----",i);
            self.myPageControl.currentPage = i;
            
        }
        

    }
    
    
}

//视图静止时（没有人在拖拽），开启定时器，让自动轮播
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat ViewW =[UIScreen mainScreen].bounds.size.width;

    int i = self.rotateScrollView.contentOffset.x / ViewW ;
    if (i != self.myPageControl.currentPage) {
        self.myPageControl.currentPage = i;
        
    }

    

    //视图静止之后，过1.5秒在开启定时器

    [self.rotateTimer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
}



//定时器的回调方法   切换界面
- (void)changeView{

    CGFloat ViewW =[UIScreen mainScreen].bounds.size.width;

    
    //通过改变contentOffset来切换滚动视图的子界面
    float offset_X = self.rotateScrollView.contentOffset.x;
    //每次切换一个屏幕
    offset_X += ViewW;
    
    //说明要从最右边的多余视图开始滚动了，最右边的多余视图实际上就是第一个视图。所以偏移量需要更改为第一个视图的偏移量。
    if (offset_X > ViewW*5) {
        self.rotateScrollView.contentOffset = CGPointMake(0, 0);
        
    }
    //说明正在显示的就是最右边的多余视图，最右边的多余视图实际上就是第一个视图。所以pageControl的小白点需要在第一个视图的位置。
    if (offset_X == ViewW*5) {
        self.myPageControl.currentPage = 0;
    }else{
        self.myPageControl.currentPage = offset_X/ViewW;
    }
    
    //得到最终的偏移量
    CGPoint resultPoint = CGPointMake(offset_X, 0);
    //切换视图时带动画效果
    //最右边的多余视图实际上就是第一个视图，现在是要从第一个视图向第二个视图偏移，所以偏移量为一个屏幕宽度
    if (offset_X >ViewW*5) {
        self.myPageControl.currentPage = 1;
        [self.rotateScrollView setContentOffset:CGPointMake(ViewW, 0) animated:YES];
    }else{
        [self.rotateScrollView setContentOffset:resultPoint animated:YES];
    }
    
}
    
- (NSArray *)getLabelArrayFromSubviews
{
    
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (UILabel *label in _rotateScrollView.subviews) {
        if ([ label isKindOfClass:[UILabel class]]) {
            [arrayM addObject:label ];
        }
    }
    return arrayM.copy;
    
}

- (void)setNews:(NSMutableArray *)news{

    for (int i = 0; i< 5; i++) {
        
        for (UILabel *label in [self getLabelArrayFromSubviews]) {

            if ((1000+i) == label.tag) {
                NSString *title = [news[i][@"title"] stringByReplacingOccurrencesOfString:@"&quot;"withString:@"\""];
                label.text = title ;
                label.text = [NSString stringWithFormat:@"\n\n\n\n\n\n\n\n %@",label.text];
                
            }
            if (i == 0 && 100 == label.tag) {
                NSString *title = [news[i][@"title"] stringByReplacingOccurrencesOfString:@"&quot;"withString:@"\""];
                label.text = title ;
                label.text = [NSString stringWithFormat:@"\n\n\n\n\n\n\n\n %@",label.text];
            }
        }
        
    }
    
    
    
    _news = news;
    
}

-(void)setImages:(NSMutableDictionary *)images{

    for (int i =0; i<5; i++) {
        HHNewsModel *new = [HHNewsModel newsWithDict:self.news[i]];
        NSURL *url = [NSURL URLWithString:new.imageUrls[0]];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        
        for (UILabel *label in [self getLabelArrayFromSubviews]) {
            
            if ((1000+i) == label.tag) {
                
             [label setBackgroundColor:[UIColor colorWithPatternImage: image ]];
                
            }
            if (i == 0 && 100 == label.tag) {
             [label setBackgroundColor:[UIColor colorWithPatternImage: image ]];
            }
        }

        
    }
    
    
    
    
    
}


-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADD" object: self.news[label.tag-1000] ];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Web" object: self.news[label.tag-1000] ];
    
}

@end
