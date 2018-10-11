//
//  NSArray+HYCategory.h
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  数组范围越界判断：index >= count 

#import <Foundation/Foundation.h>
#if __has_include(<HYTool/HYPathTool.h>)
#import <HYTool/HYPathTool.h>
#else
#import "HYPathTool.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HYCategory)

#pragma mark - 空值
/**
 判断数组是否为空

 @param array 需要判断的数组
 @return YES:为空；NO:不为空
 */
+ (BOOL)hy_isNullArray:(nullable NSArray *)array;

/**
 空数组 @[]
 */
+ (NSArray *)hy_getNullArray;


#pragma mark - 获取元素
/**
 查询、获取元素
 */
- (nullable id)hy_firstObject;
- (nullable id)hy_lastObject;
/**
 index超过数组范围，返回值为nil；系统的方法索引超过范围会崩溃
 */
- (nullable id)hy_objectAtIndex:(NSUInteger)index;

/**
 indexes超过数组范围，返回值为nil；系统的方法索引超过范围会崩溃
 */
- (NSArray<id> *)hy_objectsAtIndexes:(NSIndexSet *)indexes;


#pragma mark - 截取
/**
 系统的方法range超过范围会崩溃
 range.location < 0 ，位置从 0 开始截取
 range.location > self.count - 1 ，返回 nil
 range.location + range.length > self.count ，默认截取到最后一个元素
 */
- (nullable NSArray *)hy_subarrayWithRange:(NSRange)range;


#pragma mark - 查找
- (NSUInteger)hy_indexOfObject:(id)anObject inRange:(NSRange)range;
- (NSUInteger)hy_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range;


#pragma mark - 反序
/**
 本身不会被反向、倒序；得到的新的数组是反向、倒序的；
 */
- (nullable NSArray *)hy_reverseArray; 


#pragma mark - 排序
/**
 升序/降序排列

 @param ascending YES：升序；NO：降序；
 @return 排序之后的新的数组
 */
- (NSArray *)hy_sortByAscending:(BOOL)ascending;

/**
 对数组进行排序，针对数组模型

 @param descriptors 排序规则描述
 @return 排序之后的新的数组
 */
- (NSArray *)hy_sortByDescriptors:(nonnull NSArray<NSSortDescriptor *> *)descriptors;


#pragma mark - NSData 和 NSArray 互相转化
/**
 数组转二进制数据
 */
@property (nonatomic, strong, readonly) NSData *hy_dataValue;


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
+ (nullable instancetype)hy_arrayWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName;

@end


@interface NSMutableArray (HYCategory)

#pragma mark - 数组元素处理 ： 增/删/改/查/交换/倒序
#pragma mark - 对于数组的操作，涉及到“索引位置”时，如果“索引位置”超过范围，则操作失败，其他情况下默认是操作成功的；
/**
 增加元素方法，单个元素
 */
- (void)hy_addObjectAtFirst:(id)anObject;
- (void)hy_addObjectAtLast:(id)anObject;
- (void)hy_addObjectAtIndex:(NSUInteger)index object:(id)anObject;

/**
 增加元素方法，多个元素
 */
- (void)hy_addObjectsAtFirst:(NSArray *)objects;
- (void)hy_addObjectsAtLast:(NSArray *)objects;
- (void)hy_addObjectsAtIndex:(NSUInteger)index objects:(NSArray *)objects;

/**
 删除元素方法
 */
- (void)hy_removeObjectAtFirst; 
- (void)hy_removeObjectAtLast;
- (void)hy_removeObjectAtIndex:(NSUInteger)index;
- (void)hy_removeObjectsAtIndexes:(NSIndexSet *)indexes;
- (void)hy_removeObjectsInRange:(NSRange)range;
- (void)hy_removeObject:(id)anObject;
- (void)hy_removeObject:(id)anObject inRange:(NSRange)range;
- (void)hy_removeAllObjects;

/**
 修改元素内容方法
 */
- (void)hy_replaceObjectAtFirstWithObject:(id)anObject;
- (void)hy_replaceObjectAtLastWithObject:(id)anObject;
- (void)hy_replaceObjectAtIndex:(NSUInteger)index WithObject:(id)anObject;
- (void)hy_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray;
- (void)hy_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange;
- (void)hy_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects;

/**
 交换元素
 注意： index 和 otherIndex 若超过数组的范围的话，会直接返回，交换操作失败
       index 和 otherIndex 可以传相同的数值
 */
- (void)hy_exchangeObjectAtIndex:(NSUInteger)index withObjectAtIndex:(NSUInteger)otherIndex;

/**
 本身被反向、倒序
 */
- (void)hy_reverse;

@end

NS_ASSUME_NONNULL_END
