//
//  NSColor+PPRows.h
//  PPRows
//
//  Created by AndyPang on 17/3/6.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#ifndef NSColorHex
#define NSColorHex(_hex_)   [NSColor pp_colorWithHex:(_hex_)]
#endif

@interface NSColor (PPRows)

+ (NSColor *)pp_colorWithHex:(UInt32)hex;

+ (NSColor *)pp_colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;
@end
