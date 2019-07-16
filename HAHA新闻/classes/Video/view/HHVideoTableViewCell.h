//
//  HHVideoTableViewCell.h
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/22.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHVideoModel;

NS_ASSUME_NONNULL_BEGIN

@interface HHVideoTableViewCell : UITableViewCell

/*  video模型  */
@property (nonatomic,strong)  HHVideoModel *video;

/*  图片。 */
@property (nonatomic,strong)  UIImage  *HHUIImage;

-(void)stop;
@end

NS_ASSUME_NONNULL_END
