//
//  PPDragDropView.h
//  PPRows
//
//  Created by AndyPang on 2017/3/5.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PPDragDropView : NSView

@property (nonatomic, weak) id<PPDragDropViewDelegate> delegate;

@end
