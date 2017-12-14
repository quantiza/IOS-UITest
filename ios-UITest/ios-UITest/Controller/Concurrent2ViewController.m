//
//  Concurrent2ViewController.m
//  ios-UITest
//
//  Created by yangl on 2017/4/25.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "Concurrent2ViewController.h"
#import "FitConsts.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface Concurrent2ViewController ()
{
	NSMutableArray *_imageViews;
	NSMutableArray *_imageNames;
}
@end

@implementation Concurrent2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI
{
	//创建多个图片控件用于显示图片
	_imageViews=[NSMutableArray array];
	for (int r=0; r<ROW_COUNT; r++) {
		for (int c=0; c<COLUMN_COUNT; c++) {
			UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25 + c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
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
-(void)loadImageWithMultiThread{
	//创建操作队列
	NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
	operationQueue.maxConcurrentOperationCount = 5; //设置最大并发线程数量
	//创建多个线程用于填充图片
	for (int i = 0; i < ROW_COUNT * COLUMN_COUNT; i++) {
		//方法1：直接使用操作队列添加操作
		[operationQueue addOperationWithBlock:^{
			[self loadImage:[NSNumber numberWithInt:i]];
		}];
	}
}

- (void)loadImage:(NSNumber *)index
{
	NSData *data;
	@autoreleasepool {
		data = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageUrl]];
	}
	NSLog(@"%@", [NSThread currentThread]);
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		UIImageView *imageView = _imageViews[index.integerValue];
		imageView.image = [UIImage imageWithData:data];
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
