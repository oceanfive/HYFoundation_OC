//
//  NSNumberFormatter+HYCategory.h
//  HYKit
//
//  Created by ocean on 2017/6/26.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumberFormatter (HYCategory)

/**
 货币显示格式，保留两位小数，根据地区自动调整

 @return NSNumberFormatter
 */
+ (NSNumberFormatter *)hy_currencyFormatter;

/**
 朗读格式，可以把数字转为汉字

 @return NSNumberFormatter
 */
+ (NSNumberFormatter *)hy_spellOutFormatter;

/**
 金额显示格式
 
 @return NSNumberFormatter
 
 @discusssion 正数部分按照3位一组显示，用","分割，小数部分保留2位小数；如 99,999.90
 
 */
+ (NSNumberFormatter *)hy_moneyFormatter;

@end

NS_ASSUME_NONNULL_END
