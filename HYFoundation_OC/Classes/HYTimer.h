//
//  HYTimer.h
//  StudyRunloop
//
//  Created by ocean on 2019/5/29.
//  Copyright © 2019 ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 使用步骤:
 ==========================================
 一、创建，返回的key需要保存，用于后面的取消操作
 self.timerKey = [HYTimer timerWithStart:0 interval:1 repeats:YES queue:nil block:^{
    NSLog(@"222222");
    NSLog(@"%@", [NSThread currentThread]);
 }];
 
 ==========================================
 二、dealloc 方法中取消定时器
 
 - (void)dealloc {
    [HYTimer cancelTimer:self.timerKey];
 }
 
 */

@interface HYTimer : NSObject

/**
 创建一个定时器

 @param start 定时器开始时间，相对于 “现在” 的偏移量；单位：秒；
                <=0 会立即执行 block;
                >0 会延时 start 秒执行 block;
 @param interval 每隔 interval 秒执行一次 block
                <=0 会间隔很短调用，谨慎设置;
                >0 正确设置;
 @param repeats 是否重复调用 block
 @param queue block 运行的队列; nil 会运行在主队列
 @param block 回调
 @return 定时器timer对应的唯一标识key
 */
+ (NSString *)timerWithStart:(NSTimeInterval)start
                    interval:(NSTimeInterval)interval
                     repeats:(BOOL)repeats
                       queue:(nullable dispatch_queue_t)queue
                       block:(void (^)(void))block;


/**
 根据传入的 name 作为 key 取消对应的定时器

 @param name 定时器的key
 */
+ (void)cancelTimer:(NSString *)name;

/**
 取消所有的定时器
 */
+ (void)cancelAll;

@end

NS_ASSUME_NONNULL_END
