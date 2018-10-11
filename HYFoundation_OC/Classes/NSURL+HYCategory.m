//
//  NSURL+HYCategory.m
//  HYFoundation
//
//  Created by ocean on 2018/7/2.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "NSURL+HYCategory.h"

@implementation NSURL (HYCategory)

- (NSURL *)hy_safeURL {
    if ([self isKindOfClass:[NSString class]]) {
        return [NSURL URLWithString:(NSString *)self];
    }
    if (![self isKindOfClass:[NSURL class]]) {
        return nil;
    }
    return self;
}

@end
