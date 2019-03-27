//
//  MyLog.h
//  HYFoundation_OC_Example
//
//  Created by ocean on 2019/3/26.
//  Copyright © 2019 oceanfive. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void MyLogOutput(NSString *format, ...) NS_NO_TAIL_CALL;

@interface MyLog : NSObject

+ (void)log:(NSString *)format, ... NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
