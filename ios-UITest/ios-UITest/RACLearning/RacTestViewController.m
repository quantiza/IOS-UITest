//
//  RacTestViewController.m
//  ios-UITest
//
//  Created by Long Yang on 2018/1/15.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "RacTestViewController.h"
#import <ReactiveObjC.h>
@interface RacTestViewController ()

@end

@implementation RacTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.title = @"RAC-DEMO";
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"destroy...");
        }];
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"recive....%@", x);
    }];
}

@end
