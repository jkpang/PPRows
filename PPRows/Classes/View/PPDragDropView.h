//
//  PPDragDropView.h
//  PPRows
//
//  Created by AndyPang on 2017/3/5.
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

#import <Cocoa/Cocoa.h>

@interface PPDragDropView : NSView

@property (nonatomic, weak) id<PPDragDropViewDelegate> delegate;

@end
