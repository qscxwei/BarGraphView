//
//  LineGraphView.m
//  BarGraphView
//
//  Created by qscxwei on 16/7/26.
//  Copyright © 2016年 com.cxw. All rights reserved.
//  折线图

#import "LineGraphView.h"

@implementation LineGraphView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(y_left_distance, 0, frame.size.width, frame.size.height)];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        showValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        showValueLabel.backgroundColor = [UIColor COLOR_9d55b8];
        showValueLabel.textColor = [UIColor whiteColor];
        showValueLabel.textAlignment = NSTextAlignmentCenter;
        showValueLabel.hidden = YES;
        [self addSubview:showValueLabel];
        
    }
    return self;
}

- (void)drawRect:(CGRect)frame
{
    [self setClearsContextBeforeDrawing: YES];
    
    x_value_start = _xShowArray[0];
    
    [self setXLine:frame];
    [self drawLine];

}


#pragma mark -- 设置x坐标轴
-(void)setXLine:(CGRect)frame{
    UIView *xLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-x_bottom_distance, _xShowArray.count*x_each_width+x_left_distance, 1)];
    xLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:xLine];
    
    //设置刻度
    for (int i=0; i<_xShowArray.count; i++) {
        UIView *kdView = [[UIView alloc]initWithFrame:CGRectMake(x_left_distance+i*x_each_width, frame.size.height-x_bottom_distance, 1, 3)];
        kdView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:kdView];
    }
    //设置刻度值
    for (int i=0; i<_xShowArray.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, x_each_width, 20)];
        if([_xtype isEqualToString:@"年"]){
            label.text = [NSString stringWithFormat:@"%d月",[[_xShowArray[i] substringFromIndex:4] intValue]];
        }else if([_xtype isEqualToString:@"月"] || [_xtype isEqualToString:@"周"]){
            label.text = [NSString stringWithFormat:@"%d日",[[_xShowArray[i] substringFromIndex:6] intValue]];
        }else{
            if([_xtype isEqualToString:@"日"]){
                label.text = [NSString stringWithFormat:@"%@h",_xShowArray[i]];
            }else{
                label.text = [NSString stringWithFormat:@"%@%@",_xShowArray[i],_xtype];
            }
        }
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(x_left_distance+i*x_each_width, frame.size.height-x_bottom_distance+15);
        [self addSubview:label];
        //显示x轴提示信息
        NSString *tip = [_xShowTipDic objectForKey:_xShowArray[i]];
        if(tip.length>0){
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, x_each_width, 20)];
            if ([_xtype isEqualToString:@"周"] || [_xtype isEqualToString:@"月"]) {
                label2.text = [NSString stringWithFormat:@"%d月",[[tip substringFromIndex:4] intValue]];
            }else if([_xtype isEqualToString:@"年"]){
                label2.text = [NSString stringWithFormat:@"%@年",[tip substringToIndex:4]];
            }
            
            label2.textColor = [UIColor lightGrayColor];
            label2.font = [UIFont systemFontOfSize:12];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.center = CGPointMake(x_left_distance+i*x_each_width, frame.size.height-x_bottom_distance+32);
            [self addSubview:label2];
        }
    }
}

#pragma mark -- 画线
-(void)drawLine{
    //计算x轴均值
    if([_xtype isEqualToString:@"年"]){
        x_avg_width = x_each_width/YEAR_GAP;
    }else if([_xtype isEqualToString:@"月"]){
        x_avg_width = x_each_width/MONTH_GAP;
    }else if([_xtype isEqualToString:@"周"]){
        x_avg_width = x_each_width;
    }else{
        x_avg_width = x_each_width/([_xShowArray[1] floatValue]-[_xShowArray[0] floatValue]);
    }
    
    int count = _dataDic.count;
    
    CGPoint addLines[count];
    if([_xtype isEqualToString:@"年"]){
        NSArray *keys = [[_dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        for (int i=0; i<keys.count; i++) {
            UIButton *pointButton = [[UIButton alloc]init];
            pointButton.backgroundColor = [UIColor COLOR_0299f5];
            pointButton.layer.cornerRadius = point_width;
            pointButton.frame = CGRectMake(0, 0, point_width*2, point_width*2);
            
            NSString *xvalue = keys[i];
            CGFloat yvalue = [[_dataDic objectForKey:keys[i]] floatValue];
            CGFloat point_x = x_left_distance + [NSDate gapWithMonths:x_value_start endDay:xvalue]*x_avg_width;
            CGFloat point_y = _y_point_start - (yvalue-_y_value_start)*_y_avg_height;
            addLines[i].x = point_x;
            addLines[i].y = point_y;
            
            pointButton.center = CGPointMake(point_x, point_y);
            pointButton.tag = i+1;
            //            [pointButton addTarget:self action:@selector(showValue:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:pointButton];
        }
    }else if([_xtype isEqualToString:@"月"] || [_xtype isEqualToString:@"周"]){
        NSArray *keys = [[_dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        for (int i=0; i<_dataDic.count; i++) {
            UIButton *pointButton = [[UIButton alloc]init];
            pointButton.backgroundColor = [UIColor COLOR_0299f5];
            pointButton.layer.cornerRadius = point_width;
            pointButton.frame = CGRectMake(0, 0, point_width*2, point_width*2);
            
            NSString *xvalue = keys[i];
            CGFloat yvalue = [[_dataDic objectForKey:keys[i]] floatValue];
            CGFloat point_x = x_left_distance + [NSDate gapWithDays:x_value_start endDay:xvalue]*x_avg_width;
            CGFloat point_y = _y_point_start - (yvalue-_y_value_start)*_y_avg_height;
            addLines[i].x = point_x;
            addLines[i].y = point_y;
            pointButton.center = CGPointMake(point_x, point_y);
            pointButton.tag = i+1;
            //            [pointButton addTarget:self action:@selector(showValue:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:pointButton];
        }
    }else{
        NSArray *keys = [[_dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        for (int i=0; i<keys.count; i++) {
            UIButton *pointButton = [[UIButton alloc]init];
            pointButton.backgroundColor = [UIColor COLOR_0299f5];
            pointButton.layer.cornerRadius = point_width;
            pointButton.frame = CGRectMake(0, 0, point_width*2, point_width*2);
            
            CGFloat xvalue = [keys[i] floatValue];
            CGFloat yvalue = [[_dataDic objectForKey:keys[i]] floatValue];
            CGFloat point_x = x_left_distance + (xvalue-[x_value_start floatValue])*x_avg_width;
            CGFloat point_y = _y_point_start - (yvalue-_y_value_start)*_y_avg_height;
            addLines[i].x = point_x;
            addLines[i].y = point_y;
            pointButton.center = CGPointMake(point_x, point_y);
            pointButton.tag = i+1;
            //            [pointButton addTarget:self action:@selector(showValue:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:pointButton];
        }
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context , kCGLineCapRound);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextBeginPath(context);
    CGContextAddLines(context, addLines, count);
    CGContextSetLineWidth(context,2);
    CGContextSetStrokeColorWithColor(context, [UIColor COLOR_02b9f5].CGColor);
    CGContextStrokePath(context);
    
}

#pragma mark -- 显示数值
-(void)showValue:(UIButton *)button{
    int tag = button.tag-1;
//    CGFloat xvalue = [[_dataArray[tag] objectForKey:@"x"] floatValue];
//    CGFloat yvalue = [[_dataArray[tag] objectForKey:@"y"] floatValue];
//    CGFloat point_x = x_left_distance + (xvalue-x_value_start)*x_each_width;
//    CGFloat point_y = _y_point_start - (yvalue-_y_value_start)*_y_avg_height;
//    showValueLabel.center = CGPointMake(point_x, point_y-15);
//    showValueLabel.hidden = NO;
//    showValueLabel.text = [_dataArray[tag] objectForKey:@"y"];
    
    
}

@end
