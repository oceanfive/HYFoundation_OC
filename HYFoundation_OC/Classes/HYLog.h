//
//  HYLog.h
//  HYFoundation_OC_Example
//
//  Created by ocean on 2019/3/27.
//  Copyright © 2019 oceanfive. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Log级别

 - HYLogLevelVerbose: Verbose
 - HYLogLevelDebug: Debug
 - HYLogLevelInfo: Info
 - HYLogLevelWarn: Warn
 - HYLogLevelError: Error
 */
typedef NS_ENUM(NSUInteger, HYLogLevel) {
    HYLogLevelVerbose,
    HYLogLevelDebug,
    HYLogLevelInfo,
    HYLogLevelWarn,
    HYLogLevelError,
};

/**
 打印log输出，这个函数会 "重新构建format" ，最后调用 NSLogv 输出

 @param level HYLogLevel
 @param tag 标签
 @param format 格式
 @param ... 传递的参数
 */
void HYLog(HYLogLevel level, NSString *tag, NSString *format, ...) NS_FORMAT_FUNCTION(3,4) NS_NO_TAIL_CALL;

/// level = HYLogLevelVerbose
void HYLogV(NSString *tag, NSString *format, ...) NS_FORMAT_FUNCTION(2,3) NS_NO_TAIL_CALL;
/// level = HYLogLevelDebug
void HYLogD(NSString *tag, NSString *format, ...) NS_FORMAT_FUNCTION(2,3) NS_NO_TAIL_CALL;
/// level = HYLogLevelInfo
void HYLogI(NSString *tag, NSString *format, ...) NS_FORMAT_FUNCTION(2,3) NS_NO_TAIL_CALL;
/// level = HYLogLevelWarn
void HYLogW(NSString *tag, NSString *format, ...) NS_FORMAT_FUNCTION(2,3) NS_NO_TAIL_CALL;
/// level = HYLogLevelError
void HYLogE(NSString *tag, NSString *format, ...) NS_FORMAT_FUNCTION(2,3) NS_NO_TAIL_CALL;


NS_ASSUME_NONNULL_END
