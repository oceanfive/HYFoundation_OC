//
//  HYPathTool.h
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
/**
 APP沙盒路径：
 - Root
    - Documents
    - Library
        - Caches
        - Preferences
        - Cookies
        - WebKit
    - tmp
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HYAPPSandboxPath) {
    HYAPPSandboxPathRoot,        // Root，沙盒根目录
    HYAPPSandboxPathDocuments,   // Documents，会同步
    HYAPPSandboxPathLibrary,     // Library
    HYAPPSandboxPathCaches,      // Caches，不会同步
    HYAPPSandboxPathPreferences, // Preferences，会同步
    HYAPPSandboxPathTmp,         // tmp，不会同步
};

@interface HYPathTool : NSObject

#pragma mark - app沙盒路径
/**
 获取app沙盒常用的路径

 @param pathType 沙盒路径类型
 @return 路径
 */
+ (NSString *)hy_getAPPSandboxPathWithType:(HYAPPSandboxPath)pathType;

/**
 获取保存到app沙盒的文件的路径

 @param pathType 沙盒路径类型
 @param fileName 文件名称
 @return 路径（包含文件名称）
 */
+ (NSString *)hy_getAPPSandboxPathWithType:(HYAPPSandboxPath)pathType fileName:(NSString *)fileName;

#pragma mark - 具体的

/// app沙盒路径
+ (NSString *)hy_getRootPath;
/// Documents
+ (NSString *)hy_getDocumentsPath;
/// Library
+ (NSString *)hy_getLibraryPath;
/// Library - Caches
+ (NSString *)hy_getCachesPath;
/// Library - Preferences
+ (NSString *)hy_getPreferencesPath;
/// Tmp
+ (NSString *)hy_getTmpPath;

@end

NS_ASSUME_NONNULL_END
