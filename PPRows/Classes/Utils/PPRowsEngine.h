//
//  PPRowsEngine.h
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


#import <Foundation/Foundation.h>

typedef void(^PPRowsCompletion)(NSUInteger fileNumber, NSUInteger codeRows);
typedef void(^PPRowsError)(NSString *errorInfo);

@interface PPRowsEngine : NSObject

/**
 Convenient construction method
 便利构造方法

 @return 返回一个PPRowsEngine的实例 <-> Returns an instance of the PPRowsEngine object
 */
+ (instancetype)rowsEngine;

/**
 Calculate all the code files and the number of lines of code in the folder that dragged / imported
 计算拖入/输入的文件夹内所有的代码文件以及代码行数

 @param filePath 文件路径 <-> File path
 @param completion 计算完成的回调 <-> Completed callback
 @param error 文件不存在的错误回调 <-> File does not exist error callback
 */
- (void)computeWithFilePath:(NSString *)filePath
                 completion:(PPRowsCompletion)completion
                      error:(PPRowsError)error;

@end
