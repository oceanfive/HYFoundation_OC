//
//  NSObject+HYCategory.h
//  HYKit
//
//  Created by wuhaiyang on 2017/2/15.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HYCategory)

#pragma mark - 空值判断
/**
 判断数据是否为空

 @return YES:为空；NO:不为空
 */
+ (BOOL)hy_isNull:(nullable id)object;

#pragma mark - 类名称
/**
 获取类的名称

 @return 类名称
 */
+ (NSString *)hy_className;

/**
 获取类的名称

 @return 类名称
 */
- (NSString *)hy_className;

@end

NS_ASSUME_NONNULL_END
