//
//  NSCharacterSet+HYCategory.m
//  HYFoundation
//
//  Created by ocean on 2018/4/27.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "NSCharacterSet+HYCategory.h"

@implementation NSCharacterSet (HYCategory)

+ (NSCharacterSet *)hy_allowedURLCharacters {
    NSMutableCharacterSet *set = [[NSMutableCharacterSet alloc] init];
    [set formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]];
    [set formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    [set formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"$-_.+!*'(),;/?:@=&"]];
    return set;
}

+ (NSCharacterSet *)hy_allowedURLUserCharacterSet {
    return [NSCharacterSet URLUserAllowedCharacterSet];
}

+ (NSCharacterSet *)hy_allowedURLPasswordCharacterSet {
    return [NSCharacterSet URLPasswordAllowedCharacterSet];
}

+ (NSCharacterSet *)hy_allowedURLHostCharacterSet {
    return [NSCharacterSet URLHostAllowedCharacterSet];
}

+ (NSCharacterSet *)hy_allowedURLPathCharacterSet {
    return [NSCharacterSet URLPathAllowedCharacterSet];
}

+ (NSCharacterSet *)hy_allowedURLQueryCharacterSet {
    return [NSCharacterSet URLQueryAllowedCharacterSet];
}

+ (NSCharacterSet *)hy_allowedURLFragmentCharacterSet {
    return [NSCharacterSet URLFragmentAllowedCharacterSet];
}

@end
