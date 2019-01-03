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

- (BOOL)hy_removeFileItemAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == false) {
        return YES;
    } else {
        NSError *error = nil;
        BOOL result = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"removeItemAtPath - error:%@", error);
        }
        return result;
    }
}


- (NSDictionary<NSFileAttributeKey, id> *)hy_attributesOfItemAtPath:(NSString *)path {
    NSError *error = nil;
    NSDictionary *att = [self attributesOfItemAtPath:path error:&error];
    if (error) {
        NSLog(@"attributesOfItemAtPath - error: %@", error);
        return nil;
    }
    return att;
}

- (BOOL)hy_isFileAtPath:(NSString *)path {
    return ![self hy_isDirectoryAtPath:path];
}

- (BOOL)hy_isDirectoryAtPath:(NSString *)path {
    NSDictionary *dict = [self hy_attributesOfItemAtPath:path];
    return [[dict fileType] isEqualToString:NSFileTypeDirectory];
}


- (NSArray<NSString *> *)hy_fullSubpathsAtPath:(NSString *)path {
    if (!path) return nil;
    NSError *error = nil;
    NSArray *paths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:&error];
    if (error) {
        NSLog(@"subpathsOfDirectoryAtPath - error: %@", error);
        return nil;
    }
    NSMutableArray *result = [NSMutableArray array];
    [paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *filePath = (NSString *)obj;
        NSString *fullPath = [path stringByAppendingPathComponent:filePath];
        if (fullPath) {
            [result addObject:fullPath];
        }
    }];
    return [result copy];
}


- (NSArray<NSString *> *)hy_fullSubFilePathsAtPath:(NSString *)path {
    NSArray *subpaths = [self hy_fullSubpathsAtPath:path];
    if (subpaths.count <= 0) return nil;
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *subpath in subpaths) {
        if (![self hy_isDirectoryAtPath:subpath]) {
            [result addObject:subpath];
        }
    }
    return result;
}

- (NSArray<NSString *> *)hy_fullSubDirectoryPathsAtPath:(NSString *)path {
    NSArray *subpaths = [self hy_fullSubpathsAtPath:path];
    if (subpaths.count <= 0) return nil;
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *subpath in subpaths) {
        if ([self hy_isDirectoryAtPath:subpath]) {
            [result addObject:subpath];
        }
    }
    return result;
}


- (unsigned long long)hy_singleFileSizeAtFilePath:(NSString *)filePath {
    unsigned long long size = 0;
    if ([self hy_isFileAtPath:filePath]) { // 文件
        NSDictionary *att = [self hy_attributesOfItemAtPath:filePath];
        size = [att fileSize];
    }
    return size;
}


- (unsigned long long)hy_fileSizeAtFilePath:(NSString *)filePath {
    unsigned long long size = 0;
    if ([self hy_isFileAtPath:filePath]) { // 文件
        size = [self hy_singleFileSizeAtFilePath:filePath];
    } else { // 文件夹
        NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
        // 这里包含了 "文件夹"
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
            NSDictionary *att = [self hy_attributesOfItemAtPath:fullPath];
            size += [att fileSize];
        }
    }
    return size;
}


- (unsigned long long)hy_getAPPSandboxFileSizeWithPath:(HYAPPSandboxPath)path {
    NSString *filePath = [HYPathTool hy_getAPPSandboxPathWithType:path];
    return [self hy_fileSizeAtFilePath:filePath];
}


@end
