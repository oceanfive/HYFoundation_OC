//
//  NSCharacterSet+HYCategory.h
//  HYFoundation
//
//  Created by ocean on 2018/4/27.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCharacterSet (HYCategory)

/**
 获取在 url 中允许的不需要编码的字符集合
 */
+ (NSCharacterSet *)hy_allowedURLCharacters;

+ (NSCharacterSet *)hy_allowedURLUserCharacterSet;

+ (NSCharacterSet *)hy_allowedURLPasswordCharacterSet;

+ (NSCharacterSet *)hy_allowedURLHostCharacterSet;

+ (NSCharacterSet *)hy_allowedURLPathCharacterSet;

+ (NSCharacterSet *)hy_allowedURLQueryCharacterSet;

+ (NSCharacterSet *)hy_allowedURLFragmentCharacterSet;

@end

NS_ASSUME_NONNULL_END
