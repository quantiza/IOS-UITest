//
//  Concurrent1ViewController.m
//  ios-UITest
//
//  Created by yangl on 2017/4/24.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "Concurrent1ViewController.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface Concurrent1ViewController ()
{
	NSMutableArray *_imageViews;
}

@end

@implementation Concurrent1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI
{
	_imageViews = [NSMutableArray array];
	for (int r=0; r<ROW_COUNT; r++) {
		for (int c=0; c<COLUMN_COUNT; c++) {
			UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25 + c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING), ROW_WIDTH, ROW_HEIGHT)];
			imageView.contentMode = UIViewContentModeScaleAspectFit;
			imageView.backgroundColor = [UIColor grayColor];
			[self.view addSubview:imageView];
			[_imageViews addObject:imageView];
		}
	}
	
	UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame=CGRectMake(50, 500, 220, 25);
	[button setTitle:@"加载图片" forState:UIControlStateNormal];
	//添加方法
	[button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread
{
	//创建多个线程用于填充图片
	for (int i = 0; i < ROW_COUNT*COLUMN_COUNT; i++) {
//		NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
//		thread.name = [NSString stringWithFormat:@"myThread %i", i];
//		thread.threadPriority = (15-i)/15.0;
//		[thread start];

		[self performSelectorInBackground:@selector(loadImage:) withObject:[NSNumber numberWithInt:i]];
		
		//		[self loadImage:[NSNumber numberWithInt:i]];
	}
}

- (void)loadImage:(NSNumber *)index
{
	NSLog(@"current thread:%@",[NSThread currentThread]);
	NSURL *url;
	NSData *data;
	@autoreleasepool {
		url = [NSURL URLWithString:@"http://uploadfile.tukuwa.com/2015/1013/20151013100803231.jpg"];
		data = [NSData dataWithContentsOfURL:url];
	}
	
	UIImageView *imageView = _imageViews[index.intValue];
	imageView.image = [UIImage imageWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
