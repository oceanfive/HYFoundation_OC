//
//  HYMath.m
//  HYFoundation
//
//  Created by ocean on 2018/7/10.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "HYMath.h"
#import <math.h>

@implementation HYMath

+ (double)hy_radiansFromDegrees:(double)degrees {
    return degrees * M_PI / 180;
}

@end
