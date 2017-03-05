//
//  PPTableCellView.m
//  PPRows
//
//  Created by AndyPang on 2017/3/4.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPTableCellView.h"
#import "PPRowsEngine.h"

@interface PPTableCellView ()
/** 文件图片*/
@property (weak) IBOutlet NSImageView *fileImageView;
/** 文件名*/
@property (weak) IBOutlet NSTextField *fileName;
/** 文件夹内文件数量*/
@property (weak) IBOutlet NSTextField *fileNumber;
/** 该文件内总代码行数*/
@property (weak) IBOutlet NSTextField *codeRows;

@end

@implementation PPTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

- (void)fillCellWithFilePath:(NSString *)path
{
    NSArray *folderArray = [path componentsSeparatedByString:@"/"];
    self.fileName.stringValue = folderArray.lastObject;
    
    [[PPRowsEngine rowsEngine] computeWithFilePath:path completion:^(NSUInteger codeFileNumber, NSUInteger codeRows) {
        self.fileNumber.stringValue = [NSString stringWithFormat:@"Files: %ld",codeFileNumber];
        self.codeRows.stringValue = [NSString stringWithFormat:@"Rows: %ld",codeRows];
    } error:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
    
}

@end
