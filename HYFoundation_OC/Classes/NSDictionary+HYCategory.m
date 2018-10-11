//
//  NSDictionary+HYCategory.m
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "NSDictionary+HYCategory.h"
#import "NSString+HYCategory.h"
#import "NSData+HYCategory.h"
#import "NSObject+HYCategory.h"

@implementation NSDictionary (HYCategory)

#pragma mark - 空值判断
+ (BOOL)hy_isNullDictionary:(NSDictionary *)dict {
    if (dict == nil ||
        [[dict allKeys] count] == 0 ||
        [dict isKindOfClass:[NSNull class]] ||
        dict == NULL) {
        return YES;
    }
    return NO;
}

- (NSDictionary *)hy_removesKeysWithNullValues {
    if ([NSDictionary hy_isNullDictionary:self]) return nil;
    id result = HYDictionaryByRemovingKeysWithNullValues(self);
    return (result && [result isKindOfClass:[NSDictionary class]]) ? result : nil;
}

static id HYDictionaryByRemovingKeysWithNullValues(id JSONObject) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:HYDictionaryByRemovingKeysWithNullValues(value)];
        }
        return mutableArray;
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = (NSDictionary *)JSONObject[key];
            if ([NSObject hy_isNull:value]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                mutableDictionary[key] = HYDictionaryByRemovingKeysWithNullValues(value);
            }
        }
        return mutableDictionary;
    }
    return JSONObject;
}

+ (NSDictionary *)hy_getNullDictionary {
    return @{};
}


#pragma mark - 取值
- (nullable id)hy_objectForKey:(NSString *)aKey {
    if (!aKey) return nil;
    id value = [self objectForKey:aKey];
    return [NSObject hy_isNull:value] ? nil : value;
}

#pragma mark - 写入和读取
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return NO;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self writeToFile:name atomically:YES];
}

+ (instancetype)hy_dictionaryWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return nil;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self dictionaryWithContentsOfFile:name];
}

#pragma mark - NSString 和 NSDictionary 互转
+ (NSString *)hy_stringFromDictionary:(NSDictionary *)dictionary {
    if ([NSDictionary hy_isNullDictionary:dictionary]) return nil;
    NSData *data = [NSData hy_dataFromDictionary:dictionary];
    return [NSData hy_stringFromData:data];
}

+ (NSDictionary *)hy_dictionaryFromString:(NSString *)string {
    if ([NSString hy_isNullString:string]) return nil;
    NSData *data = [NSData hy_dataFromString:string];
    return [NSData hy_dictionaryFromData:data];
}

- (NSString *)hy_stringValue {
    return [NSDictionary hy_stringFromDictionary:self];
}

#pragma mark - NSData 和 NSDictionary 互转
- (NSData *)hy_dataValue {
    return [NSData hy_dataFromDictionary:self];
}


@end


@implementation NSMutableDictionary (HYCategory)

- (void)hy_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    [self hy_setObject:anObject forKey:aKey nullOption:[NSNull null]];
}

- (void)hy_setObject:(id)anObject forKey:(id<NSCopying>)aKey nullOption:(id)nullOptionObject {
    if (!aKey) return;
    [self setObject:anObject != nil ? anObject : nullOptionObject != nil ? nullOptionObject : [NSNull null] forKey:aKey];
}

@end

