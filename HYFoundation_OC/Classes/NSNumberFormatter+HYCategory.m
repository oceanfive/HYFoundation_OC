//
//  NSNumberFormatter+HYCategory.m
//  HYKit
//
//  Created by ocean on 2017/6/26.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import "NSNumberFormatter+HYCategory.h"

@implementation NSNumberFormatter (HYCategory)

+ (NSNumberFormatter *)hy_currencyFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    return formatter;
}

+ (NSNumberFormatter *)hy_spellOutFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    return formatter;
}

+ (NSNumberFormatter *)hy_moneyFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.positiveFormat = @",##0.00";
    formatter.groupingSize = 3;
    formatter.secondaryGroupingSize = 3;
    return formatter;
}

@end
