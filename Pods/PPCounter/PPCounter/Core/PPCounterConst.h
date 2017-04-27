//
//  PPCounterConst.h
//  PPCounter
//
//  Created by AndyPang on 16/10/17.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

/*
 *********************************************************************************
 *
 *⭐️⭐️⭐️ 新建 PP-iOS学习交流群: 323408051 欢迎加入!!! ⭐️⭐️⭐️
 *
 * 如果您在使用 PPCounter 的过程中出现bug或有更好的建议,还请及时以下列方式联系我,我会及
 * 时修复bug,解决问题.
 *
 * Weibo : jkpang-庞
 * Email : jkpang@outlook.com
 * QQ 群 : 323408051
 * GitHub: https://github.com/jkpang
 *
 * 如果 PPCounter 好用,希望您能Star支持,你的 ⭐️ 是我持续更新的动力!
 *
 *********************************************************************************
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

extern NSString *const kPPCounterAnimationOptions;

typedef void(^PPCompletionBlock)(CGFloat endNumber);

typedef void(^PPCurrentNumberBlock)(CGFloat currentNumber);

typedef NSString *(^PPFormatBlock)(CGFloat currentNumber);

typedef NSAttributedString *(^PPAttributedFormatBlock)(CGFloat currentNumber);

typedef NS_ENUM(NSUInteger, PPCounterAnimationOptions) {
    /** 由慢到快,再由快到慢*/
    PPCounterAnimationOptionCurveEaseInOut = 1,
    /** 由慢到快*/
    PPCounterAnimationOptionCurveEaseIn,
    /** 由快到慢*/
    PPCounterAnimationOptionCurveEaseOut,
    /** 匀速*/
    PPCounterAnimationOptionCurveLinear
};



