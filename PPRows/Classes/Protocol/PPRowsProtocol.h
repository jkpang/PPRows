//
//  PPRowsProtocol.h
//  PPRows
//
//  Created by AndyPang on 17/3/7.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#ifndef PPRowsProtocol_h
#define PPRowsProtocol_h

#import <Foundation/Foundation.h>

#pragma mark - PPDragDropViewDelegate
@protocol PPDragDropViewDelegate <NSObject>

/**
 回调用户拖拽文件的路径数组

 @param filePathList 文件路径数组
 */
- (void)dragDropFilePathList:(NSArray<NSString *> *)filePathList;

@end


#pragma mark - PPTableCellViewDelegate
@protocol PPTableCellViewDelegate <NSObject>

/**
 每个cell内文件计算完成的回调
 */
- (void)countFinished;

@end


#endif /* PPRowsProtocol_h */
