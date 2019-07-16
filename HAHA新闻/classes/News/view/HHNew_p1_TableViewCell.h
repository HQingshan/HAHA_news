//
//  HHNew_p1_TableViewCell.h
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/14.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHNewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface HHNew_p1_TableViewCell : UITableViewCell

/*  新闻模型  */
@property (nonatomic,strong)  HHNewsModel *news;

/*  图片。 */
@property (nonatomic,strong)  UIImage  *HHUIImage;

@end

NS_ASSUME_NONNULL_END
