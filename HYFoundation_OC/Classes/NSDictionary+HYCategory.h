//
//  NSDictionary+HYCategory.h
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<HYTool/HYPathTool.h>)
#import <HYTool/HYPathTool.h>
#else
#import "HYPathTool.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (HYCategory)

#pragma mark - 空值判断
/**
 判断字典是否为空

 @param dict 需要判断的字典
 @return YES:为空；NO:不为空
 */
+ (BOOL)hy_isNullDictionary:(nullable NSDictionary *)dict;

/**
 过滤字典中值为空的键值对

 @return 处理后的字典
 */
- (NSDictionary *)hy_removesKeysWithNullValues;

/**
 空字典 @{}
 */
+ (NSDictionary *)hy_getNullDictionary;

#pragma mark - 取值
/**
 自定义取值方法

 @param aKey key值
 @return value值
 
 @discussion
 如果取到的值为空，会返回 nil
 
 */
- (nullable id)hy_objectForKey:(NSString *)aKey;


#pragma mark - 写入和读取
/**
 写入到app沙盒的常用路径
 
 @param path 沙盒路径类型
 @param fileName 文件名称
 @return YES:成功 ; NO:失败
 */
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName;

/**
 初始化方法，通过app沙盒文件进行初始化
 
 @param path 沙盒路径类型
 @param fileName 文件名称
 @return 实例
 */
+ (instancetype)hy_dictionaryWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName;


#pragma mark - NSString 和 NSDictionary 互转

/**
 字典转字符串
 
 @param dictionary 字典
 @return 字符串
 */
+ (NSString *)hy_stringFromDictionary:(NSDictionary *)dictionary;

/**
 字符串转字典
 
 @param string 字符串
 @return 字典
 */
+ (NSDictionary *)hy_dictionaryFromString:(NSString *)string;

/**
 字典转字符串，等价于方法：
 + (NSString *)hy_stringFromDictionary:(NSDictionary *)dictionary;
 */
@property (nonatomic, strong, readonly) NSString *hy_stringValue;


#pragma mark - NSData 和 NSDictionary 互转
/**
 字典转二进制数据
 */
@property (nonatomic, strong, readonly) NSData *hy_dataValue;

@end


@interface NSMutableDictionary<KeyType, ObjectType> (HYCategory)

/**
 键值对字典赋值，如果anObject==nil，会设置为[NSNull null]，不会导致程序崩溃

 @param anObject value
 @param aKey key
 */
- (void)hy_setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;

/**
 键值对字典赋值

 @param anObject value
 @param aKey key
 @param nullOptionObject 当vlaue=nil的时候的备用值
 
 @discussion
 1、判断anObject是否为空，不为空则进行赋值；如果为空则取nullOptionObject进行赋值
 2、判断nullOptionObject是否为空，不为空则进行赋值；如果为空则赋值为[NSNull null]
 
 */
- (void)hy_setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey nullOption:(ObjectType)nullOptionObject;

@end

NS_ASSUME_NONNULL_END
