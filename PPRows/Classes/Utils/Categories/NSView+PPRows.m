//
//  NSView+PPRows.m
//  PPRows
//
//  Created by AndyPang on 2017/3/9.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "NSView+PPRows.h"

@implementation NSView (PPRows)
- (void)setP_x:(CGFloat)p_x
{
    CGRect frame = self.frame;
    frame.origin.x = p_x;
    self.frame = frame;
}

- (CGFloat)p_x
{
    return self.frame.origin.x;
}

- (void)setP_y:(CGFloat)p_y
{
    CGRect frame = self.frame;
    frame.origin.y = p_y;
    self.frame = frame;
}

- (CGFloat)p_y
{
    return self.frame.origin.y;
}

- (void)setP_width:(CGFloat)p_width
{
    CGRect frame = self.frame;
    frame.size.width = p_width;
    self.frame = frame;
}

- (CGFloat)p_width
{
    return self.frame.size.width;
}

- (void)setP_height:(CGFloat)p_height
{
    CGRect frame = self.frame;
    frame.size.height = p_height;
    self.frame = frame;
}

- (CGFloat)p_height
{
    return self.frame.size.height;
}
- (void)setP_size:(CGSize)p_size
{
    CGRect frame = self.frame;
    frame.size = p_size;
    self.frame = frame;
}
- (CGSize)p_size
{
    return self.frame.size;
}

- (void)setP_origin:(CGPoint)p_origin
{
    CGRect frame = self.frame;
    frame.origin = p_origin;
    self.frame = frame;
}
- (CGPoint)p_origin
{
    return self.frame.origin;
}

@end
