//
//  UTAAViewController.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTAAViewController.h"
#import "FitConsts.h"
#import "UTAAView.h"
#import "UTBBViewController.h"


@interface UTAAViewController ()<UTBBViewDelegate> {
    UTAAView *aaView;
}

@end

@implementation UTAAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNameNotification:) name:@"ChangeNameNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printSth) name:@"test" object:nil];
    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.title = @"AAView";
    self.view.backgroundColor = WHITE_COLOR;
    aaView = [[UTAAView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [aaView.showBBBtn addTarget:self action:@selector(showBBView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aaView];
    
}

#pragma mark 属性传值
- (void)showBBView {
    UTBBViewController *bbVC = [[UTBBViewController alloc] init];
    bbVC.flag = 2;
    bbVC.delegate = self;
    [self.navigationController pushViewController:bbVC animated:YES];
    //block 传值
    bbVC.block = ^(NSString *str) {
        aaView.nameLabel.text = str;
    };
}

#pragma mark 代理传值方法代理传
- (void)showName:(NSString *)nameStr {
    aaView.nameLabel.text = nameStr;
}

#pragma mark  通知传值练习
//接收通知后使用方法调用通知的userInfo
- (void)changeNameNotification:(NSNotification *)notification {
    NSDictionary *nameDictionary = [notification userInfo];
    aaView.nameLabel.text = [nameDictionary objectForKey:@"name"];
}
//接收通知调用方法
- (void)printSth {
    NSLog(@"A receive notification of B.");
}
//移除通知接收器
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
