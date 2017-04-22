//
//  PPSettingView.m
//  PPRows
//
//  Created by AndyPang on 2017/3/11.
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

#import "PPSettingView.h"
#import <objc/runtime.h>

NSString *const kIsEdit = @"kIsEdit";

@interface PPSettingView ()<NSTokenFieldDelegate>

/** 需要检测的文件类型*/
@property (weak) IBOutlet NSTokenField *checkFileType;
/** 需要忽略检测的文件夹*/
@property (weak) IBOutlet NSTokenField *ignoreFolder;

@end

@implementation PPSettingView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.checkFileType.tokenStyle = NSTokenStyleSquared;
    self.ignoreFolder.tokenStyle = NSTokenStyleSquared;
    self.checkFileType.delegate = self;
    self.ignoreFolder.delegate = self;
    
    [self setupDefaultConfig];
}

#pragma mark - defaultConfig
- (void)setupDefaultConfig
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    // 如果设置未更改
    if (![userDefault boolForKey:kIsEdit]) {
        [userDefault setObject:self.defaultFileTypes forKey:kPPRowsCheckFileTypes];
        [userDefault setObject:self.defaultIgnoreFolders forKey:kPPRowsIgnoreFolders];
    }
    
    self.checkFileType.objectValue = [userDefault objectForKey:kPPRowsCheckFileTypes];
    self.ignoreFolder.objectValue = [userDefault objectForKey:kPPRowsIgnoreFolders];
}

#pragma mark - updataConfig
/**
 存储最新的文件检测配置
 */
- (void)controlTextDidChange:(NSNotification *)obj
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 标记配置是否已更改
    [userDefaults setBool:YES forKey:kIsEdit];
    
    if ([obj.object isEqual:self.checkFileType]) {
        [userDefaults setObject:self.fileTypes forKey:kPPRowsCheckFileTypes];
    } else {
        [userDefaults setObject:self.ignoreFolders forKey:kPPRowsIgnoreFolders];
    }
    [userDefaults synchronize];
}

#pragma mark - getter
- (NSArray *)defaultFileTypes
{
    NSArray *array = @[@"h",@"m",@"swift",@"c",@"java",@"mm",@"cpp",@"js",@"py"];
    return array;
}

- (NSArray *)defaultIgnoreFolders
{
    NSArray *array = @[@"Pods"];
    return array;
}

- (NSArray *)fileTypes
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.checkFileType.objectValue];
    // 将文件类型名称全部转化成小写
    for (NSString *fileType in self.checkFileType.objectValue) {
        [fileType lowercaseString];
    }
    return array;
}

- (NSArray *)ignoreFolders
{
    return self.ignoreFolder.objectValue;
}
@end
