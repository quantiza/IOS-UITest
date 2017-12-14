//
//  UTBBViewController.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTBBViewController.h"
#import "FitConsts.h"
#import "UTBBView.h"


@interface UTBBViewController () {
    UTBBView *bbView;
}

@end

@implementation UTBBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.title = @"BBView";
    self.view.backgroundColor = WHITE_COLOR;
    NSLog(@"-------------------%ld", (long)_flag);
    
    bbView = [[UTBBView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:bbView];
    
    [bbView.dlgtMtdBtn addTarget:self action:@selector(delegateMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [bbView.notificationBtn addTarget:self action:@selector(notificationMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [bbView.blockBtn addTarget:self action:@selector(blockMethod) forControlEvents:UIControlEventTouchUpInside];
}

- (void)delegateMethod {
    NSLog(@"======================delegate");
    [self.delegate showName:bbView.nameTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
  
}

- (void)notificationMethod {
    NSLog(@"======================notification");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeNameNotification" object:self userInfo:@{@"name": bbView.nameTextField.text}];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)blockMethod {
    NSLog(@"=======================block");
    self.block(bbView.nameTextField.text);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
