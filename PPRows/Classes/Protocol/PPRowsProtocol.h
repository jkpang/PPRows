//
//  PPRowsProtocol.h
//  PPRows
//
//  Created by AndyPang on 17/3/7.
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

#ifndef PPRowsProtocol_h
#define PPRowsProtocol_h

#import <Foundation/Foundation.h>

#pragma mark - PPDragDropViewDelegate
@protocol PPDragDropViewDelegate <NSObject>

/**
 Callback the user to drag the file path array
 回调用户拖拽文件的路径数组

 @param filePathList 文件路径数组
 */
- (void)dragDropFilePathList:(NSArray<NSString *> *)filePathList;

@end


#pragma mark - PPTableCellViewDelegate
@protocol PPTableCellViewDelegate <NSObject>

/**
 Each cell file is calculated to complete the callback
 每个cell内文件计算完成的回调
 */
- (void)cellCountFinished;

@end


#endif /* PPRowsProtocol_h */
