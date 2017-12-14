//
//  UTTouchEventImageView.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/28.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTTouchEventImageView.h"
#import "FitConsts.h"

@implementation UTTouchEventImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = RED_COLOR;
    //touch的图片
    UIImage *img = [UIImage imageNamed:@"andy"];
    _imgView = [[UIImageView alloc] initWithImage:img];
    [self addSubview:_imgView];
    //touch视图显示信息的label
    _uiViewTouch = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth-100, 30)];
    _uiViewTouch.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_uiViewTouch];
    //touch视图控制器显示信息的label
    _uiCtrlTouch = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, kScreenWidth-100, 30)];
    _uiCtrlTouch.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_uiCtrlTouch];
    //控制视图能否touch的按钮
    _interactionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/4, 10, kScreenWidth/2, 30)];
    _interactionBtn.backgroundColor = COLOR_GRAY_LIGHT;
    [_interactionBtn addTarget:self action:@selector(setInterEnabled) forControlEvents:UIControlEventTouchUpInside];
    [_interactionBtn setTitle:@"InteractionEnabled=YES" forState:UIControlStateNormal];
    _interactionBtn.tag = 1;
    [self addSubview:_interactionBtn];
}

- (void)setInterEnabled {
    NSLog(@"aaaa");
    if (_interactionBtn.tag==0) {
        self.userInteractionEnabled = NO;
        [_interactionBtn setTitle:@"InteractionEnabled=NO" forState:UIControlStateNormal];
        _interactionBtn.tag = 1;
    }
    else {
        self.userInteractionEnabled = YES;
        [_interactionBtn setTitle:@"InteractionEnabled=YES" forState:UIControlStateNormal];
        _interactionBtn.tag = 0;
    }
}

#pragma mark - UIView Touch Event 视图触摸事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIView touches began...");
    [self showInfo:@"UIView touches began..."];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIView touches moved...");
    [self showInfo:@"UIView touches moved..."];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIView touches ended...");
    [self showInfo:@"UIView touches ended..."];
}

// touch induce info
- (void)showInfo:(NSString *)info {
    [_uiViewTouch setBackgroundColor:ORANGE_COLOR];
    _uiViewTouch.text = info;
    [_uiCtrlTouch setBackgroundColor:WHITE_COLOR];
    _uiCtrlTouch.text = @"Waiting for touching...";
}

@end
