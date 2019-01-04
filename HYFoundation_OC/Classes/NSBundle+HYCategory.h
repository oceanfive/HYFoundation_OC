//
//  NSBundle+HYCategory.h
//  HYFoundation
//
//  Created by ocean on 2018/3/6.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (HYCategory)

#pragma mark - 相关信息获取
/// 显示的名称
- (NSString *)hy_bundleDisplayName;
/// bundle id
- (NSString *)hy_bundleIdentifier;
/// 显示的版本
- (NSString *)hy_bundleVersion;
/// build 版本
- (NSString *)hy_bundleBuildVersion;

/**
 通过 子 bundle 的名称加载 bundle，类型默认为 .bundle

 @param subName 子 bundle 名称
 @return NSBundle
 */
- (nullable NSBundle *)hy_bundleWithSubBundleName:(NSString *)subName;

@end

NS_ASSUME_NONNULL_END
