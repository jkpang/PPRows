//
//  NSAttributedString+PPRows.m
//  PPRows
//
//  Created by AndyPang on 17/3/6.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "NSAttributedString+PPRows.h"

@implementation NSAttributedString (PPRows)

+ (NSAttributedString *)pp_attributesWithText:(NSString *)text rangeText:(NSString *)rangeText rangeTextFont:(NSFont *)rangeTextFont rangeTextColor:(NSColor *)rangeTextColor
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:@{NSFontAttributeName:rangeTextFont,NSForegroundColorAttributeName:rangeTextColor}
                              range:[text rangeOfString:rangeText]];
    return attributedString;
}
@end
