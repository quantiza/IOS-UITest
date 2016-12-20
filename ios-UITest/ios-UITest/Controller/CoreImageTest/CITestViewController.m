//
//  CITestViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/28.
//  Copyright © 2016年 yl. All rights reserved.
//

///*Core Image 架构Core Image 有一个插件架构，这意味着它允许用户编写自定义的滤镜并与系统提供的滤镜集成来扩展其功能。我们在这篇文章中不会用到 Core Image 的可扩展性；我提到它只是因为它影响到了框架的 API。

///Core Image 是用来最大化利用其所运行之上的硬件的。每个滤镜实际上的实现，即内核，是由一个 GLSL (即 OpenGL 的着色语言) 的子集来书写的。当多个滤镜连接成一个滤镜图表，Core Image 便把内核串在一起来构建一个可在 GPU 上运行的高效程序。

///只要有可能，Core Image 都会把工作延迟。通常情况下，直到滤镜图表的最后一个滤镜的输出被请求之前都不会发生分配或处理。

///为了完成工作，Core Image 需要一个称为上下文 (context) 的对象。这个上下文是框架真正工作的地方，它需要分配必要的内存，并编译和运行滤镜内核来执行图像处理。建立一个上下文是非常昂贵的，所以你会经常想创建一个反复使用的上下文。接下来我们将看到如何创建一个上下文。

#import "CITestViewController.h"
#import "FitConsts.h"

@interface CITestViewController ()

@end

@implementation CITestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self createUI];
}


- (void)createUI {
	//创建CIImage
	NSData *imgData = UIImageJPEGRepresentation([UIImage imageNamed:@"flower"], 1);
	CIImage *image00 = [CIImage imageWithData:imgData];
	//创建滤镜
	CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
	[filter setValue:image00 forKey:@"inputImage"];
	[filter setValue:@0.8 forKey:@"inputIntensity"];
	//CIContext渲染image
	CIContext *context = [CIContext contextWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kCIContextUseSoftwareRenderer]];	//cpu渲染
	
	CIImage *image01 = [filter outputImage];
	// Render the CIImage into a CGImageRef
	CGImageRef cgimg = [context createCGImage:image01 fromRect:[image01 extent]];
	// Create a UIImage from the CGImageRef
	UIImage *uiImage = [UIImage imageWithCGImage:cgimg];
	
	//显示照片
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
	imageView.image = uiImage;
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:imageView];
	
	
	
}

@end
