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


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif


@interface HYViewController ()

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self studyOne];
    [self studyArray];
    
//    NSLog(@"%s", __FUNCTION__);
//    NSLog(@"%d", __LINE__);
//    NSLog(@"%s", __FILE__);
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
    
    
//    HYLog(HYLogLevelError, @"network", @"%@ - %@", @"这是一个错误信息", @"hello");
//    HYLogV(@"iOS", @"%@ - %@", @"hello", @"world");
//    HYLogD(@"iOS", @"%@ - %@", @"hello", @"world");
//    HYLogI(@"iOS", @"%@ - %@", @"hello", @"world");
//    HYLogW(@"iOS", @"%@ - %@", @"hello", @"world");
//    HYLogE(@"iOS", @"%@ - %@", @"hello", @"world");
//
//    NSLog(@"%s", __TIME__);
//    NSLog(@"%s", __TIMESTAMP__);
//
//    NSLog(@"====");
//
//
//    NSInteger a = 12;
//    NSLog(@"%ld -- %lx", a, a);
//    // 12 -- c
    
}

- (void)studyArray {
//    int a = 100;
//    int b = 10000000000;

//    double a = 10.001;
//    float b = a;
    
//    char a = 'a';
//    unichar b = '0';

//
//    float score = 91.0f;
//    if (score >= 90) {
//        NSLog(@"成绩很棒哟~");
//    }
//
//    if (score >= 90) {
//        NSLog(@"成绩很棒哟~");
//    } else {
//        NSLog(@"成绩还可以~");
//    }
//
//
//    // 多分支
//    if (score >= 90) {
//        NSLog(@"A");
//    } else if (score >= 80) {
//        NSLog(@"B");
//    } else if (score >= 70) {
//        NSLog(@"C");
//    } else if (score >= 60) {
//        NSLog(@"D");
//    } else {
//        NSLog(@"E");
//    }
//
    
//    int weekday = 1;
//    switch (weekday) {
//        case 1:
//            NSLog(@"星期一");
//            break;
//        case 2:
//            NSLog(@"星期二");
//            break;
//        case 3:
//            NSLog(@"星期三");
//            break;
//        case 4:
//            NSLog(@"星期四");
//            break;
//        case 5:
//            NSLog(@"星期五");
//            break;
//        case 6:
//            NSLog(@"星期六");
//            break;
//        case 7:
//            NSLog(@"星期天");
//            break;
//        default:
//            NSLog(@"未知!!!");
//            break;
//    }
//
    

//    for (int i = 0; i < 5; i++) {
//        NSLog(@"%@", @(i));
//    }

//    int a = 5;
//    while (a > 0) {
//        NSLog(@"%@", @(a));
//        a--;
//    }
//
    int a = 5;
    do {
        NSLog(@"%@", @(a));
        a--;
    } while (a > 0);
    
    
    NSLog(@"====");
}

- (void)studyOne {
//    NSString *str = @" \r \n \f \t \v  hel\rlo \r \n \f \t \v ";
//    NSString *result = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSLog(@"%@", result);
    
    NSString *string = @"hello world! 你好呀";
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"one.txt"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error = nil;
    [string writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"error: %@", error);
    
    return;
    
//    NSString *str = @"hello world！ 你好呀";
//    NSLog(@"decomposedStringWithCanonicalMapping:%@", str.decomposedStringWithCanonicalMapping);
//    NSLog(@"precomposedStringWithCanonicalMapping:%@", str.precomposedStringWithCanonicalMapping);
//    NSLog(@"decomposedStringWithCompatibilityMapping:%@", str.decomposedStringWithCompatibilityMapping);
//    NSLog(@"precomposedStringWithCompatibilityMapping:%@", str.precomposedStringWithCompatibilityMapping);
//
//
//    return;
    
    
//    NSString *string = @"hello world! 你好呀👿";
//    NSLog(@"%@", @(string.length)); // 18

//    NSString *str1 = @"hello world!";
//
//    NSRange range = [str1 rangeOfString:@"l"];
//    NSRange range2 = [str1 rangeOfString:@"l" options:NSBackwardsSearch];
//
//    NSLog(@"%@", NSStringFromRange(range)); // {2, 1}
//    NSLog(@"%@", NSStringFromRange(range2)); // {9, 1}
//    return;
    
    NSMutableDictionary *unicodeDict = [NSMutableDictionary dictionary];
    for (unichar i = 0; i < 32768; i++) {
        NSLog(@"=====");
        NSString *string = [[NSString alloc] initWithCharacters:&i length:1];
        NSLog(@"%@ - %@", @(i), string);
        [unicodeDict setObject:string ? string : [NSNull null] forKey:@(i)];
        
//        //  L*, M*, and N*
//        NSCharacterSet *alphanumericCharacterSet = [NSCharacterSet alphanumericCharacterSet];
//        if ([alphanumericCharacterSet characterIsMember:i]) {
//            NSLog(@"alphanumericCharacterSet: 是 - %@ - %@", @(i), string);
//        } else {
//            NSLog(@"alphanumericCharacterSet: 否 ");
//        }
//
//        // Lt
//        NSCharacterSet *capitalizedLetterCharacterSet = [NSCharacterSet capitalizedLetterCharacterSet];
//        if ([capitalizedLetterCharacterSet characterIsMember:i]) {
//            NSLog(@"capitalizedLetterCharacterSet: 是 - %@ - %@", @(i), string);
//        } else {
//            NSLog(@"capitalizedLetterCharacterSet: 否 ");
//        }
        
        NSCharacterSet *decimalDigitCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
        if ([decimalDigitCharacterSet characterIsMember:i]) {
            NSLog(@"decimalDigitCharacterSet: 是 - %@ - %@", @(i), string);
        } else {
            NSLog(@"decimalDigitCharacterSet: 否 ");
        }
    }
    NSLog(@"end ===");
    NSLog(@"%@", unicodeDict);
    
//    [NSCharacterSet URLHostAllowedCharacterSet]
    
//    NSString *string = @"hello \r world! \n nice to \r\n meet you!";
//    [string enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
//        NSLog(@"%@", line);
//
//    }];
    
//    NSString *string = @"hello world! nǐ hǎo ya！";//@"hello world! 你好呀！";
//
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:NSStringTransformLatinToKatakana];
//    [array addObject:NSStringTransformLatinToHiragana];
//    [array addObject:NSStringTransformLatinToHangul];
//    [array addObject:NSStringTransformLatinToArabic];
//    [array addObject:NSStringTransformLatinToHebrew];
//    [array addObject:NSStringTransformLatinToThai];
//    [array addObject:NSStringTransformLatinToCyrillic];
//    [array addObject:NSStringTransformLatinToGreek];
//    [array addObject:NSStringTransformToLatin];
//    [array addObject:NSStringTransformMandarinToLatin];
//    [array addObject:NSStringTransformFullwidthToHalfwidth];
//    [array addObject:NSStringTransformToXMLHex];
//    [array addObject:NSStringTransformToUnicodeName];
//    [array addObject:NSStringTransformStripCombiningMarks];
//    [array addObject:NSStringTransformStripDiacritics];
//
//    for (NSString *str in array) {
//        NSLog(@"=========");
//        NSString *result = [string stringByApplyingTransform:str reverse:NO];
//        NSLog(@"NSStringTransform: %@", str);
//        NSLog(@"result: %@", result);
//        NSLog(@"result2: %@", [string stringByApplyingTransform:str reverse:YES]);
//    }
//
//
//    NSLog(@"----");
//    NSLog(@"%@", [self pinYinWithString:string]);
//
    
//    const NSStringEncoding *encodings = [NSString availableStringEncodings];
//    NSLog(@"%@", @(*encodings));
//    BOOL result = *encodings & NSASCIIStringEncoding;
//    NSLog(@"%@", @(result));
    
//    NSString *string = @"hello world!";
//
//    NSLog(@"=====");
//
//    NSStringEncoding encoding = NSUTF8StringEncoding;
//    BOOL result = [string canBeConvertedToEncoding:encoding];
//    NSLog(@"%@: %@", [NSString localizedNameOfStringEncoding:encoding], @(result));
//    if (result) {
//        NSLog(@"cString: %s", [string cStringUsingEncoding:encoding]);
//        NSLog(@"data: %@", [string dataUsingEncoding:encoding]);
//    }
//
//    NSLog(@"=====");
//
//    encoding = NSASCIIStringEncoding;
//    result = [string canBeConvertedToEncoding:encoding];
//    NSLog(@"%@: %@", [NSString localizedNameOfStringEncoding:encoding], @(result));
//    if (result) {
//        NSLog(@"cString: %s", [string cStringUsingEncoding:encoding]);
//        NSLog(@"data: %@", [string dataUsingEncoding:encoding]);
//    }
//
//    NSLog(@"=====");
//
//    encoding = NSUnicodeStringEncoding;
//    result = [string canBeConvertedToEncoding:encoding];
//    NSLog(@"%@: %@", [NSString localizedNameOfStringEncoding:encoding], @(result));
//    if (result) {
//        NSLog(@"cString: %s", [string cStringUsingEncoding:encoding]);
//        NSLog(@"data: %@", [string dataUsingEncoding:encoding]);
//
//        NSData *data = [string dataUsingEncoding:encoding];
//        NSLog(@"NSUTF8StringEncoding: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        NSLog(@"NSUnicodeStringEncoding: %@", [[NSString alloc] initWithData:data encoding:NSUnicodeStringEncoding]);
//        NSLog(@"NSUTF32StringEncoding: %@", [[NSString alloc] initWithData:data encoding:NSUTF32StringEncoding]);
//    }
//

    
    
//    NSString *str = @"你好，世界！";
//    unichar character = [str characterAtIndex:0];
//    NSLog(@"%@", @(character));
//    // 输出 20320 ，转换为十六进制为 0x4F60 ，对应的unicode编码为 \u4f60
//    NSString *result = [[NSString alloc] initWithCharacters:&character length:1];
//    NSLog(@"%@", result);
    
    
//    NSString *str = @"hello world";
//    NSString *result = [str stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@"+"];
//    NSLog(@"%@", result);
    
    
    int a = 10;
    a += 10;
    a -= 1;
    a *= 2;
    a /= 4;
    a %= 6;
    
    
//    int a = 10;
//    int b = 20;
//
//    NSLog(@"%@", @(a + b)); // 30
//    NSLog(@"%@", @(a - b)); // -10
//    NSLog(@"%@", @(a * b)); // 200
//    NSLog(@"%@", @(a / b)); // 0
//    NSLog(@"%@", @((float)a / b));  // 0.5
//    NSLog(@"%@", @(a / (float)b));  // 0.5
//    NSLog(@"%@", @(a % b)); // 10
//    NSLog(@"%@", @(a++));   // 10 （先运算再自增1）
//    NSLog(@"%@", @(++a));   // 12 （先自增1再运算）
//    NSLog(@"%@", @(b--));   // 20 （先运算再自减1）
//    NSLog(@"%@", @(--b));   // 18 （先自减1再运算）
//
//    /**
//     +: 30
//     -: -10
//     *: 200
//     /: 0
//     %: 10
//     ++: 10
//     ++2: 12
//     --: 20
//     --2: 18
//     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)pinYinWithString:(NSString *)chinese{
    NSString  * pinYinStr = [NSString string];
    if (chinese.length){
        NSMutableString * pinYin = [[NSMutableString alloc]initWithString:chinese];
        
        //先转换为带声调的拼音
        if (CFStringTransform((__bridge CFMutableStringRef)pinYin, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"pinyin: %@", pinYin);
        }
        
        //再转换为不带声调的拼音
        if (CFStringTransform((__bridge CFMutableStringRef)pinYin, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"pinyin: %@", pinYin);
            
            //再去除空格，将拼音连在一起
            pinYinStr = [NSString stringWithString:pinYin];
            
            // 去除掉首尾的空白字符和换行字符
            pinYinStr = [pinYinStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            // 去除掉其它位置的空白字符和换行字符
            pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
    }
    return pinYinStr;
}



@end
