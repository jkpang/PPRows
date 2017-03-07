//
//  PPMainViewController.m
//  PPRows
//
//  Created by AndyPang on 2017/3/4.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPMainViewController.h"
#import "PPTableCellView.h"
#import "PPDragDropView.h"
#import "NSAttributedString+PPRows.h"
#import <PPCounter.h>

@interface PPMainViewController () <NSTableViewDataSource, NSTableViewDelegate, PPDragDropViewDelegate ,PPTableCellViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
/** 拖拽文件检测View*/
@property (weak) IBOutlet PPDragDropView *dragDropView;
/** 当计算完所有文件后的汇总结果*/
@property (weak) IBOutlet NSTextField *totalResult;
/** 列表数据源*/
@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation PPMainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置垂直滚动条的样式
    self.tableView.enclosingScrollView.scrollerStyle = NSScrollerStyleOverlay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dragDropView.delegate = self;
}

#pragma mark - NSTableViewDataSource, NSTableViewDelegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    PPTableCellView *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    [cell fillCellWithFilePath:self.dataSource[row] index:row+1];
    cell.delegate = self;
    return cell;
}

#pragma mark - PPDragDropViewDelegate
- (void)dragDropFilePathList:(NSArray<NSString *> *)filePathList
{
    _dataSource = filePathList;
    [self.tableView reloadData];
}

#pragma mark - PPTableCellViewDelegate
- (void)countFinishedWithFileNumber:(NSUInteger)fileNumber codeRows:(NSUInteger)codeRows
{
    [[PPCounterEngine counterEngine] fromNumber:0 toNumber:fileNumber duration:1.5f animationOptions:PPCounterAnimationOptionCurveEaseOut currentNumber:^(CGFloat number) {
        self.totalResult.stringValue = [NSString stringWithFormat:@"CodeFiles: %ld",(NSInteger)number];
    } completion:^{
        
        NSAttributedString *string = [NSAttributedString pp_attributesWithText:self.totalResult.stringValue
                                                                     rangeText:NSStringFormat(@"%ld",fileNumber)
                                                                 rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                                rangeTextColor:fileNumber?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.totalResult.attributedStringValue = string;
    }];
}

@end

