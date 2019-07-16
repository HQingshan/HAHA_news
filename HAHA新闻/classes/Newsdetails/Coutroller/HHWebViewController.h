//
//  HHWebViewController.h
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/18.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import <UIKit/UIKit.h>



@class HHNewsModel;



@interface HHWebViewController : UIViewController

/*  新闻模型  */
@property (nonatomic,strong)  HHNewsModel *news;
/*  新闻字典  */
@property (nonatomic,strong)  NSDictionary *newdict;

@end

