//
//  UTDatePickerTestController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTDatePickerTestController.h"
#import "FitConsts.h"

@interface UTDatePickerTestController ()

@end

@implementation UTDatePickerTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];

    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.view.backgroundColor = BG_GRAY_COLOR;
    self.title = @"DatePicker";
    //1.查看跟踪所有可用的地区标识，取出想要的地区
    NSLog(@"==========%@",[NSLocale availableLocaleIdentifiers]);
    //2.设置日期选择控件的地区,中国地区标识是："zh_Hans_CN"或者"zh_CN"
    
    UIButton *dateView = [[UIButton alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:dateView];
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kScreenHeight/2, kScreenWidth, kScreenHeight/3)];
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    [datePicker setDate:[NSDate date]];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [dateView addSubview:datePicker];
    [dateView addTarget:self action:@selector(hideDateView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)datePickerValueChanged:(UIDatePicker *)datePicker {
    NSLog(@"============hello=======%@",datePicker.date);
}

- (void)hideDateView:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.hidden = YES;
}
@end
