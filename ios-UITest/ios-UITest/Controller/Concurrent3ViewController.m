//
//  Concurrent3ViewController.m
//  ios-UITest
//
//  Created by yangl on 2017/4/25.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "Concurrent3ViewController.h"
#import "FitConsts.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface Concurrent3ViewController ()
{
	NSMutableArray *_imageViews;
}
@end

@implementation Concurrent3ViewController

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
			UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(25+c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
			imageView.contentMode=UIViewContentModeScaleAspectFit;
			imageView.backgroundColor=[UIColor grayColor];
			[self.view addSubview:imageView];
			[_imageViews addObject:imageView];
			
		}
	}
	
	UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame=CGRectMake(50, 520, 150, 25);
	[button setTitle:@"串行队列加载图片" forState:UIControlStateNormal];
	//添加方法
	[button addTarget:self action:@selector(loadImageWithMultiThread1) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
	UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	button2.frame=CGRectMake(200, 520, 150, 25);
	[button2 setTitle:@"并发队列加载图片" forState:UIControlStateNormal];
	//添加方法
	[button2 addTarget:self action:@selector(loadImageWithMultiThread2) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button2];
}

- (void)loadImageWithMultiThread1{
	/*创建一个串行队列
	 第一个参数：队列名称
	 第二个参数：队列类型
	 */
	dispatch_queue_t serialQueue = dispatch_queue_create("myThreadQueue", DISPATCH_QUEUE_SERIAL);
	for (int i = 0; i < ROW_COUNT * COLUMN_COUNT; i++) {
		//异步执行队列任务
		dispatch_async(serialQueue, ^{
			[self loadImage:[NSNumber numberWithInt:i]];
		});
	}
}


- (void)loadImageWithMultiThread2{
	/*取得全局队列
	 第一个参数：线程优先级
	 第二个参数：标记参数，目前没有用，一般传入0
	 */
	dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	for (int i = 0; i < ROW_COUNT*COLUMN_COUNT; i++) {
		dispatch_async(globalQueue, ^{
			[self loadImage:[NSNumber numberWithInt:i]];
		});
	}
}

- (void)loadImage:(NSNumber *)index
{
	NSLog(@"thread is :%@", [NSThread currentThread]);
	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageUrl]];
	//跟新UI界面
	dispatch_sync(dispatch_get_main_queue(), ^{
		UIImageView *imageView = _imageViews[index.intValue];
		imageView.image = [UIImage imageWithData:data];
	});
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
