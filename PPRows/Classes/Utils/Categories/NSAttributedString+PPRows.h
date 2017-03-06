//
//  NSAttributedString+PPRows.h
//  PPRows
//
//  Created by AndyPang on 17/3/6.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (PPRows)

/**
 普通字符串 --> 富文本属性字符串

 @param text 总的文本字符串
 @param rangeText 需要改变字体属性的文本
 @param rangeTextFont 文本的字体属性
 @param rangeTextColor 文本的颜色属性
 @return 富文本属性字符串
 */
+ (NSAttributedString *)pp_attributesWithText:(NSString *)text
                                    rangeText:(NSString *)rangeText
                                rangeTextFont:(NSFont *)rangeTextFont
                                rangeTextColor:(NSColor *)rangeTextColor;

@end

NS_ASSUME_NONNULL_END
