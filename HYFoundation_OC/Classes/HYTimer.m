//
//  HYTimer.m
//  StudyRunloop
//
//  Created by ocean on 2019/5/29.
//  Copyright © 2019 ocean. All rights reserved.
//

#import "HYTimer.h"

static NSMutableDictionary *mTimers;
static dispatch_semaphore_t mLocker;

#define HYTimerLOCK dispatch_semaphore_wait(mLocker, DISPATCH_TIME_FOREVER);
#define HYTimerUNLOCK dispatch_semaphore_signal(mLocker);

@implementation HYTimer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mTimers = [NSMutableDictionary dictionary];
        mLocker = dispatch_semaphore_create(1);
    });
}

+ (NSString *)timerWithStart:(NSTimeInterval)start
                    interval:(NSTimeInterval)interval
                     repeats:(BOOL)repeats
                       queue:(dispatch_queue_t)queue
                       block:(void (^)(void))block {
    
    dispatch_queue_t mQueue = queue ? queue : dispatch_get_main_queue();
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mQueue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    // 多线程安全，允许多个定时器同时创建
    HYTimerLOCK;
    NSString *key = [NSString stringWithFormat:@"hytimer_%@", @(mTimers.count)];
    [mTimers setObject:timer forKey:key];
    HYTimerUNLOCK;
    
    dispatch_source_set_event_handler(timer, ^{
        if (block) {
            block();
        }
        if (!repeats) {
            [self cancelTimer:key];
        }
    });
    dispatch_resume(timer);
    
    return key;
}

+ (void)cancelTimer:(NSString *)name {
    if (name.length <= 0) return;
    HYTimerLOCK;
    dispatch_source_t timer = [mTimers objectForKey:name];
    HYTimerUNLOCK;
    if (!timer) return;
    dispatch_cancel(timer);
}

+ (void)cancelAll {
    if (mTimers.allKeys.count > 0) {
        for (NSString *key in mTimers.allKeys) {
            [self cancelTimer:key];
        }
    }
}

@end
