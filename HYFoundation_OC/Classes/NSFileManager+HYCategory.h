//
//  NSFileManager+HYCategory.h
//  HYKit
//
//  Created by wuhaiyang on 2017/3/20.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<HYTool/HYPathTool.h>)
#import <HYTool/HYPathTool.h>
#else
#import "HYPathTool.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (HYCategory)

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
 获取文件的“全路径”，包含子文件夹的，会过滤掉非文件的内容（比如文件夹）

 @param path 路径
 @return 所有的文件的全路径
 
 例子：
 .../Documents/newOne/.DS_Store
 .../Documents/newOne/11.plist
 .../Documents/newOne/12.plist
 .../Documents/newOne/13.plist
 .../Documents/newOne/14.plist
 .../Documents/newOne/newOneOne  --- 这个是不存在的！！！
 .../Documents/newOne/newOneOne/110.plist
 .../Documents/newOne/newOneOne/111.plist
 .../Documents/newOne/newOneOne/112.plist
 
 */
- (NSArray *)hy_getAllFilePathsAtPath:(NSString *)path;

/**
 获取指定文件/文件夹的大小
 
 @param filePath 文件/文件夹，传入的是“全路径”
 @return 大小
 
 备注：
 返回值单位为字节
 1G = 1000 M
 1M = 1000 K
 1K = 1000 B
 
 */
- (unsigned long long)hy_getFileSizeAtFilePath:(NSString *)filePath;

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

/**
 删除文件/文件夹，传入文件路径则删除对应的文件，传入文件夹路径则删除这个文件夹的所有内容，包含本身的文件夹

 @param path 文件/文件夹的全路径
 @return YES，成功；NO：失败；
 */
- (BOOL)hy_removeFileItemAtPath:(NSString *)path;





#pragma mark - 暂不使用
/**
 获取指定文件下的所有文件/文件夹路径，这个路径是“全路径”
 
 @param path 文件夹路径
 @param isIncludedSubfolder YES，包含子文件夹；NO不包含子文件夹
 @param isIncludedDirectory 是否包含文件夹，YES，包含文件夹，不会过滤；NO，不包含文件夹，会过滤文件夹；
 @return 所有的文件全路径
 
 备注：
 //--------------------------------------------------------------------
 isIncludedSubfolder参数为 YES 的情况：这个方法“会”进行遍历，“包含”子文件夹的文件
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/.DS_Store
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/11.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/12.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/13.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/14.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/newOneOne
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/newOneOne/110.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/newOneOne/111.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/newOneOne/112.plist
 //--------------------------------------------------------------------
 isIncludedSubfolder参数为 NO 的情况：这个方法“不会”进行遍历，“不包含“子文件夹以及子文件夹下的文件
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/.DS_Store
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/11.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/12.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/13.plist
 /Users/wuhaiyang/Library/Developer/CoreSimulator/Devices/7808C480-DA51-4ACC-B7A6-B33FBF78D5CF/data/Containers/Data/Application/376E8568-4860-4689-83E4-CC3CB03CFEA9/Documents/newOne/14.plist
 //--------------------------------------------------------------------
 */
- (NSArray *)hy_getAllFilePathsAtPath:(NSString *)path isIncludedSubfolder:(BOOL)isIncludedSubfolder isIncludedDirectory:(BOOL)isIncludedDirectory;

@end

NS_ASSUME_NONNULL_END
