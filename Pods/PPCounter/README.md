![](https://github.com/jkpang/PPCounter/blob/master/Picture/PPCounter.png)

![](https://img.shields.io/badge/platform-iOS | macOS-red.svg)   ![](https://img.shields.io/badge/language-Objective--C-orange.svg)  ![](https://img.shields.io/badge/pod-v0.6.0-blue.svg) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)  [![](https://img.shields.io/badge/weibo-%40CoderPang-yellow.svg)](http://weibo.com/5743737098/profile?rightmod=1&wvr=6&mod=personinfo&is_all=1)

iOS与macOS中一款优雅的数字/金额增减动效控件

![iPhone](https://github.com/jkpang/PPCounter/blob/master/Picture/PPCounter.gif)
![Mac](https://github.com/jkpang/PPCounter/blob/master/Picture/Mac.gif)

* 支持iOS/macOS双平台(pods版本v0.5.0起支持)
* 支持UILable/UIButton/自定义文本 控件的数字加减动画;
* 支持一般文本属性以及富文本属性的字体显示;
* 支持四种时间曲线函数动画:由慢到快再到慢、由慢到特别快、由快到慢、匀速;
* 支持自定义的文本格式,例如:数字格式化千分位显示;
* 支持CocoaPods导入


###新建 PP-iOS学习交流群 : 323408051 有关于PP系列封装的问题和iOS技术可以在此群讨论


###[简书地址](http://www.jianshu.com/p/53b9bac43201)

##Requirements 要求
* iOS 7+
* macOS 10.10+
* Xcode 8+

##Installation 安装
###1.手动安装:
`下载DEMO后,将子文件夹PPCounter拖入到项目中, 导入头文件 PPCounter.h 开始使用`
###2.CocoaPods安装:
first
`pod 'PPCounter',:git => 'https://github.com/jkpang/PPCounter.git'`

then
`pod install 或 pod install --no-repo-update`

如果发现pod search PPCounter 不是最新版本，在终端执行pod setup命令更新本地spec镜像缓存(时间可能有点长),重新搜索就OK了
##Usage 使用方法
###1. UILabel
####1.1 设置一般字体属性UILabel
```objc
....
[label pp_fromNumber:0 toNumber:100 duration:1.5 animationOptions:PPCounterAnimationOptionCurveEaseOut format:^NSString *(CGFloat number) {
    // 此处自由拼接内容
    return [NSString stringWithFormat:@"%.2f",number];
} completion:^{
        
    // 完成的回调
}];
```
####1.2 设置富文本字体属性UILabel

```objc
....
[label pp_fromNumber:0 toNumber:100 duration:1.5 animationOptions:PPCounterAnimationOptionCurveEaseOut attributedFormat:^NSAttributedString *(CGFloat number) {
        
    // 此处自由设置富文本属性的内容
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    return attributedString;
} completion:^{
        
    // 完成的回调
}];

```
###2. UIButton

####2.1 设置一般字体属性UIButton
```objc
....
[button pp_fromNumber:0 toNumber:100 duration:1.5 animationOptions:PPCounterAnimationOptionCurveEaseOut format:^NSString *(CGFloat number) {
    // 此处自由拼接内容
    return [NSString stringWithFormat:@"%.2f",number];
} completion:^{
        
    // 完成的回调
}];
```
####2.2 设置富文本字体属性UIButton

```objc
....
[button pp_fromNumber:0 toNumber:100 duration:1.5 animationOptions:PPCounterAnimationOptionCurveEaseOut attributedFormat:^NSAttributedString *(CGFloat number) {
        
    // 此处自由设置富文本属性的内容
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    return attributedString;
} completion:^{
        
    // 完成的回调
}];

```

以上就是PPCounter的简单使用方法,更详细的用法请看demo
###3, macOS Platform 使用

```objc
[[PPCounterEngine counterEngine] fromNumber:0
                                   toNumber:999
                                   duration:2.f
                          animationOptions:PPCounterAnimationOptionCurveEaseOut
                              currentNumber:^(CGFloat number) {
        // lable控件
        self.numberLabel.stringValue = [NSString stringWithFormat:@"%ld",(NSInteger)number];
    } completion:^{
    		// 计数完成的回调
        self.numberLabel.textColor = [NSColor redColor];
    }];
```
###你的star是我持续更新的动力!
===
##CocoaPods更新日志
* 2017.03.07(tag:0.6.0)--Mac下的定时器由 NSTimer --> dispatch_source_t;
* 2017.03.07(tag:0.5.0)--支持iOS/MacOS双平台;
* 2017.01.07(tag:0.2.0)--优化代码命名规范;
* 2016.10.23(tag:0.1.1)--优化代码结构与调用API方法;
* 2016.10.19(tag:0.1.0)--初始化到CocoaPods;

##联系方式:
* Weibo : @CoderPang
* Email : jkpang@outlook.com
* QQ群 : 323408051

![PP-iOS学习交流群群二维码](https://github.com/jkpang/PPCounter/blob/master/PP-iOS%E5%AD%A6%E4%B9%A0%E4%BA%A4%E6%B5%81%E7%BE%A4%E7%BE%A4%E4%BA%8C%E7%BB%B4%E7%A0%81.png)

##许可证
PPCounter 使用 MIT 许可证，详情见 LICENSE 文件。

