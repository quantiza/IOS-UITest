//
//  AnimationViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/12/6.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "AnimationViewController.h"
#import "FitConsts.h"
#import "VWWWaterView.h"
#import <UICountingLabel.h>

#define WIDTH 50

@interface AnimationViewController () {

	CALayer *layer;
	CALayer *layer2;
}

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initUI];
}

- (void)initUI {
	
	UICountingLabel *myLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
	myLabel.backgroundColor = RED_COLOR;
	myLabel.format = @"%d";
	myLabel.method = UILabelCountingMethodLinear;
	[myLabel countFrom:0 to:100 withDuration:3.0];
	[self.view addSubview:myLabel];
	
	
	
	UIButton *simpleBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 150, 20)];
	[simpleBtn setTitle:@"Simple Animation" forState:UIControlStateNormal];
	[simpleBtn setBackgroundColor:ORANGE_COLOR];
	[simpleBtn addTarget:self action:@selector(gotoSimple) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:simpleBtn];
	
	UIButton *uiViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 150, 20)];
	[uiViewBtn setTitle:@"UIView Animation" forState:UIControlStateNormal];
	[uiViewBtn setBackgroundColor:ORANGE_COLOR];
	[uiViewBtn addTarget:self action:@selector(gotoUIView) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:uiViewBtn];
	
	UIButton *basicBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 150, 20)];
	[basicBtn setTitle:@"Basic Animation" forState:UIControlStateNormal];
	[basicBtn setBackgroundColor:ORANGE_COLOR];
	[basicBtn addTarget:self action:@selector(gotoBasic) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:basicBtn];
	
	VWWWaterView *waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
	waterView.backgroundColor = ORANGE_COLOR;
	[self.view addSubview:waterView];
	
	
	
}


- (void)gotoSimple {

	layer = [[CALayer alloc] init];
	layer.backgroundColor = BLUE_COLOR.CGColor;
	layer.position = CGPointMake(kScreenWidth/2, kNormalHeight/2);
	layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
	layer.cornerRadius = WIDTH/2;
	
	layer.shadowColor = COLOR_GRAY_DARK.CGColor;
	layer.shadowOffset = CGSizeMake(2, 2);
	layer.shadowOpacity = 0.9;
	
	[self.view.layer addSublayer:layer];
}

- (void)gotoUIView {

	UIImage *image = [UIImage imageNamed:@"flower"];
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 140, 150, 150)];
	imageView.image = image;
	[self.view addSubview:imageView];
	
	[UIView animateWithDuration:3
						  delay:1
						options:UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 imageView.frame = CGRectMake(120, 600, 300, 300);
					 }
					 completion:nil];
}

- (void)gotoBasic {

	layer2 = [[CALayer alloc] init];
	layer2.bounds = CGRectMake(0, 0, 20, 20);
	layer2.position = CGPointMake(50, 150);
	layer2.contents = (id)[UIImage imageNamed:@"dele"].CGImage;
	[self.view.layer addSublayer:layer2];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

	UITouch *touch = [touches anyObject];
//	CALayer *layer = self.view.layer.sublayers[2];
	CGFloat width = layer.bounds.size.width;
	if (width == WIDTH) {
		width = WIDTH * 4;
	} else {
		width = WIDTH;
	}
	
	layer.bounds = CGRectMake(0, 0, width, width);
	layer.position = [touch locationInView:self.view];
	layer.cornerRadius = width/2;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

	UITouch *touch = touches.anyObject;
	CGPoint location = [touch locationInView:self.view];
	
	CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
	basicAnimation.toValue = [NSValue valueWithCGPoint:location];
	basicAnimation.duration = 5.0;
	[layer2 addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}


@end






















