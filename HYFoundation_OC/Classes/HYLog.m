//
//  HYLog.m
//  HYFoundation_OC_Example
//
//  Created by ocean on 2019/3/27.
//  Copyright © 2019 oceanfive. All rights reserved.
//

#import "HYLog.h"

NSString * HYStringForLevel(HYLogLevel level) {
    switch (level) {
        case HYLogLevelError:
            return @"Error";
            break;
        case HYLogLevelWarn:
            return @"Warn";
            break;
        case HYLogLevelInfo:
            return @"Info";
            break;
        case HYLogLevelDebug:
            return @"Debug";
            break;
        default:
            return @"Verbose";
            break;
    }
}

void HYLog(HYLogLevel level, NSString *tag, NSString *format, ...) {
#ifdef DEBUG
    if (format) {
        // 构建自定义的格式
        format = [NSString stringWithFormat:@"[%@] [%@] %@", HYStringForLevel(level), tag, format];
        
        va_list arguments;
        va_start(arguments, format);
        NSLogv(format, arguments);
        va_end(arguments);
    }
#endif
}

void HYLogV(NSString *tag, NSString *format, ...) {
#ifdef DEBUG
    if (format) {
        // 构建自定义的格式
        format = [NSString stringWithFormat:@"[%@] [%@] %@", HYStringForLevel(HYLogLevelVerbose), tag, format];
        
        va_list arguments;
        va_start(arguments, format);
        NSLogv(format, arguments);
        va_end(arguments);
    }
#endif
}

void HYLogD(NSString *tag, NSString *format, ...) {
#ifdef DEBUG
    if (format) {
        // 构建自定义的格式
        format = [NSString stringWithFormat:@"[%@] [%@] %@", HYStringForLevel(HYLogLevelDebug), tag, format];
        
        va_list arguments;
        va_start(arguments, format);
        NSLogv(format, arguments);
        va_end(arguments);
    }
#endif
}


void HYLogI(NSString *tag, NSString *format, ...) {
#ifdef DEBUG
    if (format) {
        // 构建自定义的格式
        format = [NSString stringWithFormat:@"[%@] [%@] %@", HYStringForLevel(HYLogLevelInfo), tag, format];
        
        va_list arguments;
        va_start(arguments, format);
        NSLogv(format, arguments);
        va_end(arguments);
    }
#endif
}

void HYLogW(NSString *tag, NSString *format, ...) {
#ifdef DEBUG
    if (format) {
        // 构建自定义的格式
        format = [NSString stringWithFormat:@"[%@] [%@] %@", HYStringForLevel(HYLogLevelWarn), tag, format];
        
        va_list arguments;
        va_start(arguments, format);
        NSLogv(format, arguments);
        va_end(arguments);
    }
#endif
}

void HYLogE(NSString *tag, NSString *format, ...) {
#ifdef DEBUG
    if (format) {
        // 构建自定义的格式
        format = [NSString stringWithFormat:@"[%@] [%@] %@", HYStringForLevel(HYLogLevelError), tag, format];
        
        va_list arguments;
        va_start(arguments, format);
        NSLogv(format, arguments);
        va_end(arguments);
    }
#endif
}

/**
 FOUNDATION_EXPORT void NSLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2) NS_NO_TAIL_CALL;
 FOUNDATION_EXPORT void NSLogv(NSString *format, va_list args) NS_FORMAT_FUNCTION(1,0) NS_NO_TAIL_CALL;
 */
