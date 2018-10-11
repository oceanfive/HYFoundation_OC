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

/**
 通过 子 bundle 的名称加载 bundle，类型默认为 .bundle

 @param subName 子 bundle 名称
 @return NSBundle
 */
- (nullable NSBundle *)hy_bundleWithSubBundleName:(NSString *)subName;

@end

NS_ASSUME_NONNULL_END
