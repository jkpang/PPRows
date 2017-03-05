//
//  PPRowsEngine.m
//  PPRows
//
//  Created by AndyPang on 2017/3/5.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPRowsEngine.h"

@implementation PPRowsEngine

+ (PPRowsResult)codeLineCount:(NSString *)path
{
    // 1.获得文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.标记是否为文件夹
    BOOL dir = NO; // 标记是否为文件夹
    // 标记这个路径是否存在
    BOOL exist = [mgr fileExistsAtPath:path isDirectory:&dir];
    
    // 3.如果不存在，直接返回0
    if(!exist)
    {
        NSLog(@"文件路径不存在!!!!!!");
        return (PPRowsResult){0,0};
    }
    if (dir)
    { // 文件夹
        // 获得当前文件夹path下面的所有内容（文件夹、文件）
        NSArray *array = [mgr contentsOfDirectoryAtPath:path error:nil];
        
        // 定义一个变量保存path中所有文件的总行数
        NSUInteger count = 0;
        NSUInteger fileNumber = 0;
        // 遍历数组中的所有子文件（夹）名
        for (NSString *filename in array)
        {
            // 获得子文件（夹）的全路径
            NSString *fullPath = [NSString stringWithFormat:@"%@/%@", path, filename];
            
            // 累加每个子路径的总行数
            PPRowsResult result = [self codeLineCount:fullPath];
            fileNumber = result.fileNumbser;
            count += result.codeRows;
        }
        return (PPRowsResult){fileNumber,count};
    }
    else
    {
        // 文件
        static NSUInteger fileNumber = 0;
        // 判断文件的拓展名(忽略大小写)
        NSString *extension = [[path pathExtension] lowercaseString];
        if (![extension isEqualToString:@"h"]
            && ![extension isEqualToString:@"m"]
            && ![extension isEqualToString:@"c"])
        {
            // 文件拓展名不是h，而且也不是m，而且也不是c
            return (PPRowsResult){fileNumber,0};
        }
        fileNumber++;
        // 加载文件内容
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        // 将文件内容切割为每一行
        NSArray *array = [content componentsSeparatedByString:@"\n"];
        
        return (PPRowsResult){fileNumber,array.count};
    }
    
}


@end
