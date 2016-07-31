//
//  common.h
//  BarGraphView
//
//  Created by qscxwei on 16/7/21.
//  Copyright © 2016年 com.cxw. All rights reserved.
//

#import "UIColor+BarGraphView.h"
#import "NSDate+BarGraphView.h"

static const int MONTH_GAP = 5;//月显示间隔
static const int YEAR_GAP = 3;//年显示间隔
static const int NORMAl_GAP = 6;//普通显示间隔

static const CGFloat point_width = 3;

static const CGFloat x_each_width = 60;//x轴刻度间距
static const CGFloat x_bottom_distance = 50;//x轴距底边距离
static const CGFloat x_left_distance = 20;//左边距
static const CGFloat x_right_distance = 20;//右边距
static const CGFloat y_top_distance = 20;//上边距

static const CGFloat y_each_width = 40;//y轴刻度个数
static const CGFloat y_left_distance = 40;//y轴距左边距离


//———————————————— 适配
//纯计算：
#define f_Device_w         [UIScreen mainScreen].bounds.size.width
#define f_Device_h  	    [UIScreen mainScreen].bounds.size.height

//基础字体大小
#define MAIN_FONT [UIFont systemFontOfSize:FONT_SIZE]


