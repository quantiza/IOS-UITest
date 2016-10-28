//
//  UTTouchEventViewController.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/28.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTTouchEventViewController.h"
#import "UTTouchEventImageView.h"
#import "FitConsts.h"

@interface UTTouchEventViewController () {
    UTTouchEventImageView *image;
}

@end

@implementation UTTouchEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark UIView init...
- (void)createUI {
    self.view.backgroundColor = BG_GRAY_COLOR;
    self.title = @"Touch Event";
    image = [[UTTouchEventImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight/2, 100, 100)];
    [[self view] addSubview:image];
}

#pragma mark - UIViewController 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIViewController touches began...");
    [self showInfo:@"UIViewController touches began..."];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.view];
    CGPoint previous = [touch previousLocationInView:self.view];
    CGPoint center = image.center;
    CGPoint offset = CGPointMake(current.x-previous.x, current.y-previous.y);
    image.center = CGPointMake(center.x+offset.x, center.y+offset.y);
    NSLog(@"UIViewController moving...");
    [self showInfo:@"UIViewController moving..."];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIViewController touch end...");
    [self showInfo:@"UIViewController touch end..."];
}

- (void)showInfo:(NSString *)info {
    image.uiViewTouch.backgroundColor = WHITE_COLOR;
    image.uiViewTouch.text = @"Waiting for touching...";
    image.uiCtrlTouch.backgroundColor = ORANGE_COLOR;
    image.uiCtrlTouch.text = info;
}

@end
