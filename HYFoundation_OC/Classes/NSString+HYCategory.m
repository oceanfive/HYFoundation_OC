//
//  NSString+HYCategory.m
//  Category
//
//  Created by wuhaiyang on 16/9/12.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "NSString+HYCategory.h"
#import "NSObject+HYCategory.h"
#import "NSData+HYCategory.h"
#import "NSNumberFormatter+HYCategory.h"
#import "NSCharacterSet+HYCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSDictionary+HYCategory.h"

NSString *const HYRegexComponentKey = @"component";
NSString *const HYRegexComponentRangeKey = @"componentRange";




// ----- 代码来源 AFNetworking (https://github.com/AFNetworking/AFNetworking.git)

/**
 Returns a percent-escaped string following RFC 3986 for a query string key or value.
 RFC 3986 states that the following characters are "reserved" characters.
 - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
 - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
 
 In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
 query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
 should be percent-escaped in the query string.
 - parameter string: The string to be percent-escaped.
 - returns: The percent-escaped string.
 */
NSString * AFPercentEscapedStringFromString(NSString *string) {
    static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    
    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < string.length) {
        NSUInteger length = MIN(string.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}

#pragma mark -

@interface AFQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (instancetype)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValue;
@end

@implementation AFQueryStringPair

- (instancetype)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.field = field;
    self.value = value;
    
    return self;
}

- (NSString *)URLEncodedStringValue {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return AFPercentEscapedStringFromString([self.field description]);
    } else {
        return [NSString stringWithFormat:@"%@=%@", AFPercentEscapedStringFromString([self.field description]), AFPercentEscapedStringFromString([self.value description])];
    }
}

@end

FOUNDATION_EXPORT NSArray * AFQueryStringPairsFromDictionary(NSDictionary *dictionary);
FOUNDATION_EXPORT NSArray * AFQueryStringPairsFromKeyAndValue(NSString *key, id value);

NSString * AFQueryStringFromParameters(NSDictionary *parameters) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (AFQueryStringPair *pair in AFQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValue]];
    }
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

NSArray * AFQueryStringPairsFromDictionary(NSDictionary *dictionary) {
    return AFQueryStringPairsFromKeyAndValue(nil, dictionary);
}

NSArray * AFQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = dictionary[nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[AFQueryStringPair alloc] initWithField:key value:value]];
    }
    
    return mutableQueryStringComponents;
}

// ----- 代码来源 AFNetworking (https://github.com/AFNetworking/AFNetworking.git)




@implementation NSString (HYCategory)

+ (BOOL)hy_isNullString:(NSString *)string {
    if (string == nil ||
        string.length == 0 ||
        [string isEqualToString:@"NULL"] ||
        [string isEqualToString:@"Null"] ||
        [string isEqualToString:@"null"] ||
        [string isEqualToString:@"(NULL)"] ||
        [string isEqualToString:@"(Null)"] ||
        [string isEqualToString:@"(null)"] ||
        [string isEqualToString:@"<NULL>"] ||
        [string isEqualToString:@"<Null>"] ||
        [string isEqualToString:@"<null>"] ||
        [string isKindOfClass:[NSNull class]] ||
        string == NULL) {
        return YES;
    }
    return NO;
}

+ (NSString *)hy_getNullString {
    return @"";
}

#pragma mark - Range
- (NSRange)hy_range {
    if ([NSString hy_isNullString:self]) return NSMakeRange(NSNotFound, 0);
    return NSMakeRange(0, self.length);
}

- (CGSize)hy_getSizeAtArea:(CGSize)area parameters:(NSDictionary *)parameters {
    if ([NSObject hy_isNull:parameters]) return CGSizeZero;
    return [self boundingRectWithSize:area options:NSStringDrawingUsesLineFragmentOrigin attributes:parameters context:nil].size;
}

- (CGSize)hy_getSizeAtMaxAreaWithparameters:(NSDictionary *)parameters {
    return [self hy_getSizeAtArea:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) parameters:parameters];
}

- (CGSize)hy_getSizeAtArea:(CGSize)area font:(UIFont *)font color:(UIColor *)color {
    return [self hy_getSizeAtArea:area parameters:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
}

- (CGSize)hy_getSizeAtMaxAreaWithFont:(UIFont *)font color:(UIColor *)color {
    return [self hy_getSizeAtArea:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:font color:color];
}


- (NSNumber *)hy_numberValue {
    NSMutableCharacterSet *set = [NSMutableCharacterSet decimalDigitCharacterSet];
    [set addCharactersInString:@"."];
    NSString *temp = [self hy_stringByTrimmingCharactersInSet:[set invertedSet] isAll:YES];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [temp length] == 0 ? nil : [numberFormatter numberFromString:temp];
}


- (NSString *)hy_stringByTrimmingCharactersInSet:(NSCharacterSet *)set isAll:(BOOL)isAll {
    if (isAll) {
        NSMutableString *string = [NSMutableString string];
        for (NSUInteger i = 0; i < self.length; i++) {
            unichar ch = [self characterAtIndex:i];
            if (![set characterIsMember:ch]) {
                [string appendString:[NSString stringWithUTF8String:(char *)&ch]];
            }
        }
        return string;
    } else {
        return [self stringByTrimmingCharactersInSet:set];
    }
}

- (NSString *)hy_stringByTrimmingCharactersInSet:(NSCharacterSet *)set limitLength:(NSUInteger)limit {
    NSString *str = [self hy_stringByTrimmingCharactersInSet:set isAll:YES];
    return str.length > limit ? [str substringToIndex:limit] : str;
}


+ (NSString *)hy_stringByASCIIIndex:(unichar)index {
    return [NSString stringWithUTF8String:(char *)&index];
}

+ (unichar)hy_indexByASCIIString:(NSString *)string {
    if ([NSString hy_isNullString:string]) return HYUnicharNotFound;
    return [string characterAtIndex:0];
}

- (NSString *)hy_ASCIICharacter {
    if ([NSString hy_isNullString:self]) return nil;
    return [self substringToIndex:1];
}

- (unichar)hy_ASCIIIndex {
    if ([NSString hy_isNullString:self]) return HYUnicharNotFound;
    return [self characterAtIndex:0];
}

#pragma mark - substring

- (NSString *)hy_substringFromIndex:(NSUInteger)from {
    if (from < 0 || from > self.length - 1) return [NSString hy_getNullString];
    return [self substringFromIndex:[self rangeOfComposedCharacterSequenceAtIndex:from].location];
}

- (NSString *)hy_substringToIndex:(NSUInteger)to {
    if (to < 0 || to > self.length) return [NSString hy_getNullString];
    // 过滤 to == self.length 的情况
    if (to == self.length) {
        return [self substringToIndex:to];
    }
    // [0, length) 范围内的index ，to == self.length 会crash
    NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:to];
    return [self substringToIndex:range.length == 1 ? range.location : to == range.location ? range.location : NSMaxRange(range)];
    // length 不为 1 表示需要多个字符组合才能构成该子字符串，需要获取到显示完全的真正范围
    // 组合显示的字符 “开始位置”的处理，不包含
}

- (NSString *)hy_substringWithRange:(NSRange)range {
    if (range.length < 1) return [NSString hy_getNullString];
    if (range.location < 0 || range.location > self.length - 1) return [NSString hy_getNullString];
    if (NSMaxRange(range) > self.length) {
        return [NSString hy_getNullString];
    }
    return [self substringWithRange:[self rangeOfComposedCharacterSequencesForRange:range]];
}

- (NSString *)hy_stringAtFirst {
    return [self hy_substringToIndex:1];
}

- (NSString *)hy_stringAtLast {
    return [self hy_substringFromIndex:self.length - 1];
}

- (NSString *)hy_stringAtIndex:(NSUInteger)index {
    if (index >= self.length) return [NSString hy_getNullString];
    return [self hy_substringWithRange:NSMakeRange(index, 1)];
}

- (NSString *)hy_stringInRange:(NSRange)range {
    return [self hy_substringWithRange:range];
}

- (unichar)hy_characterAtIndex:(NSUInteger)index {
    if (index >= self.length) return HYUnicharNotFound;
    return [self characterAtIndex:index];
}

- (unichar)hy_characterAtFirst {
    return [self hy_characterAtIndex:0];
}

- (unichar)hy_characterAtLast {
    return [self hy_characterAtIndex:self.length - 1];
}


#pragma mark - 是否包含子字符串
- (BOOL)hy_containsString:(NSString *)string {
    if ([NSString hy_isNullString:string] || [NSString hy_isNullString:self]) return NO;
    return [self containsString:string];
}

#pragma mark - 暂不使用 -----------------------------------
#pragma mark - 判断是否含有emoji表情
+ (BOOL)hy_stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

#pragma mark - 过滤emoji表情
- (instancetype)hy_removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring hy_isEmoji])? @"": substring];
                          }];
    return buffer;
}

#pragma mark - 是不是emoji表情
- (BOOL)hy_isEmoji {
    const unichar high = [self characterAtIndex: 0];
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}
#pragma mark - 暂不使用 -----------------------------------


#pragma mark - 写入和读取
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return NO;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self writeToFile:name atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (instancetype)hy_stringWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return nil;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [NSString stringWithContentsOfFile:name encoding:NSUTF8StringEncoding error:nil];
}

#pragma mark - 去掉首位0的情况


#pragma mark - NSString 和 NSDictionary 互转
+ (NSString *)hy_stringFromDictionary:(NSDictionary *)dictionary {
    NSData *data = [NSData hy_dataFromDictionary:dictionary];
    return [NSData hy_stringFromData:data];
}

+ (NSDictionary *)hy_dictionaryFromString:(NSString *)string {
    NSData *data = [NSData hy_dataFromString:string];
    return [NSData hy_dictionaryFromData:data];
}

- (NSDictionary *)hy_dictionaryValue {
    return [NSString hy_dictionaryFromString:self];
}

#pragma mark - NSString 和 NSData 互转
- (NSData *)hy_dataValue {
    return [NSData hy_dataFromString:self];
}

#pragma mark - NSString 和 NSArray 互转
- (NSArray *)hy_arrayValue {
    NSData *data = [NSData hy_dataFromString:self];
    return [NSData hy_arrayFromData:data];
}


#pragma mark - NSString 和 c语言string 互转
+ (NSString *)hy_stringFromCString:(const char *)cString {
    if (cString == nil || cString == NULL) return nil;
    return [NSString stringWithUTF8String:cString];
}

+ (const char *)hy_cStringFromString:(NSString *)string {
    if ([NSString hy_isNull:string]) return nil;
    return [string cStringUsingEncoding:NSUTF8StringEncoding];
}

- (const char *)cString {
    return [NSString hy_cStringFromString:self];
}

#pragma mark - 四舍五入相关处理
- (NSString *)hy_roundedWithRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale fullPrecision:(BOOL)precision {
    if ([NSString hy_isNull:self]) return nil;
    NSDecimalNumberHandler *handler;
    if (precision) {
        handler = [NSDecimalNumberHandler defaultDecimalNumberHandler];
    } else {
        handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    }
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *result = [number decimalNumberByRoundingAccordingToBehavior:handler];
    return result.stringValue;
}

#pragma mark - 富文本
- (NSAttributedString *)hy_attributedStringWithAttributes:(nullable NSDictionary<NSString *, id> *)attrs {
    if ([NSString hy_isNullString:self] ||
        [NSObject hy_isNull:attrs]) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:self attributes:attrs];
}

- (NSAttributedString *)hy_attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    if (font) [att setObject:font forKey:NSFontAttributeName];
    if (textColor) [att setObject:textColor forKey:NSForegroundColorAttributeName];
    return [self hy_attributedStringWithAttributes:att];
}

- (NSAttributedString *)hy_strikethroughAttributedString {
    NSDictionary *att = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)};
    return [self hy_attributedStringWithAttributes:att];
}

- (NSAttributedString *)hy_strikethroughAttributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    NSDictionary *att = @{
                          NSFontAttributeName:font,
                          NSForegroundColorAttributeName:textColor,
                          NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)
                          };
    return [self hy_attributedStringWithAttributes:att];
}

#pragma mark - 货币，价格，显示
- (NSString *)hy_currencyString {
    if ([NSString hy_isNullString:self]) return nil;
    return [NSString stringWithFormat:@"¥%.2f", [[self hy_numberValue] doubleValue]];
    //注：用下面的方法会导致价格中间的删除线没法显示出来！！！
//    NSNumberFormatter *currencyFormatter = [NSNumberFormatter hy_currencyFormatter];
//    return [currencyFormatter stringFromNumber:[self hy_numberValue]];
}

#pragma mark - 商品价格，原价、折扣价
- (NSString *)hy_originalPriceString {
    return [self hy_currencyString];
}

- (NSAttributedString *)hy_originalPriceStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [[self hy_currencyString] hy_attributedStringWithFont:font textColor:textColor];
}

- (NSAttributedString *)hy_discountPriceString {
    return [[self hy_currencyString] hy_strikethroughAttributedString];
}

- (NSAttributedString *)hy_discountPriceStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    NSAttributedString *price = [self hy_discountPriceString];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:price];
    if (font) {
        [att addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, price.string.length)];
    }
    if (textColor) {
        [att addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, price.string.length)];
    }
    return att;
}

#pragma mark - 正则表达式
- (BOOL)hy_isMatchedRegex:(NSString *)regex {
    if ([NSString hy_isNullString:regex]) return NO;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)hy_isMatchedRegexType:(HYRegexType)regexType {
    return [self hy_isMatchedRegex:[self hy_getRegexByType:regexType]];
}

- (NSArray<NSDictionary *> *)hy_matchesOfRegex:(NSString *)regex {
    if ([NSString hy_isNullString:regex]) return nil;
    NSError *error = nil;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:regex options:0 error:&error];
    if (error) return nil;
    NSArray *array = [regular matchesInString:self options:0 range:self.hy_range];
    if ([NSObject hy_isNull:array]) return nil;
    NSMutableArray *matches = [NSMutableArray array];
    for (NSTextCheckingResult *result in array) {
        if (result.resultType == NSTextCheckingTypeRegularExpression) {
            NSMutableDictionary *component = [NSMutableDictionary dictionary];
            [component setObject:[NSValue valueWithRange:result.range] forKey:HYRegexComponentRangeKey];
            [component setObject:[self substringWithRange:result.range] forKey:HYRegexComponentKey];
            [matches addObject:component];
        }
    }
    return matches;
}

- (NSArray<NSDictionary *> *)hy_separatedByRegex:(NSString *)regex {
    NSMutableArray *components = [NSMutableArray array];
    NSArray *matches = [self hy_matchesOfRegex:regex];
    NSRange sliceRange = NSMakeRange(0, 0);
    for (int i = 0; i < matches.count; i++) {
        NSRange range = [[matches[i] objectForKey:HYRegexComponentRangeKey] rangeValue];
        NSUInteger length = range.location - sliceRange.location;
        if (length > 0) {
            // 先获取"子字符串"
            sliceRange = NSMakeRange(sliceRange.location, length);
            NSString *sliceStr = [self hy_substringWithRange:sliceRange];
            // 构建字典内容
            NSMutableDictionary *component = [NSMutableDictionary dictionary];
            [component setObject:[NSValue valueWithRange:sliceRange] forKey:HYRegexComponentRangeKey];
            [component setObject:sliceStr forKey:HYRegexComponentKey];
            [components addObject:component];
        }
        // 调整下次截取的位置 (包含 第一个片段就是匹配项的情况处理)
        sliceRange = NSMakeRange(NSMaxRange(range), 0);
    }
    // 字符串没有处理完成的情况 ，处理结果结束的情况下 sliceRange.location == self.length
    if (sliceRange.location < self.length) {
        sliceRange = NSMakeRange(sliceRange.location, self.length - sliceRange.location);
        NSString *sliceStr = [self hy_substringFromIndex:sliceRange.location];
        NSMutableDictionary *component = [NSMutableDictionary dictionary];
        [component setObject:[NSValue valueWithRange:sliceRange] forKey:HYRegexComponentRangeKey];
        [component setObject:sliceStr forKey:HYRegexComponentKey];
        [components addObject:component];
    }
    return components;
}


- (NSString *)hy_getRegexByType:(HYRegexType)regexType {
    switch (regexType) {
        case HYRegexTypeTelephoneNumber:
        {
            return @"^(([0-9]{3,4}(-?))?([0-9]{7,8}))$";
        }
            break;
            
        case HYRegexTypeMobilephoneNumber:
        {
            return @"^1[3|4|5|7|8|9][0-9]\\d{8}$";
        }
            break;
            
        case HYRegexTypePassword:
        {
            return @"^[0-9a-zA-Z]{6,20}$";
        }
            break;
            
        case HYRegexTypeIDCard:
        {
            return @"^(\\d{14}[0-9xX])|([1-9]{2}[0-9]{4}[1-9]{1}[0-9]{3}((0[1-9])|(1[0|1|2]))((0[1-9])|([12][0-9])|(3[01]))[0-9]{3}[0-9X])$";
        }
            break;
            
        case HYRegexTypeEmailAddress:
        {
            return @"^[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?$";
        }
            break;
           
        case HYRegexTypeNumber:
        {
            return @"^[0-9]+$";
        }
            break;
            
        case HYRegexTypeLetter:
        {
            return @"^[A-Za-z]+$";
        }
            break;
            
        case HYRegexTypeUppercase:
        {
            return @"^[A-Z]+$";
        }
            break;
            
        case HYRegexTypeLowercase:
        {
            return @"^[a-z]+$";
        }
            break;
            
        case HYRegexTypeChinese:
        {
            return @"^[\u4e00-\u9fea\u2e80-\u2ef3\u3400-\u4db5\uf900-\ufad9]{0,}$";
        }
            break;
            
        case HYRegexTypeNumberOrLetter:
        {
            return @"^[A-Za-z0-9]+$";
        }
            break;
            
        case HYRegexTypeNumberOrLetterOrChinese:
        {
            return @"^[A-Za-z0-9\u4e00-\u9fea\u2e80-\u2ef3\u3400-\u4db5\uf900-\ufad9]+$";
        }
            break;
           
        case HYRegexTypeURL:
        {
            return @"^[a-zA-z]+://[^\\s]*$";
        }
            break;
            
        case HYRegexTypeYear:
        {
            return @"^([0-9]{4})$";
        }
            break;
            
        case HYRegexType12MonthOfYear:
        {
            return @"^(0?[1-9]|1[0-2])$";
        }
            break;
            
        case HYRegexType28DaysOfMonth:
        {
            return @"^((0?[1-9])|(1[0-9])|(2[0-8]))$";
        }
            break;
            
        case HYRegexType29DaysOfMonth:
        {
            return @"^((0?[1-9])|((1|2)[0-9]))$";
        }
            break;
            
        case HYRegexType30DaysOfMonth:
        {
            return @"^((0?[1-9])|((1|2)[0-9])|30)$";
        }
            break;
            
        case HYRegexType31DaysOfMonth:
        {
            return @"^((0?[1-9])|((1|2)[0-9])|30|31)$";
        }
            break;
            
        case HYRegexTypeDate:
        {
            return @"^((([0-9]{4})([年|\\-|\\.]))((0?[1-9]|1[0-2])([月|\\-|\\.]))(((0?[1-9])|((1|2)[0-9])|30|31)日?))$";
        }
            break;
            
        case HYRegexTypeBlankline:
        {
            return @"\n\\s*\r";
        }
            break;
            
        case HYRegexTypeHTML:
        {
            return @"^<(.*)>.*|<(.*) />$";
        }
            break;
            
        case HYRegexTypeBlankAtBeginAndEnd:
        {
            return @"^\\s*|\\s*$";
        }
            break;
            
        case HYRegexTypeQQ:
        {
            return @"^[1-9][0-9]{4,}$";
        }
            break;
            
        case HYRegexTypePostalCodeOfChina:
        {
            return @"[1-9]\\d{5}(?!\\d)";
        }
            break;
        
        case HYRegexTypeIPAddress:
        {
            return @"^([0-9]{1,3}[\\.])([0-9]{1,3}[\\.])([0-9]{1,3}[\\.])([0-9]{1,3})$";
        }
            break;
            
        default:
        {
            return @"";
        }
            break;
    }
    
}

- (NSArray<NSString *> *)hy_componentsSeparatedByRegex:(NSString *)separator {
    NSMutableArray *strs = [NSMutableArray array];
    NSArray *components = [self hy_separatedByRegex:separator];
    for (int i = 0; i < components.count; i++) {
        NSString *subStr = [components[i] objectForKey:HYRegexComponentKey];
        [strs addObject:subStr];
    }
    return strs;
}

#pragma mark - 编码
- (NSString *)hy_stringByEncodingURL {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet hy_allowedURLCharacters]];
}

- (NSString *)hy_stringByDecodingURL {
    return [self stringByRemovingPercentEncoding];
}

- (NSString *)hy_stringByEncodingMD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)hy_stringByEncodingBase64 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)hy_stringByDecodingBase64 {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - query

+ (NSString *)hy_queryStringFromParameters:(NSDictionary *)parameters {
    if (![parameters isKindOfClass:[NSDictionary class]] ||
        [NSDictionary hy_isNullDictionary:parameters]) {
        return nil;
    }
    return AFQueryStringFromParameters(parameters);
}

+ (NSDictionary *)hy_dictionaryFromQueryString:(NSString *)query {
    if (![query isKindOfClass:[NSString class]] ||
        [NSString hy_isNullString:query]) {
        return nil;
    }
//   query = [query stringByRemovingPercentEncoding];
    
    // 参考 facebook 中的 FBSDKUtility : https://github.com/facebook/facebook-ios-sdk/blob/9ec5d438e81f80646f6b59e649e35cfd309e13c5/FBSDKCoreKit/FBSDKCoreKit/FBSDKUtility.m
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    NSArray *parts = [query componentsSeparatedByString:@"&"];
    
    for (NSString *part in parts) {
        if ([part length] == 0) {
            continue;
        }
        
        NSRange index = [part rangeOfString:@"="];
        NSString *key;
        NSString *value;
        
        if (index.location == NSNotFound) {
            key = part;
            value = @"";
        } else {
            key = [part substringToIndex:index.location];
            value = [part substringFromIndex:index.location + index.length];
        }
        
        key = [self URLDecode:key];
        value = [self URLDecode:value];
        if (key && value) {
            result[key] = value;
        }
    }
    return result;
}

+ (NSString *)URLDecode:(NSString *)value {
    value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    value = [value stringByRemovingPercentEncoding];
    return value;
}

@end



