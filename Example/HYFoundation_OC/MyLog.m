//
//  MyLog.m
//  HYFoundation_OC_Example
//
//  Created by ocean on 2019/3/26.
//  Copyright © 2019 oceanfive. All rights reserved.
//

#import "MyLog.h"

void MyLogOutput(NSString *format, ...) {
    if (format) {
        NSLog(@"format: %@", format);
        
        va_list arguments;
        va_start(arguments, format);
        
        id obj;
        
        while (1) {
            obj = va_arg(arguments, id);
            if (obj) {
                NSLog(@"obj: %@", obj);
            } else {
                NSLog(@"end ====");
                break;
            }
        }
        va_end(arguments);
    }
}


@implementation MyLog


+ (void)log:(NSString *)format, ... {
    if (format) {
        NSLog(@"format: %@", format);

        va_list arguments;
        va_start(arguments, format);
        
        id obj;
        
        while (1) {
            obj = va_arg(arguments, id);
            if (obj) {
                NSLog(@"obj: %@", obj);
            } else {
                NSLog(@"end ====");
                break;
            }
        }
        va_end(arguments);
    }
}

@end
