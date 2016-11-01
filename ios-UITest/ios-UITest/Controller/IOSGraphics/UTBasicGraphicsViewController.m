//
//  UTBasicGraphicsViewController.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/31.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTBasicGraphicsViewController.h"
#import "FitConsts.h"
#import "UTBasicGraphicsView.h"

@interface UTBasicGraphicsViewController ()

@end

@implementation UTBasicGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutInit];
    
    // Do any additional setup after loading the view.
}

- (void)layoutInit {
    self.view.backgroundColor = ORANGE_COLOR;
    self.title = @"Basic Graphics";
    UTBasicGraphicsView *graphView = [[UTBasicGraphicsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    graphView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:graphView];
}



@end
