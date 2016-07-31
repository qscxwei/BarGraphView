//
//  LineGraphView.h
//  BarGraphView
//
//  Created by qscxwei on 16/7/26.
//  Copyright © 2016年 com.cxw. All rights reserved.
//  折线图

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "common.h"


@interface LineGraphView : UIView{
    
    UILabel *showValueLabel;//显示数据
    NSString *x_value_start;//x轴起点值（最小值）
    CGFloat x_avg_width;//x轴平均宽度
    
}

@property(nonatomic,strong)NSDictionary *dataDic;//数据点
@property(nonatomic,strong)NSArray *xShowArray;//x轴显示刻度值
@property(nonatomic,strong)NSDictionary *xShowTipDic;//x轴显示提示刻度值
@property(nonatomic,strong)NSString *xtype;//x轴类型：日、周、月、年

@property CGFloat y_value_start;//y轴起点值（最小值）
@property CGFloat y_avg_height;//y轴刻度平均间距
@property CGFloat y_point_start;//y轴起始点






@end
