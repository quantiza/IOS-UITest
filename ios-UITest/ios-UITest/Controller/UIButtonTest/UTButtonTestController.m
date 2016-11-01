//
//  UTButtonTestController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTButtonTestController.h"
#import "FitConsts.h"

@interface UTButtonTestController ()

@end

@implementation UTButtonTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"UIButton Test";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //UIButton *btn = [[UIButton alloc] init];  //这种按钮初始化默认标题文字为白色
    btn.frame = CGRectMake(50, 50, kScreenWidth-100, 40);
    btn.backgroundColor = BG_GRAY_COLOR;
    [btn setTitle:@"UIButtonTypeRoundedRect" forState:UIControlStateNormal];
    //[btn setTitle:@"ZoomIn" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(zoomInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.titleLabel.textColor = RED_COLOR;
    [btn1 setTitle:@"Yes" forState:UIControlStateNormal];
    [btn1 setTitleShadowColor:RED_COLOR forState:UIControlStateNormal];
    btn1.frame = CGRectMake(100, 100, kScreenWidth-200, 40);
    btn1.backgroundColor = BG_GRAY_COLOR;
    [btn1 addTarget:self action:@selector(zoomInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
}

- (void)zoomInAction:(id)sender {
    UIButton *u = (UIButton *)sender;
    NSLog(@"=====================%@", u.titleLabel);
    NSLog(@"=====================%@", u.currentTitleShadowColor);

    //u.selected = !u.selected;
    //u.titleLabel.textColor = WHITE_COLOR;
   // u.titleLabel.hidden = NO;
}



@end
