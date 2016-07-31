//
//  NSDate+BarGraphView.h
//  BarGraphView
//
//  Created by qscxwei on 16/7/28.
//  Copyright © 2016年 com.cxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BarGraphView)

#pragma mark -- 获取一定数量的天数：天数、开始日期（nil为当天）、之前还是之后
+(NSArray *)getDays:(int)dayCount startDay:(NSString *)startDay before:(BOOL)isBefore;

#pragma mark -- 获取一定数量的月数：月数、开始月份（nil为当天）、之前还是之后
+(NSArray *)getMonths:(int)monthCount startMonth:(NSString *)startMonth before:(BOOL)isBefore;

#pragma mark -- 计算两个日期的间隔日期
+(int)gapWithDays:(NSString *)startDate endDay:(NSString *)endDate;

#pragma mark -- 计算两个月份的间隔
+(int)gapWithMonths:(NSString *)startDate endDay:(NSString *)endDate;


@end
