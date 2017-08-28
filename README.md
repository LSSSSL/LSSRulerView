# LSSRulerView
[![Ruller](https://img.shields.io/badge/Ruller-1.0.0-ff69b4.svg)](https://github.com/LSSSSL/LSSRulerView)

## 功能描述
1. UICollectionView定多样式刻度尺、适用视频播放进度尺、度量尺
2. 分段设置区域位置、区域色彩、放大缩小刻度值
3. 自动按属性刻度滚动尺标、定位具体时间

![image](https://github.com/LSSSSL/LSSRulerView/blob/master/%20Image/img.gif)

## 环境配置
* Xcode 6 or higher
* iOS 7.0 or higher
* ARC

## 文件介绍
1.LSSRulerView   主类 主要的刻度尺逻辑功能的实现
2.LSSRulerTool 改类包含 视频数据数组模型定义(视频播放用)、Date Time 函数的集合
3.LSSRulerConst.h 基本使用宏的定义

## 使用
1.所有你需要做的就是把Class文件导入到您的项目,并添加#import "LSSRulerView.h"、#import "LSSRulerTool.h"的类将使用它。
