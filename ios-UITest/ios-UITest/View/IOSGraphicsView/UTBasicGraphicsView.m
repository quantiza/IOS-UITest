//
//  UTBasicGraphicsView.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/31.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTBasicGraphicsView.h"
#import "FitConsts.h"

@implementation UTBasicGraphicsView

#pragma mark 绘图
//在UI控件的drawRect:方法（这个方法在loadView、viewDidLoad方法后执行）中我们可以通过UIKit封装函数
//UIGraphicsGetCurrentContext()方法获得这个图形上下文(注意在其他UI控件方法中无法取得这个对象)，
//然后我们只要按照绘图步,骤一步步执行即可

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawLineWithContext:context];
    [self drawRectWithContext:context];
    [self drawEllipse:context];
    [self drawCurve:context];
    [self drawArc:context];
    [self drawText:context];
	[self drawWithUIKit];
}


#pragma mark 绘制线形
- (void)drawLineWithContext:(CGContextRef)context{
    //2.绘制路径
        CGContextMoveToPoint(context, 20, 50);
        CGContextAddLineToPoint(context, 20, 100);
        CGContextAddLineToPoint(context, 300, 100);
        CGContextAddLineToPoint(context, 20, 50);
    //3.封闭路径,直接调用路径封闭方法
    CGContextCopyPath(context);
    //4.设置图形上下文属性
        [[UIColor redColor] setStroke];     //设置红色边框
        [[UIColor greenColor] setFill];     //设置绿色填充；
    //[[UIColor blueColor] set];        //同时设置填充和边框
    //5.绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark 绘制矩形
-(void)drawRectWithContext:(CGContextRef)context{
    //添加矩形对象
    CGRect rect=CGRectMake(20, 150, 280.0, 50.0);
    CGContextAddRect(context,rect);
    //设置属性
    [[UIColor blueColor]set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark 绘制椭圆
-(void)drawEllipse:(CGContextRef)context{
    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect=CGRectMake(50, 250, 220.0, 100.0);
    CGContextAddEllipseInRect(context, rect);
    //设置属性
    [[UIColor purpleColor]set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}


#pragma mark 绘制贝塞尔曲线
- (void)drawCurve:(CGContextRef)context {
    //绘制曲线
    CGContextMoveToPoint(context, 20, 400);
    /*绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddQuadCurveToPoint(context, 120, 300, 220, 400);
    
    [[UIColor yellowColor] setFill];
    [[UIColor redColor] setStroke];
    
    CGContextDrawPath(context, kCGPathFillStroke);
}


#pragma mark  绘制弧形
- (void)drawArc:(CGContextRef)context {
    CGContextAddArc(context, 100, 500, 50, 0.0, 3.14/2, 0);
    [[UIColor redColor] setStroke];
    [[UIColor clearColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}


- (void)drawText:(CGContextRef)context {
    NSString *str=@"Star Walk is the most beautiful stargazing app you’ve ever seen on a mobile device.";
    CGRect rect = CGRectMake(300, 50, 50, 100);
    UIFont *font = [UIFont systemFontOfSize:18];
    UIColor *color = [UIColor redColor];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:style}];
}



- (void)drawWithUIKit {
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(200, 500)];
	[path addLineToPoint:CGPointMake(250, 500)];
	[path addLineToPoint:CGPointMake(250, 550)];
	[path addLineToPoint:CGPointMake(200, 550)];
	[path closePath];
	path.lineWidth = 1;
	[[UIColor redColor] setStroke];
	[path stroke];
}

@end
