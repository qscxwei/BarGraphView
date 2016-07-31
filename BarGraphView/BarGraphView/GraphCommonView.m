//
//  GraphCommonView.m
//  BarGraphView
//
//  Created by qscxwei on 16/7/26.
//  Copyright © 2016年 com.cxw. All rights reserved.
//

#import "GraphCommonView.h"

@implementation GraphCommonView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:scrollView];
        
        leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, y_left_distance+1, frame.size.height-x_bottom_distance)];
        [self addSubview:leftView];
        
        yTipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, y_left_distance, y_top_distance)];
        yTipLabel.textColor = [UIColor darkGrayColor];
        yTipLabel.textAlignment = NSTextAlignmentRight;
        yTipLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:yTipLabel];
        
        
    }
    return self;
}

-(void)drawRect:(CGRect)frame{
    yTipLabel.text = _yLabelText;
    xShowArray = [NSMutableArray new];
    xShowTipDic = [NSMutableDictionary new];
    
    //计算x轴显示刻度值
    if([_xtype isEqualToString:@"日"]){
        [xShowArray addObjectsFromArray:@[@"0",@"4",@"8",@"12",@"16",@"20",@"24"]];
    }else if([_xtype isEqualToString:@"年"]){
        NSArray *array = [NSDate getMonths:13 startMonth:nil before:YES];
        NSString *year = @"";
        for (int i=0; i<array.count; i++) {
            if (i % YEAR_GAP == 0) {
                NSString *date = array[i];
                NSString *yearTemp = [date substringToIndex:4];
                if (![year isEqualToString:yearTemp]) {
                    [xShowTipDic setObject:yearTemp forKey:date];
                    year = yearTemp;
                }
                [xShowArray addObject:date];
            }
        }
    }else if([_xtype isEqualToString:@"周"]){
        NSArray *array = [NSDate getDays:7 startDay:nil before:YES];
        NSString *month = @"";
        for (int i=0; i<array.count; i++) {
            NSString *date = array[i];
            NSString *monthTemp = [date substringToIndex:6];
            if (![month isEqualToString:monthTemp]) {
                [xShowTipDic setObject:monthTemp forKey:date];
                month = monthTemp;
            }
            [xShowArray addObject:date];
        }
    }else if([_xtype isEqualToString:@"月"]){
        NSArray *array = [NSDate getDays:31 startDay:nil before:YES];
        NSString *month = @"";
        for (int i=0; i<array.count; i++) {
            if (i % MONTH_GAP == 0) {
                NSString *date = array[i];
                NSString *monthTemp = [date substringToIndex:6];
                if (![month isEqualToString:monthTemp]) {
                    [xShowTipDic setObject:monthTemp forKey:date];
                    month = monthTemp;
                }
                [xShowArray addObject:date];
            }
        }
    }else{
        //最大最小值平均值作为间距
        NSArray *keys = [_dataDic allKeys];
        CGFloat max = [_dataDic[keys[0]] floatValue];
        CGFloat min = [_dataDic[keys[0]] floatValue];
        for (int i=0; i<keys.count; i++) {
            CGFloat value = [_dataDic[keys[i]] floatValue];
            if (max<value) {
                max = value;
            }
            if (min>value) {
                min = value;
            }
        }
        int avg = ceilf((max-min)/NORMAl_GAP);
        for (int i=0; i<NORMAl_GAP; i++) {
            [xShowArray addObject:[NSString stringWithFormat:@"%0.0f",(avg*i+min)]];
        }
    }
    
    [self setYLine:frame];
    
    if (_graphType == GRAPHTYPE_LINE) {
        //添加x轴及折线图
        LineGraphView *lineGraphView = [[LineGraphView alloc]initWithFrame:CGRectMake(0, 0, _dataDic.count*x_each_width+x_left_distance+x_right_distance, frame.size.height)];
        lineGraphView.dataDic = _dataDic;
        lineGraphView.xShowArray = xShowArray;
        lineGraphView.xtype = _xtype;
        lineGraphView.xShowTipDic = xShowTipDic;
        lineGraphView.y_value_start = y_value_start;
        lineGraphView.y_point_start = y_point_start;
        lineGraphView.y_avg_height = y_avg_height;
        [scrollView addSubview:lineGraphView];
        scrollView.contentSize = CGSizeMake( xShowArray.count*x_each_width+x_left_distance+x_right_distance+y_left_distance, lineGraphView.frame.size.height);
    }else if(_graphType == GRAPHTYPE_BAR){
        //添加x轴及柱状图
        BarGraphView *barGraphView = [[BarGraphView alloc]initWithFrame:CGRectMake(0, 0, _dataDic.count*x_each_width+x_left_distance+x_right_distance, frame.size.height)];
        barGraphView.dataDic = _dataDic;
        barGraphView.xShowArray = xShowArray;
        barGraphView.xtype = _xtype;
        barGraphView.xShowTipDic = xShowTipDic;
        barGraphView.y_value_start = y_value_start;
        barGraphView.y_point_start = y_point_start;
        barGraphView.y_avg_height = y_avg_height;
        [scrollView addSubview:barGraphView];
        scrollView.contentSize = CGSizeMake( xShowArray.count*x_each_width+x_left_distance+x_right_distance+y_left_distance, barGraphView.frame.size.height);
    }
    
    
}


#pragma mark -- 设置y坐标轴
-(void)setYLine:(CGRect)frame{
    CGFloat frameHeight = frame.size.height;
    
    UIView *yLine = [[UIView alloc]initWithFrame:CGRectMake(y_left_distance, y_top_distance, 1, frameHeight-y_top_distance-x_bottom_distance)];
    yLine.backgroundColor = [UIColor lightGrayColor];
    [leftView addSubview:yLine];
    //设置刻度
    int count = (frameHeight-x_bottom_distance-y_top_distance)/y_each_width;
    
    y_point_start = frameHeight-x_bottom_distance-y_each_width;
    
    for (int i=0; i<=count; i++) {
        UIView *kdView = [[UIView alloc]initWithFrame:CGRectMake(y_left_distance-3, frameHeight-x_bottom_distance-i*y_each_width, 4, 1)];
        kdView.backgroundColor = [UIColor lightGrayColor];
        [leftView addSubview:kdView];
    }
    //设置刻度值
    NSArray *labelArray = [self completeYValue:count];
    
    
    y_avg_height = y_each_width/([labelArray[1] intValue]-[labelArray[0] intValue]);
    
    y_value_start = [labelArray[0] floatValue];
    for (int i=0; i<count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, frameHeight-x_bottom_distance-(i+1)*y_each_width-10, y_left_distance-10, 20)];
        label.text = labelArray[i];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentRight;
        [leftView addSubview:label];
    }
}

#pragma mark -- 计算y轴刻度值
-(NSArray *)completeYValue:(int)count{
    NSMutableArray *avgArray = [NSMutableArray new];
    NSArray *keys = [_dataDic allKeys];
    double value = [[_dataDic objectForKey:keys[0]] doubleValue];
    double max = value;
    double min = value;
    for (int i=0; i<keys.count; i++) {
        double value = [[_dataDic objectForKey:keys[i]] doubleValue];
        if (max<value) {
            max = value;
        }
        if (min > value) {
            min = value;
        }
    }
    double gap = (max-min)/(count-1);
    int gapInt = ceilf(gap);//向上取整
    for (int i=0; i<count; i++) {
        [avgArray addObject:[NSString stringWithFormat:@"%0.0f",min+gapInt*i]];
    }
    return avgArray;
}


@end
