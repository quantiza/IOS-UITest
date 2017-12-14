//
//  PNChartViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/13.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "PNChartViewController.h"
#import <PNChart.h>
#import "FitConsts.h"

@interface PNChartViewController ()

@property (strong, nonatomic) UIScrollView* scrollView;

@end

@implementation PNChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];

}

- (void)createUI {
    self.navigationItem.title = @"PNChart";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawLineChart];
    [self drawBarChart];
    [self drawCircleChart];
    [self drawPieChart];
}


#pragma mark - 绘制 Line Chart
- (void)drawLineChart {

    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight/4)];
    lineChart.showSmoothLines = YES;
    
    [lineChart setXLabels:@[@"F",@"S",@"T",@"F"]];
    NSArray *data01Array = @[@20, @30, @40, @50];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
    [self.scrollView addSubview:lineChart];
    [self drawSplitLine:kScreenHeight/4];
}

#pragma mark - 绘制 Bar Chart
- (void)drawBarChart {
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 20+kScreenHeight/4, kScreenWidth, 200)];
    [barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    [barChart setYValues:@[@1,  @10, @2, @6, @3]];
    [barChart strokeChart];
    [_scrollView addSubview:barChart];
    [self drawSplitLine:20+kScreenHeight/4+200+10];
}

#pragma mark - 绘制 Circle Chart
- (void)drawCircleChart {
    PNCircleChart *circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 100+2*kScreenHeight/4, SCREEN_WIDTH, 80) total:@100 current:@60 clockwise:YES shadow:YES shadowColor:BG_GRAY_COLOR];
    circleChart.backgroundColor = [UIColor clearColor];
    [circleChart setStrokeColor:PNGreen];
    [circleChart strokeChart];
    [_scrollView addSubview:circleChart];
    [self drawSplitLine:100+2*kScreenHeight/4+80+10];
}

#pragma mark - 绘制 Pie Chart
- (void)drawPieChart {
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(50, 200+2*kScreenHeight/4, 200, 200) items:items];
    pieChart.descriptionTextColor = WHITE_COLOR;
    [pieChart strokeChart];
    
    [_scrollView addSubview:pieChart];
    [self drawSplitLine:400+2*kScreenHeight/4];
}



- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*2);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


- (void)drawSplitLine:(CGFloat)height {
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, height, kScreenWidth , 5)];
    line.backgroundColor = PNLightBlue;
    [_scrollView addSubview:line];
}


@end
