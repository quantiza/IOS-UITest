//
//  UTBasicGraphicsView.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/31.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTBasicGraphicsView.h"

@implementation UTBasicGraphicsView

#pragma mark 绘图
//在UI控件的drawRect:方法（这个方法在loadView、viewDidLoad方法后执行）中我们可以通过UIKit封装函数
//UIGraphicsGetCurrentContext()方法获得这个图形上下文(注意在其他UI控件方法中无法取得这个对象)，
//然后我们只要按照绘图步,骤一步步执行即可

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 50);
    CGPathAddLineToPoint(path, nil, 20, 100);
    CGPathAddLineToPoint(path, nil, 300, 100);
    
    CGContextAddPath(context, path);
    
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);  //设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);    //设置填充色
    CGContextSetLineWidth(context, 2.0);                //设置线条宽度
    CGContextSetLineCap(context, kCGLineCapRound);      //设置顶点样式
    CGContextSetLineJoin(context, kCGLineJoinRound);    //设置连接点样式
    
    CGFloat lengths[2] = {18, 9};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGColorRef color = [UIColor grayColor].CGColor;
}

@end
