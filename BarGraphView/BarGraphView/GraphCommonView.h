//
//  GraphCommonView.h
//  BarGraphView
//
//  Created by qscxwei on 16/7/26.
//  Copyright © 2016年 com.cxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineGraphView.h"
#import "BarGraphView.h"

typedef enum : NSUInteger {
    GRAPHTYPE_LINE = 0,
    GRAPHTYPE_BAR = 1,
} GRAPHTYPE;


@interface GraphCommonView : UIView{
    
    UIScrollView *scrollView;//数据显示区域;
    UIView *leftView;//左侧y轴所在区域
    UILabel *yTipLabel;//y轴提示信息视图
    
    CGFloat y_avg_height;//y轴显示值平均高度
    CGFloat y_value_start;//y轴起始值
    CGFloat y_point_start;//y轴起始点
    
    NSMutableArray *xShowArray;//x轴显示刻度值
    NSMutableDictionary *xShowTipDic;//x轴显示提示刻度值
}

@property GRAPHTYPE graphType;//图形类型

@property(nonatomic,strong)NSDictionary *dataDic;//数据点
@property(nonatomic,strong)NSString *xtype;//x轴类型：日、周、月、年
@property(nonatomic,strong)NSString *yLabelText;//y轴标签

@end
