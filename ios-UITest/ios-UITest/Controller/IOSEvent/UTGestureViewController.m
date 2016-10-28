//
//  UTGestureViewController.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/29.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTGestureViewController.h"
#import "FitConsts.h"
#import "UTGestureView.h"

@interface UTGestureViewController ()

@end

@implementation UTGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    self.view.backgroundColor = BG_GRAY_COLOR;
    self.title = @"Gesture Recognizer";
    
    UTGestureView *gestureVi = [[UTGestureView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2)];
    [self.view addSubview:gestureVi];
}

@end
