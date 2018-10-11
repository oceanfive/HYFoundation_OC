//
//  NSAttributedString+HYCategory.m
//  HYKit
//
//  Created by ocean on 2017/6/26.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import "NSAttributedString+HYCategory.h"
#import "NSString+HYCategory.h"
#import "NSObject+HYCategory.h"

// 富文本“线”的类型
typedef NS_ENUM(NSUInteger, HYLineType) {
    HYLineTypeStrikethrough, // 中划线
    HYLineTypeUnderline      // 下划线
};

@implementation NSAttributedString (HYCategory)

+ (NSAttributedString *)hy_attributedStringWithString:(NSString *)string attributes:(NSDictionary<NSString *,id> *)attrs {
    if ([NSString hy_isNullString:string] ||
        [NSObject hy_isNull:attrs]) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:string attributes:attrs];
}

+ (NSAttributedString *)hy_attributedStringWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [self hy_attributedStringWithString:string attributes:attributes];
}

+ (NSAttributedString *)hy_attributedStringWithString:(NSString *)string link:(NSURL *)linkURL font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor {
    if (!string || !linkURL) return nil;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:linkURL forKey:NSLinkAttributeName];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (backgroundColor) [attributes setObject:backgroundColor forKey:NSBackgroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:string attributes:attributes];
}

- (NSRange)hy_range {
    return NSMakeRange(0, self.length);
}

- (BOOL)hy_isOutOfRange:(NSRange)range {
    return [self hy_isOutOfIndex:NSMaxRange(range) - 1];
}

- (BOOL)hy_isOutOfIndex:(NSUInteger)index {
    return !NSLocationInRange(index, self.hy_range);
}

@end


@implementation NSMutableAttributedString (HYCategory)

- (void)hy_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc {
    [self _hyInsertAttributedString:attrString atIndex:loc];
}

- (void)hy_addFont:(UIFont *)font range:(NSRange)range {
    [self _hyAddAttribute:NSFontAttributeName value:font range:range];
}

- (void)hy_addTextColor:(UIColor *)textColor range:(NSRange)range {
    [self _hyAddAttribute:NSForegroundColorAttributeName value:textColor range:range];
}

- (void)hy_addBackgroundColor:(UIColor *)backgroundColor range:(NSRange)range {
    [self _hyAddAttribute:NSBackgroundColorAttributeName value:backgroundColor range:range];
}

- (void)hy_addParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    [self _hyAddAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

- (void)hy_addKern:(CGFloat)kern range:(NSRange)range {
    [self _hyAddAttribute:NSKernAttributeName value:@(kern) range:range];
}

- (void)hy_addShadow:(NSShadow *)shadow range:(NSRange)range {
    [self _hyAddAttribute:NSShadowAttributeName value:shadow range:range];
}

- (void)hy_addLetterpressRange:(NSRange)range {
    [self _hyAddAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:range];
}

- (void)hy_addBaselineOffset:(CGFloat)baselineOffset range:(NSRange)range {
    [self _hyAddAttribute:NSBaselineOffsetAttributeName value:@(baselineOffset) range:range];
}

- (void)hy_addObliqueness:(CGFloat)obliqueness range:(NSRange)range {
    [self _hyAddAttribute:NSObliquenessAttributeName value:@(obliqueness) range:range];
}

- (void)hy_addExpansion:(CGFloat)expansion range:(NSRange)range {
    [self _hyAddAttribute:NSExpansionAttributeName value:@(expansion) range:range];
}

- (void)hy_addStrikethroughStyle:(HYUnderLineStyle)style
                         pattern:(HYUnderLinePattern)pattern
                           color:(UIColor *)color
                          byWord:(BOOL)byWord
                           range:(NSRange)range {
    [self _hyAddLineType:HYLineTypeStrikethrough style:style pattern:pattern color:color byWord:byWord range:range];
}

- (void)hy_addUnderlineStyle:(HYUnderLineStyle)style
                     pattern:(HYUnderLinePattern)pattern
                       color:(UIColor *)color
                      byWord:(BOOL)byWord
                       range:(NSRange)range {
    [self _hyAddLineType:HYLineTypeUnderline style:style pattern:pattern color:color byWord:byWord range:range];
}

- (void)hy_addStrokeWidth:(CGFloat)width color:(UIColor *)color range:(NSRange)range {
    [self _hyAddAttribute:NSStrokeWidthAttributeName value:@(width) range:range];
    [self _hyAddAttribute:NSStrokeColorAttributeName value:color range:range];
}

- (void)hy_addTextAttachment:(NSTextAttachment *)textAttachment atIndex:(NSUInteger)loc {
    if (textAttachment) {
        NSAttributedString *attchment = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [self _hyInsertAttributedString:attchment atIndex:loc];
    }
}

- (void)hy_addLink:(NSString *)link string:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor atIndex:(NSUInteger)loc {
    NSAttributedString *attributedLink = [NSAttributedString hy_attributedStringWithString:string link:[NSURL URLWithString:link] font:font textColor:textColor backgroundColor:backgroundColor];
    if (attributedLink) {
        [self _hyInsertAttributedString:attributedLink atIndex:loc];
    }
}

- (void)hy_addLink:(NSString *)link {
    if (link && link.length > 0) {    
        [self _hyAddAttribute:NSLinkAttributeName value:[NSURL URLWithString:link] range:self.hy_range];
    }
}

#pragma mark - 私有方法

#pragma mark - 添加属性
- (void)_hyAddAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range {
    if ([self hy_isOutOfRange:range]) {
        return;
    }
    if (name && value) {
        [self addAttribute:name value:value range:range];
    }
}

#pragma mark - 插入富文本
- (void)_hyInsertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc {
    if ([self hy_isOutOfIndex:loc]) {
        return;
    }
    if (attrString) {
        [self insertAttributedString:attrString atIndex:loc];
    }
}

- (void)_hyAddLineType:(HYLineType)lineType
                 style:(HYUnderLineStyle)style
               pattern:(HYUnderLinePattern)pattern
                 color:(UIColor *)color
                byWord:(BOOL)byWord
                 range:(NSRange)range {
    
    // 范围越界判断
    if ([self hy_isOutOfRange:range]) {
        return;
    }
    
    // 处理 style 的值
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    NSInteger att = style | pattern;
    if (byWord) {
        att = att | NSUnderlineByWord;
    }
    
    // 处理 key
    NSAttributedStringKey styleKey;
    NSAttributedStringKey colorKey;
    if (lineType == HYLineTypeStrikethrough) {
        styleKey = NSStrikethroughStyleAttributeName;
        colorKey = NSStrikethroughColorAttributeName;
    } else if (lineType == HYLineTypeUnderline) {
        styleKey = NSUnderlineStyleAttributeName;
        colorKey = NSUnderlineColorAttributeName;
    } else {
        // do nothing
    }
    
    // 赋值
    if (styleKey) {
        [attributes setObject:@(att) forKey:styleKey];
    }
    if (colorKey && color) {
        [attributes setObject:color forKey:colorKey];
    }
    
    [self addAttributes:attributes range:range];
}

@end
