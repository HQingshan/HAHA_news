//
//  HQS_LocalData.h
//  HAHA新闻
//
//  Created by 你好帅 on 2019/7/18.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQS_LocalData : NSObject


+ (BOOL)OCArray: (NSArray *)ArrayDete  writeToDocumentsJSONFileName:(NSString *)Name;

+ (nullable id)OCArrayBeReadfromDocumentsJSONFileName:(NSString *)Name;


@end

NS_ASSUME_NONNULL_END
