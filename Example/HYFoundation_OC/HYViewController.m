//
//  HYViewController.m
//  HYFoundation_OC
//
//  Created by oceanfive on 10/11/2018.
//  Copyright (c) 2018 oceanfive. All rights reserved.
//

#import "HYViewController.h"
#import "MyLog.h"
#import "HYLog.h"

@interface HYViewController ()

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%d", __LINE__);
    NSLog(@"%s", __FILE__);
//    size_t size = sizeof(Byte);
//    NSLog(@"%@", @(size));
//
//    NSLog(@"");
//
    
//    NSLog(@"====");
////    [MyLog log:@"%@", @"hello", @"world", @"nice", nil];
//    NSLog(@"====");
//    MyLogOutput(@"%@", @"hello", @"world", @"nice", nil);
//
//    NSLog(@"[%@] [%@] %@" , @"warn", @"network", @(100));
//
//    printf("0000000");
//
//    NSLog(@"---");
    
//    NSLog(@"%@ - %@", @"hello", @"world");
//    NSLog(@"%@", @"hello", @"-%@", @"world");
    
    
    HYLog(HYLogLevelError, @"network", @"%@ - %@", @"这是一个错误信息", @"hello");
    HYLogV(@"iOS", @"%@ - %@", @"hello", @"world");
    HYLogD(@"iOS", @"%@ - %@", @"hello", @"world");
    HYLogI(@"iOS", @"%@ - %@", @"hello", @"world");
    HYLogW(@"iOS", @"%@ - %@", @"hello", @"world");
    HYLogE(@"iOS", @"%@ - %@", @"hello", @"world");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
