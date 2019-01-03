//
//  NSFileManager+HYCategory.h
//  HYKit
//
//  Created by wuhaiyang on 2017/3/20.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYPathTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (HYCategory)

#pragma mark - 创建文件夹
/**
 创建文件夹

 @param path 文件夹路径
 @return 成功/失败
 
 备注：这个方法是用来创建文件夹的，不是文件，所以如果传入的path为文件名称，仍然会创建文件夹，而不是文件；
 
 例子：
 NSString *path = [HYPathTool hy_getAPPSandboxPathWithType:HYAPPSandboxPathDocuments];
 NSString *filePath = [path stringByAppendingString:@"/newOne/newOneOne"];
 if ([[NSFileManager defaultManager] hy_createDirectoryAtPath:filePath]) {
    NSLog(@"创建成功");
 } else {
    NSLog(@"创建失败");
 }
 
 */
- (BOOL)hy_createDirectoryAtPath:(NSString *)path;


/**
 删除文件/文件夹，传入文件路径则删除对应的文件，传入文件夹路径则删除这个文件夹的所有内容，包含本身的文件夹
 
 @param path 文件/文件夹的全路径
 @return YES，成功；NO：失败；
 */
- (BOOL)hy_removeFileItemAtPath:(NSString *)path;


#pragma mark - 文件/文件夹属性

/**
 获取 path 位置处的 文件/文件夹 属性

 @param path 路径，是全路径
 @return 属性 NSDictionary
 */
- (nullable NSDictionary<NSFileAttributeKey, id> *)hy_attributesOfItemAtPath:(NSString *)path;


#pragma mark - 是否是文件夹的判断
/// "全路径 path " 是否是文件夹
- (BOOL)hy_isDirectoryAtPath:(NSString *)path;
/// "全路径 path " 是否是文件
- (BOOL)hy_isFileAtPath:(NSString *)path;


#pragma mark - 查找子文件夹
/// 获取 “全路径 path ” 的所有 子文件夹/文件
- (nullable NSArray<NSString *> *)hy_fullSubpathsAtPath:(NSString *)path;
/// 获取 “全路径 path ” 的所有 子文件
- (nullable NSArray<NSString *> *)hy_fullSubFilePathsAtPath:(NSString *)path;
/// 获取 “全路径 path ” 的所有 子文件夹
- (nullable NSArray<NSString *> *)hy_fullSubDirectoryPathsAtPath:(NSString *)path;

#pragma mark - 文件大小
/// 在 "全路径 filePath" 处的 "文件大小"，如果是文件夹会被过滤掉
- (unsigned long long)hy_singleFileSizeAtFilePath:(NSString *)filePath;

/**
 获取指定文件/文件夹的大小
 
 @param filePath 文件/文件夹，传入的是“全路径”
 @return 大小 (Bytes)
 
 备注：
 返回值单位为字节
 1G = 1000 M
 1M = 1000 K
 1K = 1000 B
 
 */
- (unsigned long long)hy_fileSizeAtFilePath:(NSString *)filePath;

/**
 获取app常用沙盒文件夹的大小

 @param path 沙盒文件
 @return 大小
 备注：
 返回值单位为字节
 1G = 1000 M
 1M = 1000 K
 1K = 1000 B
 
 */
- (unsigned long long)hy_getAPPSandboxFileSizeWithPath:(HYAPPSandboxPath)path;


@end

NS_ASSUME_NONNULL_END
