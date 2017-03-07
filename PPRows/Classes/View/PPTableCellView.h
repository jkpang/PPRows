//
//  PPTableCellView.h
//  PPRows
//
//  Created by AndyPang on 2017/3/4.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PPTableCellView : NSTableCellView

- (void)fillCellWithFilePath:(NSString *)path index:(NSUInteger)index;

@property (nonatomic, weak) id<PPTableCellViewDelegate> delegate;
@end
