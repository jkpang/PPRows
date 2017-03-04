//
//  PPMainViewController.m
//  PPRows
//
//  Created by AndyPang on 2017/3/4.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPMainViewController.h"
#import "PPTableCellView.h"

@interface PPMainViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation PPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 10;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    PPTableCellView *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    return cell;
}

@end
