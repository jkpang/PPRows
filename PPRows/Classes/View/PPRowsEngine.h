//
//  PPRowsEngine.h
//  PPRows
//
//  Created by AndyPang on 2017/3/5.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct PPRowsResult {
    NSUInteger fileNumbser;
    NSUInteger codeRows;
} PPRowsResult;

@interface PPRowsEngine : NSObject

+ (PPRowsResult)codeLineCount:(NSString *)path;
@end
