//
//  UTSegmentedController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/2.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTSegmentedController.h"
#import "FitConsts.h"

@interface UTSegmentedController ()

@end

@implementation UTSegmentedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.view.backgroundColor = BG_GRAY_COLOR;
    self.title = @"UISegmentedControl Test";
    
    NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(20, 20, kScreenWidth-40, 50);
    segmentedControl.tag = 101;
    segmentedControl.selectedSegmentIndex = 2;      //默认选中项索引
    segmentedControl.tintColor = COLOR_RED_LIGHT;   //默认颜色
    segmentedControl.momentary = NO;                //设置点击后是否复原
    
    [segmentedControl setTitle:@"two" forSegmentAtIndex:1]; //设置指定索引的标题
    //[segmentedControl setImage:[UIImage imageNamed:@"girl"] forSegmentAtIndex:3];
    [segmentedControl insertSegmentWithTitle:@"insert" atIndex:2 animated:YES]; ////在指定索引插入一个选项并设置题目
    [segmentedControl removeSegmentAtIndex:3 animated:YES];
    [segmentedControl setWidth:20 forSegmentAtIndex:0];  //设置指定索引的宽度
    
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}


- (void)segmentAction:(UISegmentedControl *)seg {
    NSInteger index = seg.selectedSegmentIndex;
    NSLog(@"Index %li", (long)index);
}

















@end
