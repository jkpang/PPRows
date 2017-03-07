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

@implementation PPMainViewController {
    dispatch_group_t _group;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置垂直滚动条的样式
    self.tableView.enclosingScrollView.scrollerStyle = NSScrollerStyleOverlay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _group = dispatch_group_create();
    self.dragDropView.delegate = self;
    
    __block NSUInteger fileNumber;
    __block NSUInteger codeRows;
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        for (PPMainModel *model in self.dataSource) {
            fileNumber += model.fileNumber;
            codeRows += model.codeRows;
        }
        [self countFinishedWithFileNumber:fileNumber codeRows:codeRows];
    });
    
}

#pragma mark - NSTableViewDataSource, NSTableViewDelegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    PPTableCellView *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    [cell fillCellWithModel:self.dataSource[row] index:row+1 dispatchGroup:_group];
    cell.delegate = self;
    return cell;
}

#pragma mark - PPDragDropViewDelegate
- (void)dragDropFilePathList:(NSArray<NSString *> *)filePathList
{
    for (NSString *filePath in filePathList) {
        PPMainModel *model = [PPMainModel new];
        model.filePath = filePath;
        [self.dataSource addObject:model];
    }
    
    [self.tableView reloadData];
}

#pragma mark - PPTableCellViewDelegate
- (void)countFinishedWithFileNumber:(NSUInteger)fileNumber codeRows:(NSUInteger)codeRows
{
    [[PPCounterEngine counterEngine] fromNumber:0 toNumber:fileNumber duration:1.5f animationOptions:PPCounterAnimationOptionCurveEaseOut currentNumber:^(CGFloat number) {
        self.totalFiles.stringValue = NSStringFormat(@"共%ld个文件",(NSInteger)number);
    } completion:^{
        
        NSAttributedString *string = [NSAttributedString pp_attributesWithText:self.totalFiles.stringValue
                                                                     rangeText:NSStringFormat(@"%ld",fileNumber)
                                                                 rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                                rangeTextColor:fileNumber?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.totalFiles.attributedStringValue = string;
    }];
    
    [[PPCounterEngine counterEngine] fromNumber:codeRows toNumber:codeRows duration:1.5f animationOptions:PPCounterAnimationOptionCurveEaseOut currentNumber:^(CGFloat number) {
        self.totalRows.stringValue = NSStringFormat(@"%ld行代码",(NSInteger)number);
    } completion:^{
        
        NSAttributedString *string = [NSAttributedString pp_attributesWithText:self.totalRows.stringValue
                                                                     rangeText:NSStringFormat(@"%ld",codeRows)
                                                                 rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                                rangeTextColor:codeRows?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.totalRows.attributedStringValue = string;
    }];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end

