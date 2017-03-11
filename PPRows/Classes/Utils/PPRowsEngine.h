//
//  PPRowsEngine.h
//  PPRows
//
//  Created by AndyPang on 2017/3/5.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PPRowsCompletion)(NSUInteger fileNumber, NSUInteger codeRows);
typedef void(^PPRowsError)(NSString *errorInfo);

@interface PPRowsEngine : NSObject

/**
 便利构造方法

 @return 返回一个PPRowsEngine的实例
 */
+ (instancetype)rowsEngine;

/**
 计算拖入/输入的文件夹内所有的代码文件以及总代码行数

 @param filePath 文件路径
 @param completion 计算完成的回调
 @param error 文件不存在的错误回调
 */
- (void)computeWithFilePath:(NSString *)filePath
                 completion:(PPRowsCompletion)completion
                      error:(PPRowsError)error;

@end
