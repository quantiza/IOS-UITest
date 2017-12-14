//
//  UTAAView.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTAAView.h"
#import "FitConsts.h"

@implementation UTAAView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    //属性传值按钮
    _showBBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 30)];
    _showBBBtn.backgroundColor = COLOR_GRAY_DARK;
    [_showBBBtn setTitle:@"showBB" forState:UIControlStateNormal];
    [self addSubview:_showBBBtn];
    
    //通过代理方法获取字符串的label
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 30)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = ORANGE_COLOR;
    _nameLabel.backgroundColor = COLOR_GRAY_LIGHT;
    [self addSubview:_nameLabel];
}

@end
