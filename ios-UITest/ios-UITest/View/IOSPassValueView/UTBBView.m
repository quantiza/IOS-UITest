//
//  UTBBView.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTBBView.h"
#import "FitConsts.h"

@implementation UTBBView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, kScreenWidth-100, 40)];
    [_nameTextField setPlaceholder:@"Input your name..."];
    [_nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self addSubview:_nameTextField];
    
    _dlgtMtdBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 150, kScreenWidth/2, 40)];
    [_dlgtMtdBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [_dlgtMtdBtn setTitle:@"delegateMethod" forState:UIControlStateNormal];
    [self addSubview:_dlgtMtdBtn];
    
    _notificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 200, kScreenWidth/2, 40)];
    [_notificationBtn setTitle:@"notificationMethod" forState:UIControlStateNormal];
    [_notificationBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self addSubview:_notificationBtn];
    
    _blockBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 250, kScreenWidth/2, 40)];
    [_blockBtn setTitle:@"blockMethod" forState:UIControlStateNormal];
    [_blockBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self addSubview:_blockBtn];
    
}

@end
