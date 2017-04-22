//
//  PPWindowController.m
//  PPRows
//
//  Created by AndyPang on 2017/3/4.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

/*
 *********************************************************************************
 *
 * Weibo : jkpang-庞
 * Email : jkpang@outlook.com
 * QQ 群 : 323408051
 * GitHub: https://github.com/jkpang
 *
 *********************************************************************************
 */

#import "PPWindowController.h"

@interface PPWindowController ()

@end

@implementation PPWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // 设置titlebar为透明 <-> Set titlebar as transparent
    self.window.titlebarAppearsTransparent = YES;
    // 隐藏title
    self.window.titleVisibility = NSWindowTitleHidden;
    // 隐藏最大化按钮
    [self.window standardWindowButton:NSWindowZoomButton].hidden = YES;
}


@end
