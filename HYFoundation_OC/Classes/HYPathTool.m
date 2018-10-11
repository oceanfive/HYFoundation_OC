//
//  HYPathTool.m
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "HYPathTool.h"

@implementation HYPathTool

+ (NSString *)hy_getAPPSandboxPathWithType:(HYAPPSandboxPath)pathType {
    if (pathType == HYAPPSandboxPathDocuments) {
        return [self hy_getDocumentsPath];
    } else if (pathType == HYAPPSandboxPathLibrary) {
        return [self hy_getLibraryPath];
    } else if (pathType == HYAPPSandboxPathTmp) {
        return [self hy_getTmpPath];
    } else if (pathType == HYAPPSandboxPathCaches) {
        return [self hy_getCachesPath];
    } else if (pathType == HYAPPSandboxPathPreferences) {
        return [self hy_getPreferencesPath];
    } else {
        return nil;
    }
}

+ (NSString *)hy_getDocumentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)hy_getLibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)hy_getTmpPath {
    return NSTemporaryDirectory();
}

+ (NSString *)hy_getCachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)hy_getPreferencesPath {
    NSString *libraryPath = [self hy_getLibraryPath];
    NSString *path = [libraryPath stringByAppendingPathComponent:@"Preferences"];
    return path;
    //讨论：此种方法是建立在Library/Preferences的文件夹结构，当app沙盒文件夹结果调整的话，这个方法也要进行相应的调整
}

+ (NSString *)hy_getAPPSandboxPathWithType:(HYAPPSandboxPath)pathType fileName:(NSString *)fileName {
    NSString *path = [self hy_getAPPSandboxPathWithType:pathType];
    return [path stringByAppendingPathComponent:fileName];
}

@end
