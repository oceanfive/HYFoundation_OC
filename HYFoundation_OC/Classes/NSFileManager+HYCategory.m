//
//  NSFileManager+HYCategory.m
//  HYKit
//
//  Created by wuhaiyang on 2017/3/20.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import "NSFileManager+HYCategory.h"

@implementation NSFileManager (HYCategory)

- (BOOL)hy_createDirectoryAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == false) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        return YES;
    }
}

- (NSArray *)hy_getAllFilePathsAtPath:(NSString *)path {
    NSMutableArray *result = [NSMutableArray array];
    NSArray *paths = [[NSFileManager defaultManager] subpathsAtPath:path];
    [paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *filePath = (NSString *)obj;
        NSString *fullPath = [path stringByAppendingPathComponent:filePath];
        if ([self hy_isFileAtPath:fullPath]) {
            [result addObject:fullPath];
        }
    }];
    return result;
}

- (unsigned long long)hy_getFileSizeAtFilePath:(NSString *)filePath {
    __block unsigned long long size = 0;
    if ([self hy_isFileAtPath:filePath]) { //文件
        size = [self hy_getSingleFileSizeAtFilePath:filePath];
    } else { //文件夹
        NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
            NSDictionary *att = [[NSFileManager defaultManager] attributesOfItemAtPath:fullPath error:nil];
            size += att.fileSize;
        }
    }
    return size;
}

- (unsigned long long)hy_getAPPSandboxFileSizeWithPath:(HYAPPSandboxPath)path {
    NSString *filePath = [HYPathTool hy_getAPPSandboxPathWithType:path];
    return [self hy_getFileSizeAtFilePath:filePath];
}

- (BOOL)hy_removeFileItemAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == false) {
        return YES;
    } else {
        if ([[NSFileManager defaultManager] removeItemAtPath:path error:nil]) {
            return YES;
        } else {
            return NO;
        }
    }
}

/**
 判断一个路径是不是一个文件，path是“全路径”
 YES，是文件；NO，是文件夹；
 */
- (BOOL)hy_isFileAtPath:(NSString *)path {
    NSDictionary *dict = [self hy_getAttributesOfItemAtPath:path];
    return [dict.fileType isEqualToString:NSFileTypeDirectory] ? NO : YES;
}

/**
 获取文件/文件夹的属性，path是“全路径”
 */
- (NSDictionary *)hy_getAttributesOfItemAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
}


#pragma mark - 私有方法
- (unsigned long long)hy_getSingleFileSizeAtFilePath:(NSString *)filePath {
    unsigned long long size = 0;
    if ([self hy_isFileAtPath:filePath]) { //文件
        NSDictionary *att = [self hy_getAttributesOfItemAtPath:filePath];
        size = att.fileSize;
    }
    return size;
}


#pragma mark - 暂不使用
- (NSArray *)hy_getAllFilePathsAtPath:(NSString *)path isIncludedSubfolder:(BOOL)isIncludedSubfolder isIncludedDirectory:(BOOL)isIncludedDirectory {
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *directories = [NSMutableArray array];
    NSArray *paths = [[NSFileManager defaultManager] subpathsAtPath:path];
    [paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *filePath = (NSString *)obj;
        NSString *fullPath = [path stringByAppendingPathComponent:filePath];
        [temp addObject:fullPath];
        if (![self hy_isFileAtPath:fullPath]) {
            [directories addObject:fullPath];
        }
    }];
    [temp enumerateObjectsUsingBlock:^(NSString * _Nonnull objTemp, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!isIncludedSubfolder) {
            [directories enumerateObjectsUsingBlock:^(NSString *  _Nonnull objDir, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![objTemp hasPrefix:objDir]) {
                    [result addObject:objTemp];
                }
            }];
        }
    }];
    
    
    
    //    if (isIncludedDirectory) {
    //        [paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //            NSString *filePath = (NSString *)obj;
    //            NSString *fullPath = [path stringByAppendingPathComponent:filePath];
    //            [result addObject:fullPath];
    //        }];
    //    } else {
    //        [paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //            NSString *filePath = (NSString *)obj;
    //            NSString *fullPath = [path stringByAppendingPathComponent:filePath];
    //            if ([self hy_isFileAtPath:fullPath]) {
    //                [result addObject:fullPath];
    //            }
    //        }];
    //    }
    return result;
}

@end
