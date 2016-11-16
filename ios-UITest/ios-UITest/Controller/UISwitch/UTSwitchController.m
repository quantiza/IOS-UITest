//
//  UTSwitchController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/2.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTSwitchController.h"
#import "FitConsts.h"

@interface UTSwitchController ()

@end

@implementation UTSwitchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"UISwitch Test";
    //忽略了长宽的设置
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth/2, 100, 200, 300)];
    switchView.backgroundColor = BG_GRAY_COLOR;
    [switchView setOn:YES animated:YES];        //设置初始状态为开，默认关
    switchView.onTintColor = ORANGE_COLOR;      //ON的颜色
    switchView.thumbTintColor = RED_COLOR;      //thumb颜色
    switchView.tintColor = PURPLE_COLOR;        //边框颜色
    [self.view addSubview:switchView];
    
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
}


- (void)switchAction:(UISwitch *)sw {
    NSLog(@"==========state of switch %d", sw.isOn);
}



@end
