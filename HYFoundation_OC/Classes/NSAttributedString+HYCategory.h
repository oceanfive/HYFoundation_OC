//
//  NSAttributedString+HYCategory.h
//  HYKit
//
//  Created by ocean on 2017/6/26.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIFont, UIColor;

NS_ASSUME_NONNULL_BEGIN

/**
 1、下面的枚举类型：HYUnderLineStyle、HYUnderLinePattern是对系统的
 NSUnderlineStyle 拆分，系统的需要组合使用，这里拆分成两个了
 2、中划线、下划线 会使用到
 */

typedef NS_ENUM(NSInteger, HYUnderLineStyle) {
    HYUnderLineStyleNone    = NSUnderlineStyleNone,   // 没有效果
    HYUnderLineStyleSingle  = NSUnderlineStyleSingle, // 细线
    HYUnderLineStyleThick   = NSUnderlineStyleThick,  // 粗线
    HYUnderLineStyleDouble  = NSUnderlineStyleDouble  // 双线
};

typedef NS_ENUM(NSInteger, HYUnderLinePattern) {
    /** 实线: --- */
    HYUnderLinePatternSolid      = NSUnderlinePatternSolid,
    /** 点点点: - - - */
    HYUnderLinePatternDot        = NSUnderlinePatternDot,
    /** 破折号: --- --- */
    HYUnderLinePatternDash       = NSUnderlinePatternDash,
    /** 破折号，点: --- - --- - --- - */
    HYUnderLinePatternDashDot    = NSUnderlinePatternDashDot,
    /** 破折号，点，点: --- - - --- - - --- - - */
    HYUnderLinePatternDashDotDot = NSUnderlinePatternDashDotDot
};


@interface NSAttributedString (HYCategory)

+ (nullable NSAttributedString *)hy_attributedStringWithString:(NSString *)string attributes:(nullable NSDictionary<NSString *, id> *)attrs;

+ (nullable NSAttributedString *)hy_attributedStringWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor;

/**
 生成一个带有链接的富文本，

 @param string 富文本text
 @param linkURL 链接url
 @param font 字体
 @param textColor 颜色
 @param backgroundColor 背景颜色
 @return NSAttributedString
 */
+ (nullable NSAttributedString *)hy_attributedStringWithString:(NSString *)string link:(NSURL *)linkURL font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor backgroundColor:(nullable UIColor *)backgroundColor;

@property (nonatomic, assign, readonly) NSRange hy_range;

// 越界判断
- (BOOL)hy_isOutOfRange:(NSRange)range;
- (BOOL)hy_isOutOfIndex:(NSUInteger)index;

@end

// ********************************

/**
 tips:
 1、需要先设置了 `string` 才可以添加属性的值
 2、range 超过范围会设置失败
 */

@interface NSMutableAttributedString (HYCategory)

#pragma mark - 插入富文本
/**
 索引位置 loc 超过范围会操作失败
 */
- (void)hy_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc;

#pragma mark - 字体 Font
- (void)hy_addFont:(UIFont *)font
             range:(NSRange)range;

#pragma mark - 文字颜色 Color
- (void)hy_addTextColor:(UIColor *)textColor
                  range:(NSRange)range;

#pragma mark - 背景颜色 BackgroundColor
- (void)hy_addBackgroundColor:(UIColor *)backgroundColor
                        range:(NSRange)range;

#pragma mark - 段落格式 ParagraphStyle
- (void)hy_addParagraphStyle:(NSParagraphStyle *)paragraphStyle
                        range:(NSRange)range;

#pragma mark - 字符间距 Kern
/**
 kern : 0:禁用；正值:间距增加；负值:间距变小；
 */
- (void)hy_addKern:(CGFloat)kern
             range:(NSRange)range;

#pragma mark - 阴影 Shadow
- (void)hy_addShadow:(NSShadow *)shadow
               range:(NSRange)range;

#pragma mark - 凸版印刷效果 NSTextEffectAttributeName
- (void)hy_addLetterpressRange:(NSRange)range;

#pragma mark - 基准线偏移 BaselineOffset
/**
 baselineOffset: 0 不偏移；正值 向下偏移；负值 向上偏移；
 */
- (void)hy_addBaselineOffset:(CGFloat)baselineOffset
                       range:(NSRange)range;

#pragma mark - 文字倾斜 Obliqueness
/**
 Obliqueness: 0不倾斜；正值往右倾斜；负值往左倾斜；
 */
- (void)hy_addObliqueness:(CGFloat)obliqueness
                    range:(NSRange)range;

#pragma mark - 横向拉伸 Expansion
/**
 expansion: 0不拉伸；正值横向拉伸文本；负值横向压缩文本；
 */
- (void)hy_addExpansion:(CGFloat)expansion
                  range:(NSRange)range;

#pragma mark - 中划线 Strikethrough
/**
 给富文本 AttributedString 添加中划线 Strikethrough 的样式

 @param style 见 HYUnderLineStyle
 @param pattern 见 HYUnderLinePattern
 @param color 中划线颜色，nil 会使用 NSForegroundColorAttributeName 的值
 @param byWord 是否是单词的地方才有
 @param range 添加的范围，超过范围会设置失败
 */
- (void)hy_addStrikethroughStyle:(HYUnderLineStyle)style
                         pattern:(HYUnderLinePattern)pattern
                           color:(UIColor *)color
                          byWord:(BOOL)byWord
                           range:(NSRange)range;

#pragma mark - 下划线 Underline
- (void)hy_addUnderlineStyle:(HYUnderLineStyle)style
                     pattern:(HYUnderLinePattern)pattern
                       color:(UIColor *)color
                      byWord:(BOOL)byWord
                       range:(NSRange)range;

#pragma mark - 镂空效果 Stroke
/**
 镂空效果

 @param width 宽度，正值会产生明显的镂空效果
 @param color 颜色
 @param range 范围
 */
- (void)hy_addStrokeWidth:(CGFloat)width
                    color:(UIColor *)color
                    range:(NSRange)range;

#pragma mark - 附件 NSTextAttachment
- (void)hy_addTextAttachment:(NSTextAttachment *)textAttachment
                        atIndex:(NSUInteger)loc;

#pragma mark - 链接 Link
/**
 在某个位置添加链接富文本

 @param link 链接 url
 @param string 链接的text
 @param font 字体
 @param textColor 颜色
 @param backgroundColor 背景颜色
 @param loc 插入的位置
 
 ps: 带有链接的富文本一般是使用 `UITextView` 加载，可以拦截点击跳转的 url
 */
- (void)hy_addLink:(NSString *)link
            string:(NSString *)string
              font:(UIFont *)font
         textColor:(UIColor *)textColor
   backgroundColor:(UIColor *)backgroundColor
           atIndex:(NSUInteger)loc;

/**
 添加链接（整个范围内）

 @param link 链接 url
 */
- (void)hy_addLink:(NSString *)link;

@end

NS_ASSUME_NONNULL_END
