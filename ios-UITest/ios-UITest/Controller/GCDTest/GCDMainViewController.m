//
//  GCDMainViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/23.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "GCDMainViewController.h"

//#import "KCImageData.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface GCDMainViewController (){
	NSMutableArray *_imageViews;
	NSMutableArray *_imageNames;
}

@end

@implementation GCDMainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self layoutUI];
}

#pragma mark 界面布局
-(void)layoutUI{
	//创建多个图片控件用于显示图片
	_imageViews=[NSMutableArray array];
	for (int r=0; r<ROW_COUNT; r++) {
		for (int c=0; c<COLUMN_COUNT; c++) {
			UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
			imageView.contentMode=UIViewContentModeScaleAspectFit;
			//            imageView.backgroundColor=[UIColor redColor];
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
	
	//创建图片链接
	_imageNames=[NSMutableArray array];
	_imageNames=[[NSMutableArray alloc] initWithObjects:@"http://ent.chinadaily.com.cn/img/attachement/png/site1/20161105/0024e83edef41987914f2a.png", @"http://fwimage.cnfanews.com/websiteimg/2016/20161117/20033840/cqgnolgtiwqasrbkaaaaaaaaaaa543.630x419.jpg", @"http://www.cnwomen.com.cn/fashion/img/site2/20161122/04d80f466d215ffacb828cab3031d6bd.jpg", @"http://img.71lady.com/uploads/allimg/1611/41_161102171354_1.jpg", @"http://img3.imgtn.bdimg.com/it/u=3748815242,1444363451&fm=11&gp=0.jpg", @"http://p.ishowx.com/uploads/allimg/161122/648-161122140425.jpg", @"http://fun.youth.cn/yl24xs/201611/W020161105548769508145.JPEG", @"http://f2.01ny.cn/2016/1116/20161116034325891.jpg", @"http://pic7.nipic.com/20100612/4157251_151150004903_2.jpg", @"http://a3.att.hudong.com/78/90/300000764046131838906869563_950.jpg", @"http://img3.duitang.com/uploads/item/201412/05/20141205022852_55JmC.jpeg", @"http://img.2258.com/d/file/yule/mingxing/gangtai/2016-01-10/475127c4932f3a3e13de9bf5cc0ac16c.jpg", nil];
//	for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
//		[_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
//	}
	
}

#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(int )index{
	UIImage *image=[UIImage imageWithData:data];
	UIImageView *imageView= _imageViews[index];
	imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
	NSURL *url=[NSURL URLWithString:_imageNames[index]];
	NSData *data=[NSData dataWithContentsOfURL:url];
	
	return data;
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
	
	//如果在串行队列中会发现当前线程打印变化完全一样，因为他们在一个线程中
	NSLog(@"thread is :%@",[NSThread currentThread]);
	
	int i=[index intValue];
	//请求数据
	NSData *data= [self requestData:i];
	//更新UI界面,此处调用了GCD主线程队列的方法
	dispatch_queue_t mainQueue= dispatch_get_main_queue();
	dispatch_sync(mainQueue, ^{
		[self updateImageWithData:data andIndex:i];
	});
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
	int count=ROW_COUNT*COLUMN_COUNT;
	
	/*创建一个串行队列
	 第一个参数：队列名称
	 第二个参数：队列类型
	 */
	dispatch_queue_t serialQueue=dispatch_queue_create("myThreadQueue1", DISPATCH_QUEUE_SERIAL);//注意queue对象不是指针类型
	//创建多个线程用于填充图片
	for (int i=0; i<count; ++i) {
		//异步执行队列任务
		dispatch_async(serialQueue, ^{
			[self loadImage:[NSNumber numberWithInt:i]];
		});
		
	}
	//非ARC环境请释放
//	   dispatch_release(seriQueue);
}

@end
