//
//  NSObject+HYCategory.m
//  HYKit
//
//  Created by wuhaiyang on 2017/2/15.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import "NSObject+HYCategory.h"
#import <objc/runtime.h>
#import "NSString+HYCategory.h"
#import "NSArray+HYCategory.h"
#import "NSDictionary+HYCategory.h"
#import "NSData+HYCategory.h"

@implementation NSObject (HYCategory)

+ (BOOL)hy_isNull:(id)object {    
    if ([object isKindOfClass:[NSString class]]) {
        return [NSString hy_isNullString:object];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [NSArray hy_isNullArray:object];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        return [NSDictionary hy_isNullDictionary:object];
    } else if ([object isKindOfClass:[NSData class]]) {
        return [NSData hy_isNullData:object];
    } else if ([object isKindOfClass:[NSNull class]] || object == [NSNull null]) {
        return YES;
    } else {
        return object == nil;
    }
}

+ (NSString *)hy_className {
    return NSStringFromClass([self class]);
}

- (NSString *)hy_className {
    return NSStringFromClass([self class]);
}

@end
