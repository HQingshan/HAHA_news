//
//  HHNewdetailTableViewCell.h
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/21.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHNewsModel;

@interface HHNewdetailTableViewCell : UITableViewCell

/*  新闻模型  */
@property (nonatomic,strong)  HHNewsModel *news;

/*  图片。 */
@property (nonatomic,strong)  UIImage  *image_1;

/*  其他图片。 */
@property (nonatomic,strong)  NSMutableDictionary  *otherimages;

@end

