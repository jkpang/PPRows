//
//  PPRowsEngine.m
//  PPRows
//
//  Created by AndyPang on 2017/3/5.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPRowsEngine.h"

@interface PPRowsEngine ()

/** 拖入或输入的文件路径*/
@property (nonatomic, copy) NSString *superPath;
@property (nonatomic, copy) PPRowsError error;
/** 参与计算的代码文件数*/
@property (nonatomic, assign) NSUInteger codeFileNumber;
/** 参与计算的代码行数*/
@property (nonatomic, assign) NSUInteger codeRows;

@end

@implementation PPRowsEngine

+ (instancetype)rowsEngine
{
    return [[PPRowsEngine alloc] init];
}

- (void)computeWithFilePath:(NSString *)filePath
                 completion:(PPRowsCompletion)completion
                      error:(PPRowsError)error
{
    _error = error;
    _superPath = filePath;
    _codeFileNumber = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        _codeRows = [self computeFileInfoWithPath:filePath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion ? completion(_codeFileNumber, _codeRows) : nil;
        });
        
    });
}

- (NSUInteger)computeFileInfoWithPath:(NSString *)path 
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 标记是否为文件夹
    BOOL isFolder = NO;
    // 标记此路径是否存在
    BOOL isExist = [manager fileExistsAtPath:path isDirectory:&isFolder];
    
    if(!isExist) {
        // 当拖入或输入的文件路径不存在时才会回调错误信息
        _error && [_superPath isEqualToString:path] ? _error(@"文件路径不存在!") : nil;
        return 0;
    }
    
    // 1.文件夹
    if (isFolder) {
        NSUInteger codeRows = 0;
        NSArray *subFileArray = [manager contentsOfDirectoryAtPath:path error:nil];
        NSArray *ignoreFolders = [userDefaults objectForKey:kPPRowsIgnoreFolders];
        
        for (NSString *subFileName in subFileArray) {
            // 如果不是要过滤的文件夹
            if (![ignoreFolders containsObject:subFileName]) {
                NSString *subFilePath = [NSString stringWithFormat:@"%@/%@", path,subFileName];
                codeRows += [self computeFileInfoWithPath:subFilePath];
            }
        }
        
        return codeRows;
        
    // 2.文件
    } else {
        // 判断文件的拓展名
        NSString *extension = [[path pathExtension] lowercaseString];
        NSArray *fileTypes = [userDefaults objectForKey:kPPRowsCheckFileTypes];
        
        if (!fileTypes.count || ![fileTypes containsObject:extension]) {
            return 0;
        }

        _codeFileNumber += 1;
        
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[content componentsSeparatedByString:@"\n"]];
        // 清除空行
        [array removeObjectsInArray:@[@"",@"    "]];
        return array.count;
    }
    
}
@end
