//
//  UIColor+BarGraphView.m
//  BarGraphView
//
//  Created by qscxwei on 16/7/21.
//  Copyright © 2016年 com.cxw. All rights reserved.
//

#import "UIColor+BarGraphView.h"

@implementation UIColor (BarGraphView)

+(UIColor *)COLOR_eeeeee{
    return [self stringToColor:@"#eeeeee"];
}


+(UIColor *)COLOR_9d55b8{
    return [self stringToColor:@"#9d55b8"];
}

#pragma mark -- 蓝色
+(UIColor *)COLOR_02b9f5{
    return [self stringToColor:@"#02b9f5"];
}

+(UIColor *)COLOR_0299f5{
    return [self stringToColor:@"#0299f5"];
}



+(UIColor *)stringToColor:(NSString *)string{
    return [UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[string substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[string substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[string substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:1.0];
}

@end
