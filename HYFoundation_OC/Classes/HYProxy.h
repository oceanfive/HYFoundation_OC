//
//  HYProxy.h
//  StudyRunloop
//
//  Created by ocean on 2019/5/28.
//  Copyright © 2019 ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYProxy : NSProxy

/**
 解决 NSTimer 、CADisplayLink 强引用导致循环引用而导致无法释放的问题
 
 使用步骤:
 =====================================================================
 一、NSTimer 正常使用，只不过 target 更换为 [HYProxy proxyWithTarget:self]，这里的 self 为 UIViewController
 
 self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[HYProxy proxyWithTarget:self] selector:@selector(msg) userInfo:nil repeats:YES];
 
 =====================================================================
 二、定时器调用的方法
 
 - (void)msg {
    NSLog(@"%s", __func__);
 }
 
 =====================================================================
 三、dealloc 方法中 invalidate 无效定时器
 (正常情况下dealloc中调用invalidate是无法释放控制器的，这里使用了 weak 引用 target 和 runtime 的消息转发 forwarding 技术实现)
 
 - (void)dealloc {
    NSLog(@"%s", __func__);
    [self.timer invalidate];
 }
 
 */
+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
