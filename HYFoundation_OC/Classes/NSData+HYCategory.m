//
//  NSData+HYCategory.m
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "NSData+HYCategory.h"
#import "NSObject+HYCategory.h"
#import "NSString+HYCategory.h"

@implementation NSData (HYCategory)

#pragma mark - 空值判断
+ (BOOL)hy_isNullData:(NSData *)data {
    if (data == nil || [data isKindOfClass:[NSNull class]] || data.length == 0 || data.bytes == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - 写入和读取
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return NO;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self writeToFile:name atomically:YES];
}

+ (instancetype)hy_dataWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return nil;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self dataWithContentsOfFile:name];
}

#pragma mark - NSString 和 NSData 互转
+ (NSString *)hy_stringFromData:(NSData *)data {
    if ([NSData hy_isNull:data]) return nil;
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)hy_dataFromString:(NSString *)string {
    if ([NSString hy_isNull:string]) return nil;
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)hy_stringValue {
    return [NSData hy_stringFromData:self];
}

#pragma mark - NSData 和 NSDictionary 互相转化
+ (NSDictionary *)hy_dictionaryFromData:(NSData *)data {
    id result = [NSData hy_objectFromData:data];
    if (![result isKindOfClass:[NSDictionary class]]) return nil;
    return result;
}

+ (NSData *)hy_dataFromDictionary:(NSDictionary *)dictionary {
    return [NSData hy_dataFromObject:dictionary];
}

- (NSDictionary *)hy_dictionaryValue {
    return [NSData hy_dictionaryFromData:self];
}

#pragma mark - NSData 和 NSArray 互相转化
+ (NSArray *)hy_arrayFromData:(NSData *)data {
    id result = [NSData hy_objectFromData:data];
    if (![result isKindOfClass:[NSArray class]]) return nil;
    return result;
}

+ (NSData *)hy_dataFromArray:(NSArray *)array {
    return [NSData hy_dataFromObject:array];
}

- (NSArray *)hy_arrayValue {
    return [NSData hy_arrayFromData:self];
}

#pragma mark - 公用方法
+ (id)hy_objectFromData:(NSData *)data {
    if ([NSData hy_isNull:data]) return nil;
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) return nil;
    return result;
    /*
     @discussion
     NSJSONReadingMutableContainers : 获取到的是可变的对象(NSMutableArray，NSMutableDictionary) 
     NSJSONReadingMutableLeaves : 获取到的是可变字符串(NSMutableString)
     NSJSONReadingAllowFragments : 允许最外层不是 NSArray 或者 NSDictionary
     也可以设置为kNilOptions(0)不进行设置
     */
}

+ (NSData *)hy_dataFromObject:(id)object {
    if ([NSObject hy_isNull:object]) return nil;
    if (![NSJSONSerialization isValidJSONObject:object]) return nil;
    NSError *error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (error) return nil;
    if (![result isKindOfClass:[NSData class]]) return nil;
    return result;
    /*
     @discussion
     NSJSONWritingPrettyPrinted : 带有空格，方便阅读
     NSJSONWritingSortedKeys : 11.0之后才可以使用;
     也可以设置为kNilOptions(0)不进行设置
     */
}

- (id)hy_value {
    return [NSData hy_objectFromData:self];
}

- (Class)hy_valueClass {
    return [[self hy_value] class];
}

- (NSString *)hy_valueClassName {
    return [[self hy_valueClass] hy_className];
}

- (BOOL)hy_valueIsNSDictionaryClass {
    return [[self hy_value] isKindOfClass:[NSDictionary class]];
}

- (BOOL)hy_valueIsNSArrayClass {
    return [[self hy_value] isKindOfClass:[NSArray class]];
}

- (BOOL)hy_valueIsNSStringClass {
    return [[self hy_value] isKindOfClass:[NSString class]];
}

@end
