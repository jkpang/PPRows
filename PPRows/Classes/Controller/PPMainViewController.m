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
#import "PPMainModel.h"
#import <PPCounter.h>

@interface PPMainViewController () <NSTableViewDataSource, NSTableViewDelegate, PPDragDropViewDelegate ,PPTableCellViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
/** 拖拽文件检测View*/
@property (weak) IBOutlet PPDragDropView *dragDropView;
/** 参与计算的所有文件*/
@property (weak) IBOutlet NSTextField *totalFiles;
/** 所有代码行数*/
@property (weak) IBOutlet NSTextField *totalRows;
/** 列表数据源*/
@property (nonatomic, strong) NSMutableArray<PPMainModel *> *dataSource;
@end

@implementation PPMainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.totalFiles.stringValue = @"";
    self.totalRows.stringValue = @"";
    // 设置垂直滚动条的样式
    self.tableView.enclosingScrollView.scrollerStyle = NSScrollerStyleOverlay;
    self.tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dragDropView.delegate = self;
}

#pragma mark - NSTableViewDataSource, NSTableViewDelegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    PPTableCellView *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    [cell fillCellWithModel:self.dataSource[row] index:row+1];
    cell.delegate = self;
    return cell;
}

#pragma mark - PPDragDropViewDelegate 获取文件路径数据源数组
- (void)dragDropFilePathList:(NSArray<NSString *> *)filePathList
{
    [self.dataSource removeAllObjects];
    self.totalFiles.stringValue = @"计算中...";
    self.totalRows.stringValue = @"";
    
    // 获取拖拽文件路径数据源, 并组装好数据模型
    for (NSString *filePath in filePathList) {
        PPMainModel *model = [PPMainModel new];
        model.filePath = filePath;
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - PPTableCellViewDelegate
- (void)cellCountFinished
{
    // 每处理完一个cell的文件, 都计算一次文件数量与代码量
    NSUInteger fileNumber = 0;
    NSUInteger codeRows = 0;
    for (PPMainModel *model in self.dataSource) {
        if (!model.countFinished) {return;}
        fileNumber += model.fileNumber;
        codeRows += model.codeRows;
    }
    
    [self countCodeFiles:fileNumber];
    [self countCodeRows:codeRows];
    
}

- (void)countCodeFiles:(NSUInteger)fileNumber
{
    [[PPCounterEngine counterEngine] fromNumber:0 toNumber:fileNumber duration:1.5f animationOptions:PPCounterAnimationOptionCurveEaseInOut currentNumber:^(CGFloat number) {
        self.totalFiles.stringValue = NSStringFormat(@"共%ld个文件",(NSInteger)number);
        [self.totalFiles updateConstraints];
    } completion:^(CGFloat endNumber) {
        NSAttributedString *string = [NSAttributedString pp_attributesWithText:self.totalFiles.stringValue
                                                                     rangeText:NSStringFormat(@"%ld",fileNumber)
                                                                 rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                                rangeTextColor:fileNumber?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.totalFiles.attributedStringValue = string;
        [self.totalFiles updateConstraints];
    }];
}
- (void)countCodeRows:(NSUInteger)codeRows
{
    [[PPCounterEngine counterEngine] fromNumber:0 toNumber:codeRows duration:1.5f animationOptions:PPCounterAnimationOptionCurveEaseInOut currentNumber:^(CGFloat number) {
        self.totalRows.stringValue = NSStringFormat(@"%ld行代码",(NSInteger)number);
        [self.totalRows updateConstraints];
    } completion:^(CGFloat endNumber) {
        
        NSAttributedString *string = [NSAttributedString pp_attributesWithText:self.totalRows.stringValue
                                                                     rangeText:NSStringFormat(@"%ld",codeRows)
                                                                 rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                                rangeTextColor:codeRows?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.totalRows.attributedStringValue = string;
        [self.totalRows updateConstraints];
    }];
}


#pragma mark - lazy

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end

