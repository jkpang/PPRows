//
//  NSColor+PPRows.m
//  PPRows
//
//  Created by AndyPang on 17/3/6.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "NSColor+PPRows.h"

@implementation NSColor (PPRows)

+ (NSColor *)pp_colorWithHex:(UInt32)hex {
    return [NSColor pp_colorWithHex:hex alpha:1.f];
}

+ (NSColor *)pp_colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [NSColor colorWithRed:((hex >> 16) & 0xFF)/255.f
                           green:((hex >> 8) & 0xFF)/255.f
                            blue:(hex & 0xFF)/255.f
                           alpha:alpha];
}

@end
