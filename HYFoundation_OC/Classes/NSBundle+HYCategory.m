//
//  NSBundle+HYCategory.m
//  HYFoundation
//
//  Created by ocean on 2018/3/6.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "NSBundle+HYCategory.h"

@implementation NSBundle (HYCategory)

- (NSBundle *)hy_bundleWithSubBundleName:(NSString *)subName {
    if (!subName || subName.length == 0) {
        return nil;
    }
    NSString *subPath = [self pathForResource:subName ofType:@"bundle"];
    return [NSBundle bundleWithPath:subPath];
}

@end
