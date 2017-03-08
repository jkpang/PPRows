//
//  PPTableCellView.m
//  PPRows
//
//  Created by AndyPang on 2017/3/4.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPTableCellView.h"
#import "PPRowsEngine.h"
#import "NSAttributedString+PPRows.h"
#import "PPMainModel.h"
#import <PPCounter.h>

@interface PPTableCellView ()
/** 文件图片*/
@property (weak) IBOutlet NSImageView *fileImageView;
/** 文件名*/
@property (weak) IBOutlet NSTextField *fileName;
/** 文件夹内文件数量*/
@property (weak) IBOutlet NSTextField *fileNumber;
/** 该文件内总代码行数*/
@property (weak) IBOutlet NSTextField *codeRows;
/** 计算完成时显示的图片*/
@property (weak) IBOutlet NSImageView *finishedImageView;

@end

@implementation PPTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

- (void)fillCellWithModel:(PPMainModel *)model index:(NSUInteger)index
{
    NSArray *fileList = [model.filePath componentsSeparatedByString:@"/"];
    self.fileName.stringValue = NSStringFormat(@"%ld. %@",index, fileList.lastObject);
    self.finishedImageView.hidden = YES;
    self.fileNumber.stringValue = @"计算中...";
    self.codeRows.stringValue = @"";
    self.fileName.textColor = [NSColor gridColor];
    self.fileNumber.textColor = [NSColor gridColor];
    self.codeRows.textColor = [NSColor gridColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[PPRowsEngine rowsEngine] computeWithFilePath:model.filePath completion:^(NSUInteger codeFileNumber, NSUInteger codeRows) {
            model.fileNumber = codeFileNumber;
            model.codeRows   = codeRows;
            model.countFinished = YES;
            // 文本信息处理完成的回调
            dispatch_async(dispatch_get_main_queue(), ^{
                [self countCodeRows:codeRows];
                [self countCodeFiles:codeFileNumber];
                if (_delegate && [_delegate respondsToSelector:@selector(countFinished)]) {
                    [_delegate countFinished];
                }
            });
            
        } error:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
        }];

    });
}

- (void)countCodeFiles:(NSUInteger)fileNumber
{
    [[PPCounterEngine counterEngine] fromNumber:0 toNumber:fileNumber duration:1.5f animationOptions:PPCounterAnimationOptionCurveEaseOut currentNumber:^(CGFloat number) {
        self.fileNumber.stringValue = NSStringFormat(@"CodeFiles: %ld",(NSInteger)number);
    } completion:^(CGFloat endNumber) {
        
        [self countFinished];
        
        NSAttributedString *string = [NSAttributedString pp_attributesWithText:self.fileNumber.stringValue
                                                                    rangeText:NSStringFormat(@"%ld",fileNumber)
                                                                rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                               rangeTextColor:fileNumber?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.fileNumber.attributedStringValue = string;
    }];
}
- (void)countCodeRows:(NSUInteger)codeRows
{
    [[PPCounterEngine counterEngine] fromNumber:0 toNumber:codeRows duration:1.5f animationOptions:PPCounterAnimationOptionCurveEaseOut currentNumber:^(CGFloat number) {
        self.codeRows.stringValue = NSStringFormat(@"CodeRows: %ld",(NSInteger)number);
    } completion:^(CGFloat endNumber) {
        
        [self countFinished];
        
        NSAttributedString *attributedString = [NSAttributedString pp_attributesWithText:self.codeRows.stringValue
                                                                               rangeText:NSStringFormat(@"%ld",codeRows)
                                                                           rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                                          rangeTextColor:codeRows?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.codeRows.attributedStringValue = attributedString;
    }];
}

- (void)countFinished
{
    self.fileName.textColor = NSColorHex(0xFAF0E1);
    self.fileNumber.textColor = NSColorHex(0xFAF0E1);
    self.codeRows.textColor   = NSColorHex(0xFAF0E1);
    self.finishedImageView.hidden = NO;
}

@end
