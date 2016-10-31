//
//  UTSectionHeadView.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/31.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTSectionHeadView.h"

@implementation UTSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame andIndex:(NSInteger)index{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        _index = index;
    }
    return self;
}

- (void)createUI {
    
}

@end
