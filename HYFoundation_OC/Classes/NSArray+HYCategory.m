//
//  NSArray+HYCategory.m
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "NSArray+HYCategory.h"
#import "NSData+HYCategory.h"
#import "NSString+HYCategory.h"

@implementation NSArray (HYCategory)

#pragma mark - 私有方法
/**
 索引 index 是否超过数组范围
 */
- (BOOL)_isBeyondBoundsAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        return YES;
    }
    return NO;
}

+ (BOOL)_isBeyondBoundsAtIndex:(NSUInteger)index array:(NSArray *)array {
    if (index < 0 || index >= [array count]) {
        return YES;
    }
    return NO;
}

/**
 范围 range 是否超过数组范围
 */
- (BOOL)_isBeyondBoundsAtRange:(NSRange)range {
    if (range.location < 0 ||
        range.location > self.count - 1 ||
        range.location + range.length > self.count) {
        return YES;
    }
    return NO;
}

+ (BOOL)_isBeyondBoundsAtRange:(NSRange)range array:(NSArray *)array {
    if (range.location < 0 ||
        range.location > array.count - 1 ||
        range.location + range.length > array.count) {
        return YES;
    }
    return NO;
}

#pragma mark - 空值
+ (BOOL)hy_isNullArray:(NSArray *)array {
    if (array == nil ||
        array.count == 0 ||
        [array isKindOfClass:[NSNull class]] ||
        array == NULL) {
        return YES;
    }
    return NO;
}

+ (NSArray *)hy_getNullArray {
    return @[];
}

#pragma mark - 写入和读取
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return NO;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self writeToFile:name atomically:YES];
}

+ (instancetype)hy_arrayWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return nil;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self arrayWithContentsOfFile:name];
}

#pragma mark -  查询、获取元素
- (nullable id)hy_firstObject {
    return [self firstObject];
}

- (nullable id)hy_lastObject {
    return [self lastObject];
}

- (nullable id)hy_objectAtIndex:(NSUInteger)index {
    if ([self _isBeyondBoundsAtIndex:index]) return nil;
    return [self objectAtIndex:index];
}

- (NSArray<id> *)hy_objectsAtIndexes:(NSIndexSet *)indexes {
    __block BOOL flag = YES;
    __weak typeof(self) wself = self;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if ([wself _isBeyondBoundsAtIndex:idx]) {
            flag = NO;
            *stop = YES;
        }
    }];
    if (!flag) return nil;
    return [self objectsAtIndexes:indexes];
}

- (nullable NSArray *)hy_subarrayWithRange:(NSRange)range {
    if ([NSArray hy_isNullArray:self]) return nil;
    NSRange newRange = range;
    // 处理 location
    if (range.location < 0) {
        newRange.location = 0;
    }
    if (range.location > self.count - 1) {
        return nil;
    }
    // 处理 length
    if ([self _isBeyondBoundsAtRange:newRange]) {
        newRange.length = self.count - 1 - newRange.location + 1;
    }
    return [self subarrayWithRange:newRange];
}

- (NSArray *)hy_reverseArray {
    return [[self reverseObjectEnumerator] allObjects];
}

#pragma mark - 排序
- (NSArray *)hy_sortByAscending:(BOOL)ascending {
    if ([NSArray hy_isNullArray:self]) return nil;
    return [self sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ascending ? [obj1 compare:obj2] : [obj2 compare:obj1];
    }];
}

- (NSArray *)hy_sortByDescriptors:(nonnull NSArray<NSSortDescriptor *> *)descriptors {
    if ([NSArray hy_isNullArray:self] || [NSArray hy_isNullArray:descriptors]) return nil;
    return [self sortedArrayUsingDescriptors:descriptors];
}

#pragma mark - NSData 和 NSArray 互相转化
- (NSData *)hy_dataValue {
    return [NSData hy_dataFromArray:self];
}

#pragma mark - 查找
- (NSUInteger)hy_indexOfObject:(id)anObject inRange:(NSRange)range {
    if (!anObject) return NSNotFound;
    if ([self _isBeyondBoundsAtRange:range]) return NSNotFound;
    return [self indexOfObject:anObject inRange:range];
}

- (NSUInteger)hy_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    if (!anObject) return NSNotFound;
    if ([self _isBeyondBoundsAtRange:range]) return NSNotFound;
    return [self indexOfObjectIdenticalTo:anObject inRange:range];
}

@end


@implementation NSMutableArray (HYCategory)

- (void)hy_addObjectAtFirst:(id)anObject {
    if (!anObject) return;
    [self insertObject:anObject atIndex:0];
}

- (void)hy_addObjectAtLast:(id)anObject {
    if (!anObject) return;
    [self addObject:anObject];
}

- (void)hy_addObjectAtIndex:(NSUInteger)index object:(id)anObject {
    if ([self _isBeyondBoundsAtIndex:index])  return;
    if (!anObject) return;
    [self insertObject:anObject atIndex:index];
}

- (void)hy_addObjectsAtFirst:(NSArray *)objects {
    if ([NSArray hy_isNullArray:objects]) return;
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, objects.count)];
    [self insertObjects:objects atIndexes:set];
}

- (void)hy_addObjectsAtLast:(NSArray *)objects {
    if ([NSArray hy_isNullArray:objects]) return;
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.count, objects.count)];
    [self insertObjects:objects atIndexes:set];
}

- (void)hy_addObjectsAtIndex:(NSUInteger)index objects:(NSArray *)objects {
    // index 可以等于 self.count
    if (index < 0 || index > self.count || [NSArray hy_isNullArray:objects]) return;
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, objects.count)];
    [self insertObjects:objects atIndexes:set];
}

- (void)hy_removeObjectAtFirst {
    if ([NSArray hy_isNullArray:self]) return;
    [self removeObjectAtIndex:0];
}

- (void)hy_removeObjectAtLast {
    [self removeLastObject];
}

- (void)hy_removeObjectAtIndex:(NSUInteger)index {
    if ([self _isBeyondBoundsAtIndex:index]) return;
    [self removeObjectAtIndex:index];
}

- (void)hy_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    __weak typeof(self) wself = self;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [wself hy_removeObjectAtIndex:idx];
    }];
}

- (void)hy_removeObjectsInRange:(NSRange)range {
    if ([self _isBeyondBoundsAtRange:range]) return;
    [self removeObjectsInRange:range];
}

- (void)hy_removeObject:(id)anObject {
    if (!anObject) return;
    if ([NSArray hy_isNullArray:self]) return;
    [self removeObject:anObject];
}

- (void)hy_removeObject:(id)anObject inRange:(NSRange)range {
    if (!anObject) return;
    if ([NSArray hy_isNullArray:self]) return;
    if ([self _isBeyondBoundsAtRange:range]) return;
    [self removeObject:anObject inRange:range];
}

- (void)hy_removeAllObjects {
    [self removeAllObjects];
}

- (void)hy_replaceObjectAtFirstWithObject:(id)anObject {
    if (!anObject) return;
    if ([NSArray hy_isNullArray:self]) return;
    [self replaceObjectAtIndex:0 withObject:anObject];
}

- (void)hy_replaceObjectAtLastWithObject:(id)anObject {
    if (!anObject) return;
    if ([NSArray hy_isNullArray:self]) return;
    [self replaceObjectAtIndex:self.count - 1 withObject:anObject];
}

- (void)hy_replaceObjectAtIndex:(NSUInteger)index WithObject:(id)anObject {
    if (!anObject) return;
    if ([NSArray hy_isNullArray:self]) return;
    if ([self _isBeyondBoundsAtIndex:index]) return;
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)hy_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray {
    if ([NSArray hy_isNullArray:self]) return;
    if (!otherArray) return;
    if ([self _isBeyondBoundsAtRange:range]) return;
    [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)hy_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange {
    // 处理 "本身"
    if ([NSArray hy_isNullArray:self]) return;
    if ([self _isBeyondBoundsAtRange:range]) return;
    // 处理 otherArray
    if (!otherArray) return;
    if ([NSArray _isBeyondBoundsAtRange:otherRange array:otherArray]) return;
    [self replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    
}

- (void)hy_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects {
    if (!objects || !indexes) return;
    if (indexes.count < 1) return;
    if (indexes.count != objects.count) return;
    if ([NSArray hy_isNullArray:self]) return;
    __block BOOL flag = YES;
    __weak typeof(self) wself = self;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if ([wself _isBeyondBoundsAtIndex:idx]) {
            flag = NO;
            *stop = YES;
        }
    }];
    if (flag) {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
}

- (void)hy_exchangeObjectAtIndex:(NSUInteger)index withObjectAtIndex:(NSUInteger)otherIndex {
    if ([self _isBeyondBoundsAtIndex:index] || [self _isBeyondBoundsAtIndex:otherIndex]) {
        return;
    }
    [self exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
}

/**
 反向、倒序
 */
- (void)hy_reverse {
    //方案一： 以中间为轴，进行交换元素
//    NSUInteger count = self.count;
//    int mid = floor(count / 2.0);
//    for (NSUInteger i = 0; i < mid; i++) {
//        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
//    }
    //方案二： 系统方法，反向所有元素，移除所有元素，把反向得到的数组加入到“自己”中
    NSArray *temp = [[self reverseObjectEnumerator] allObjects];
    [self removeAllObjects];
    [self addObjectsFromArray:temp];
}

@end
