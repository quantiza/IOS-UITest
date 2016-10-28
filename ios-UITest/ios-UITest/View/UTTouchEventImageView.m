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
        UIImage *img = [UIImage imageNamed:@"andy"];
        [self setBackgroundColor:[UIColor colorWithPatternImage:img]];
    }
    return self;
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

- (void)showInfo:(NSString *)info {
    _uiViewTouch = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth-100, 30)];
    [_uiViewTouch setBackgroundColor:ORANGE_COLOR];
    _uiViewTouch.textAlignment = NSTextAlignmentCenter;
    _uiViewTouch.text = info;
    [self addSubview:_uiViewTouch];
    
    _uiCtrlTouch = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, kScreenWidth-100, 30)];
    _uiCtrlTouch.textAlignment = NSTextAlignmentCenter;
    [_uiCtrlTouch setBackgroundColor:WHITE_COLOR];
    _uiCtrlTouch.text = @"Waiting for touching...";
    [self addSubview:_uiCtrlTouch];
}

@end
