//
//  NSURL+HYCategory.h
//  HYFoundation
//
//  Created by ocean on 2018/7/2.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (HYCategory)

@property (nonatomic, strong, readonly, nullable) NSURL *hy_safeURL;

@end

NS_ASSUME_NONNULL_END
