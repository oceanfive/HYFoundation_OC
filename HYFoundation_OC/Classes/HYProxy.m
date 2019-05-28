//
//  HYProxy.m
//  StudyRunloop
//
//  Created by ocean on 2019/5/28.
//  Copyright © 2019 ocean. All rights reserved.
//

#import "HYProxy.h"

@interface HYProxy ()

@property (nonatomic, weak) id mTarget;

@end

@implementation HYProxy

+ (instancetype)proxyWithTarget:(id)target {
    HYProxy *proxy = [HYProxy alloc];
    proxy.mTarget = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.mTarget methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.mTarget];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
