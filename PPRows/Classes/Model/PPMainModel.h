//
//  PPMainModel.h
//  PPRows
//
//  Created by AndyPang on 17/3/7.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMainModel : NSObject

/** 文件路径*/
@property (copy  ) NSString *filePath;
/** 文件数量*/
@property (assign) NSUInteger fileNumber;
/** 代码行数*/
@property (assign) NSUInteger codeRows;
/** 是否已经计算完成*/
@property (assign) BOOL countFinished;
@end
