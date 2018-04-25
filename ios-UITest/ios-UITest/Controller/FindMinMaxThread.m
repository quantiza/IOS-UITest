//
//  FindMinMaxThread.m
//  ios-UITest
//
//  Created by Long Yang on 2018/4/25.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "FindMinMaxThread.h"

@implementation FindMinMaxThread {
    NSArray *_numbers;
}

- (instancetype)initWithNumbers:(NSArray *)numbers {
    self = [super init];
    if (self) {
        _numbers = numbers;
    }
    return self;
}

- (void)main {
    NSUInteger min = 0;
    NSUInteger max = 0;
    self.min = min;
    self.max = max;
}

@end
