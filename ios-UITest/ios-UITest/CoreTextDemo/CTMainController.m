//
//  CTMainController.m
//  ios-UITest
//
//  Created by Long Yang on 2018/4/17.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "CTMainController.h"

@interface CTMainController ()

@end

@implementation CTMainController

__weak NSString *string_weak_ = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    // 场景 1
    NSArray *arr;
    @autoreleasepool {
        arr = @[@"hello", @"text"];
    }
    // 场景 2
    //    @autoreleasepool {
    //        NSString *string = [NSString stringWithFormat:@"leichunfeng"];
    //        string_weak_ = string;
    //    }
    // 场景 3
    //    NSString *string = nil;
    //    @autoreleasepool {
    //        string = [NSString stringWithFormat:@"leichunfeng"];
    //        string_weak_ = string;
    //    }
    NSLog(@"string: %@", arr);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"string: %@", string_weak_);
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"string: %@", string_weak_);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
