//
//  PPMainViewController.m
//  PPRows
//
//  Created by AndyPang on 2017/3/4.
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

#import "PPMainViewController.h"
#import "PPTableCellView.h"
#import "PPDragDropView.h"
#import "NSAttributedString+PPRows.h"
#import "PPMainModel.h"
#import "PPSettingView.h"
#import <PPCounter.h>

NSString *const kPPRowsCheckFileTypes = @"kPPRowsCheckFileTypes";
NSString *const kPPRowsIgnoreFolders = @"kPPRowsIgnoreFolders";

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

@property (weak) IBOutlet NSImageView *placeholderImageView;
@property (weak) IBOutlet NSTextField *placeholderTitle;

@end

@implementation PPMainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Set Vertical scroll bar Style
    // 设置垂直滚动条的样式
    self.tableView.enclosingScrollView.scrollerStyle = NSScrollerStyleOverlay;
    // Set cell click to select the status to None
    // 设置cell点击选择状态为None
    self.tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
    // Set the drag file delegate
    // 设置拖拽文件代理
    self.dragDropView.delegate = self;
    // Set the program window to initialize the width
    // 设置程序窗口初始化宽度
    NSWindow *window = [NSApplication sharedApplication].windows.firstObject;
    CGRect frame = window.frame;
    frame.size.width = 350;
    [window setFrame:frame display:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.totalFiles.stringValue = @"";
    self.totalRows.stringValue = @"";
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
    [self setPlaceholderViewHidden:filePathList.count>0];
    
    [self.dataSource removeAllObjects];
    self.totalFiles.stringValue = NSLocalizedString(@"In calculation...", @"In calculation...");
    self.totalRows.stringValue = @"";
    
    // Get the drag file path data source, and assemble the data model
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
    // Each time a cell of the file, calculate the total number of documents and the total amount of code
    // 每处理完一个cell的文件, 都计算一次总文件数量与总代码量
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
        NSString *localizedString = [NSString localizedStringWithFormat:NSLocalizedString(@"Total files", @"Total files"),(NSInteger)number];
        self.totalFiles.stringValue = localizedString;
    } completion:^(CGFloat endNumber) {
        
        NSString *formatter = [NSNumberFormatter localizedStringFromNumber:@(fileNumber)
                                                               numberStyle:NSNumberFormatterDecimalStyle];
        
        NSAttributedString *string = [NSAttributedString pp_attributesWithText:self.totalFiles.stringValue
                                                                     rangeText:formatter
                                                                 rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                                rangeTextColor:fileNumber?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.totalFiles.attributedStringValue = string;
        [self.totalFiles updateConstraints];
    }];
}
- (void)countCodeRows:(NSUInteger)codeRows
{
    [[PPCounterEngine counterEngine] fromNumber:0 toNumber:codeRows duration:1.5f animationOptions:PPCounterAnimationOptionCurveEaseInOut currentNumber:^(CGFloat number) {
        NSString *localizedString = [NSString localizedStringWithFormat:NSLocalizedString(@"Total code rows", @"Total code rows"),(NSInteger)number];
        self.totalRows.stringValue = localizedString;
    } completion:^(CGFloat endNumber) {
        
        NSString *formatter = [NSNumberFormatter localizedStringFromNumber:@(codeRows)
                                                               numberStyle:NSNumberFormatterDecimalStyle];
        NSAttributedString *string = [NSAttributedString pp_attributesWithText:self.totalRows.stringValue
                                                                     rangeText:formatter
                                                                 rangeTextFont:[NSFont boldSystemFontOfSize:12]
                                                                rangeTextColor:codeRows?NSColorHex(0x1AB394):NSColorHex(0xE45051)];
        self.totalRows.attributedStringValue = string;
        [self.totalRows updateConstraints];
    }];
}

#pragma mark - Show Setting
- (IBAction)showSetting:(id)sender
{
    NSWindow *window = [NSApplication sharedApplication].windows.firstObject;
    CGRect frame = window.frame;
    if (frame.size.width == 500) {
        frame.size.width = 350;
    } else {
        frame.size.width = 500;
    }
    [window setFrame:frame display:YES animate:YES];
    
}

#pragma mark - PlacehelderView
- (void)setPlaceholderViewHidden:(BOOL)hidden
{
    self.placeholderTitle.hidden = hidden;
    self.placeholderImageView.hidden = hidden;
}

#pragma mark - lazy
- (NSMutableArray *)dataSource {
    if (!_dataSource) {_dataSource = [[NSMutableArray alloc] init];}
    return _dataSource;
}
@end

