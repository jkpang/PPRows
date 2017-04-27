//
//  PPCounter.h
//  PPCounter
//
//  Created by AndyPang on 16/10/15.
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
#import "PPCounterConst.h"

@interface PPCounterEngine : NSObject

/**
 类方法创建一个计数器的实例
 */
+ (instancetype)counterEngine;

/**
 在指定时间内数字从 numberA -> numberB

 @param starNumer           开始的数字
 @param endNumber           结束的数字
 @param duration            指定的时间
 @param animationOptions    动画类型
 @param currentNumber       当前数字的回调
 @param completion          已完成的回调
 */
- (void)fromNumber:(CGFloat)starNumer
          toNumber:(CGFloat)endNumber
          duration:(CFTimeInterval)duration
  animationOptions:(PPCounterAnimationOptions)animationOptions
     currentNumber:(PPCurrentNumberBlock)currentNumber
        completion:(PPCompletionBlock)completion;

@end
