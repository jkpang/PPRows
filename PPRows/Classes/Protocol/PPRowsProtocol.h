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
 回调每个cell计算的文件信息

 @param fileNumber 参与计算的文件数量
 @param codeRows 参与计算文件的总代码行数
 */
- (void)countFinishedWithFileNumber:(NSUInteger)fileNumber codeRows:(NSUInteger)codeRows;

@end


#endif /* PPRowsProtocol_h */
