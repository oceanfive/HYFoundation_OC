//
//  NSData+HYCategory.h
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

@interface NSData (HYCategory)

#pragma mark - 空值判断
/**
 判断二进制数据是否为空

 @param data 需要判断的二进制数据
 @return YES:为空；NO:不为空
 */
+ (BOOL)hy_isNullData:(nullable NSData *)data;

#pragma mark - 写入和读取
/**
 写入到app沙盒的常用路径
 
 @param path 沙盒路径类型
 @param fileName 文件名称
 @return 成功/失败
 */
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName;

/**
 初始化方法，通过app沙盒文件进行初始化
 
 @param path 沙盒路径类型
 @param fileName 文件名称
 @return 实例
 */
+ (instancetype)hy_dataWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName;

#pragma mark - NSData 和 NSString 互相转化
/**
 二进制转字符串
 
 @param data 二进制数据
 @return 字符串
 */
+ (NSString *)hy_stringFromData:(NSData *)data;

/**
 字符串转二进制数据
 
 @param string 字符串
 @return 二进制数据
 */
+ (NSData *)hy_dataFromString:(NSString *)string;

/**
 二进制转字符串，等价于方法：
 + (NSString *)hy_stringFromData:(NSData *)data;
 */
@property (nonatomic, strong, readonly) NSString *hy_stringValue;

#pragma mark - NSData 和 NSDictionary 互相转化
/**
 二进制数据转字典

 @param data 二进制数据
 @return 字典
 */
+ (NSDictionary *)hy_dictionaryFromData:(NSData *)data;

/**
 字典转二进制

 @param dictionary 字典
 @return 二进制数据
 */
+ (NSData *)hy_dataFromDictionary:(NSDictionary *)dictionary;

/**
 二进制数据转字典，等价于方法：
 + (NSDictionary *)hy_dictionaryFromData:(NSData *)data;
 */
@property (nonatomic, strong, readonly) NSDictionary *hy_dictionaryValue;

#pragma mark - NSData 和 NSArray 互相转化
/**
 二进制转数组

 @param data 二进制数据
 @return 数组
 */
+ (NSArray *)hy_arrayFromData:(NSData *)data;

/**
 数组转二进制

 @param array 数组
 @return 二进制数据
 */
+ (NSData *)hy_dataFromArray:(NSArray *)array;

/**
 二进制转数组，等价于方法：
 + (NSArray *)hy_arrayFromData:(NSData *)data;
 */
@property (nonatomic, strong, readonly) NSArray *hy_arrayValue;


#pragma mark - 最基本的公用方法 - 
/*
 ps：object必须是有效的JSON格式，否则会转化错误；
 JSON格式检查方法：
 + (BOOL)isValidJSONObject:(id)obj; //备注，这个方法是用来检查OC对象符不符合JSON格式，不能对NSData使用
 
 对象必须有以下属性:
 ——顶级对象即最外层的数据类型为NSArray或NSDictionary
 ——所有对象为NSString NSNumber、NSArray NSDictionary或NSNull
 ——所有字典的键值的格式为NSString
 ——NSNumber不是空或无穷其他规则可能适用。
 调用该方法或尝试转换的方法来判断一个给定的对象可以转换为JSON数据。
 
 官方文档如下：
The object must have the following properties:
- Top level object is an NSArray or NSDictionary
- All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
- All dictionary keys are NSStrings
- NSNumbers are not NaN or infinity
Other rules may apply. Calling this method or attempting a conversion are the definitive ways to tell if a given object can be converted to JSON data.
*/
 
/**
 把二进制数据转化为OC对象

 @param data 二进制数据
 @return OC对象
 */
+ (id)hy_objectFromData:(NSData *)data;

/**
 把OC对象转为二进制数据

 @param object OC对象
 @return 二进制数据
 */
+ (NSData *)hy_dataFromObject:(id)object;

/**
 二进制数据转换的OC对象
 */
@property (nonatomic, strong, readonly) id hy_value;

/**
 二进制转化为OC对象，对应的类
 */
@property (nonatomic, strong, readonly) Class hy_valueClass;

/**
 二进制转化为OC对象，对应的类的名称，当类为nil时，类名为(null)
 */
@property (nonatomic, copy, readonly) NSString *hy_valueClassName;

/**
 二进制转化的OC对象是否是字典NSDictionary数据类型
 */
@property (nonatomic, assign, readonly) BOOL hy_valueIsNSDictionaryClass;

/**
 二进制转化的OC对象是否是数组NSArray数据类型
 */
@property (nonatomic, assign, readonly) BOOL hy_valueIsNSArrayClass;

#pragma mark - DEPRECATED
/**
 二进制转化的OC对象是否是字符串NSString数据类型
 */
@property (nonatomic, assign, readonly) BOOL hy_valueIsNSStringClass NS_DEPRECATED_IOS(1, 1, "废除的属性，勿用");

@end

NS_ASSUME_NONNULL_END
