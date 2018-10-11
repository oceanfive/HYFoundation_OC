//
//  HYObject.m
//  HYKit
//
//  Created by wuhaiyang on 2017/2/14.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import "HYObject.h"
#import <objc/runtime.h>

@implementation HYObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            // 反归档
            id value = [aDecoder decodeObjectForKey:key];
            // 键值对设置value值
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        // 以成员变量作为key值
        NSString *key = [NSString stringWithUTF8String:name];
        // kvc获取value值
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

//类/对象的描述信息
- (NSString *)description {
    return [NSString stringWithFormat:@"< %@ = %p > , %@ ", [self class], self, [self hy_getAllIvarInfo]];
}

//断点调试状态，po 命令的打印信息
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"< %@ = %p > , %@ ", [self class], self, [self hy_getAllIvarInfo]];
}

//获取所有的成员变量信息
- (NSDictionary *)hy_getAllIvarInfo {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        if (value == nil) {
            [dict setObject:[NSNull class] forKey:key];
        } else {
            [dict setObject:value forKey:key];
        }
    }
    free(ivars);
    return dict;
}

@end
