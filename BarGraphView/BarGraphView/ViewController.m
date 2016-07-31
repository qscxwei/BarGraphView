//
//  ViewController.m
//  BarGraphView
//
//  Created by qscxwei on 16/7/20.
//  Copyright © 2016年 com.cxw. All rights reserved.
//

#import "ViewController.h"
#import "GraphCommonView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor COLOR_eeeeee];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *array = @[@"日",@"周",@"月",@"年",@"其他"];
    
    UISegmentedControl *segmentCtr = [[UISegmentedControl alloc]initWithItems:array];
    segmentCtr.frame = CGRectMake(10, 70, f_Device_w-20, 30);
    segmentCtr.selectedSegmentIndex = 0;
    [segmentCtr addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentCtr];
    
    NSString *type = @"日";
    NSArray *dayarray = @[@"1",@"3",@"9",@"10",@"11",@"12",@"20",@"22",@"23"];
    NSArray *yarray = @[@"30",@"10",@"27",@"25",@"13",@"29",@"10",@"20",@"19",@"11"];
    NSMutableDictionary *dataDic = [NSMutableDictionary new];
    for (int i=0; i<dayarray.count; i++) {
        [dataDic setObject:yarray[i] forKey:dayarray[i]];
    }
    
    GraphCommonView *lineChartView = [[GraphCommonView alloc]initWithFrame:CGRectMake(0, 120, f_Device_w, 300)];
    lineChartView.dataDic = dataDic;
    lineChartView.xtype = type;
    lineChartView.yLabelText = @"温度";
    lineChartView.graphType = GRAPHTYPE_LINE;
    [self.view addSubview:lineChartView];
    
}

-(void)changeView:(UISegmentedControl *)segmentCtr{
    if(segmentCtr.selectedSegmentIndex == 0){
        NSString *type = @"日";
        NSArray *dayarray = @[@"1",@"3",@"9",@"10",@"11",@"12",@"20",@"22",@"23"];
        NSArray *yarray = @[@"30",@"10",@"27",@"25",@"13",@"29",@"10",@"20",@"19",@"11"];
        NSMutableDictionary *dataDic = [NSMutableDictionary new];
        for (int i=0; i<dayarray.count; i++) {
            [dataDic setObject:yarray[i] forKey:dayarray[i]];
        }
        
        GraphCommonView *lineChartView = [[GraphCommonView alloc]initWithFrame:CGRectMake(0, 120, f_Device_w, 300)];
        lineChartView.dataDic = dataDic;
        lineChartView.xtype = type;
        lineChartView.yLabelText = @"温度";
        lineChartView.graphType = GRAPHTYPE_LINE;
        [self.view addSubview:lineChartView];
    }else if (segmentCtr.selectedSegmentIndex == 1){
        NSString *type = @"周";
        NSArray *weekarray = [NSDate getDays:7 startDay:@"20160729" before:YES];
        NSArray *yarray = @[@"30",@"10",@"27",@"25",@"13",@"29",@"10",@"20",@"19",@"11"];
        NSMutableDictionary *dataDic = [NSMutableDictionary new];
        for (int i=0; i<weekarray.count; i++) {
            [dataDic setObject:yarray[i] forKey:weekarray[i]];
        }
        
        GraphCommonView *lineChartView = [[GraphCommonView alloc]initWithFrame:CGRectMake(0, 120, f_Device_w, 300)];
        lineChartView.dataDic = dataDic;
        lineChartView.xtype = type;
        lineChartView.yLabelText = @"温度";
        lineChartView.graphType = GRAPHTYPE_LINE;
        [self.view addSubview:lineChartView];
    }else if (segmentCtr.selectedSegmentIndex == 2){
        NSString *type = @"月";
        NSArray *montharray = @[@"20160630",@"20160702",@"20160705",@"20160706",@"20160713",@"20160720",@"20160726",@"20160727",@"20160728"];
        NSArray *yarray = @[@"30",@"10",@"27",@"25",@"13",@"29",@"10",@"20",@"19",@"11"];
        NSMutableDictionary *dataDic = [NSMutableDictionary new];
        for (int i=0; i<montharray.count; i++) {
            [dataDic setObject:yarray[i] forKey:montharray[i]];
        }
        
        GraphCommonView *lineChartView = [[GraphCommonView alloc]initWithFrame:CGRectMake(0, 120, f_Device_w, 300)];
        lineChartView.dataDic = dataDic;
        lineChartView.xtype = type;
        lineChartView.yLabelText = @"温度";
        lineChartView.graphType = GRAPHTYPE_BAR;
        [self.view addSubview:lineChartView];

    }else if (segmentCtr.selectedSegmentIndex == 3){
        NSString *type = @"年";
        NSArray *yeararray = @[@"201607",@"201508",@"201509",@"201512",@"201601",@"201603",@"201604",@"201605",@"201606",@"201607"];
        NSArray *yarray = @[@"30",@"10",@"27",@"25",@"13",@"29",@"10",@"20",@"19",@"11"];
        NSMutableDictionary *dataDic = [NSMutableDictionary new];
        for (int i=0; i<yeararray.count; i++) {
            [dataDic setObject:yarray[i] forKey:yeararray[i]];
        }
        
        GraphCommonView *lineChartView = [[GraphCommonView alloc]initWithFrame:CGRectMake(0, 120, f_Device_w, 300)];
        lineChartView.dataDic = dataDic;
        lineChartView.xtype = type;
        lineChartView.yLabelText = @"温度";
        lineChartView.graphType = GRAPHTYPE_LINE;
        [self.view addSubview:lineChartView];
    }else{
        NSString *type = @"";
        NSArray *otherArray = @[@"10",@"20",@"19",@"11",@"30",@"10",@"27",@"25",@"13",@"29"];
        NSArray *yarray = @[@"30",@"10",@"27",@"25",@"13",@"29",@"10",@"20",@"19",@"11"];
        NSMutableDictionary *dataDic = [NSMutableDictionary new];
        for (int i=0; i<otherArray.count; i++) {
            [dataDic setObject:yarray[i] forKey:otherArray[i]];
        }
        
        GraphCommonView *lineChartView = [[GraphCommonView alloc]initWithFrame:CGRectMake(0, 120, f_Device_w, 300)];
        lineChartView.dataDic = dataDic;
        lineChartView.xtype = type;
        lineChartView.yLabelText = @"温度";
        lineChartView.graphType = GRAPHTYPE_BAR;
        [self.view addSubview:lineChartView];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
