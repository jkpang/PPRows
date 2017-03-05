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

@interface PPMainViewController () <NSTableViewDataSource, NSTableViewDelegate, PPDragDropViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@property (weak) IBOutlet PPDragDropView *dragDropView;

@end

@implementation PPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置垂直滚动条的样式
    self.tableView.enclosingScrollView.scrollerStyle = NSScrollerStyleOverlay;
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
    [cell fillCellWithFilePath:self.dataSource[row]];
    
    __weak typeof(self) weakSelf = self;
    cell.reloadRowsBlock = ^{
        [weakSelf.tableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:row] columnIndexes:[NSIndexSet indexSetWithIndex:row]];
    };
    return cell;
}

#pragma mark - PPDragDropViewDelegate
- (void)dragDropFileList:(NSArray<NSString *> *)fileList
{
    _dataSource = fileList;
    [self.tableView reloadData];
}

@end

