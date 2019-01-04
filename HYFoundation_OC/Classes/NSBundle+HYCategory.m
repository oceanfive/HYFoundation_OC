//
//  NSBundle+HYCategory.m
//  HYFoundation
//
//  Created by ocean on 2018/3/6.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "NSBundle+HYCategory.h"

NSString *const HYBundleDisplayNameKey = @"CFBundleDisplayName";
NSString *const HYBundleIdentifierKey = @"CFBundleIdentifier";
NSString *const HYBundleBuildVersionKey = @"CFBundleVersion";
NSString *const HYBundleShortVersionStringKey = @"CFBundleShortVersionString";

@implementation NSBundle (HYCategory)

- (NSBundle *)hy_bundleWithSubBundleName:(NSString *)subName {
    if (!subName || subName.length == 0) {
        return nil;
    }
    NSString *subPath = [self pathForResource:subName ofType:@"bundle"];
    return [NSBundle bundleWithPath:subPath];
}

- (NSString *)hy_bundleDisplayName {
    return [[self infoDictionary] objectForKey:HYBundleDisplayNameKey];
}

- (NSString *)hy_bundleIdentifier {
    return [[self infoDictionary] objectForKey:HYBundleIdentifierKey];
}

- (NSString *)hy_bundleVersion {
    return [[self infoDictionary] objectForKey:HYBundleShortVersionStringKey];
}

- (NSString *)hy_bundleBuildVersion {
    return [[self infoDictionary] objectForKey:HYBundleBuildVersionKey];
}

@end
