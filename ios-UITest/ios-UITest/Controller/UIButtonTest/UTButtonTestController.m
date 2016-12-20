//
//  UTButtonTestController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTButtonTestController.h"
#import "FitConsts.h"

#define kUrl @"https://api.megvii.com/facepp/v3/detect"
#define kBOUNDARY_STRING @"KenshinCui"

@interface UTButtonTestController ()

@end

@implementation UTButtonTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"UIButton Test";
	
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //UIButton *btn = [[UIButton alloc] init];  //这种按钮初始化默认标题文字为白色
    btn.frame = CGRectMake(50, 50, kScreenWidth-100, 40);
    btn.backgroundColor = BG_GRAY_COLOR;
//    [btn setTitle:@"UIButtonTypeRoundedRect" forState:UIControlStateNormal];
    [btn setTitle:@"ZoomIn" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(zoomInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.titleLabel.textColor = RED_COLOR;
    [btn1 setTitle:@"Yes" forState:UIControlStateNormal];
    [btn1 setTitleShadowColor:RED_COLOR forState:UIControlStateNormal];
    btn1.frame = CGRectMake(100, 100, kScreenWidth-200, 40);
    btn1.backgroundColor = BG_GRAY_COLOR;
    [btn1 addTarget:self action:@selector(zoomInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
    testLabel.backgroundColor = RED_COLOR;
    [self.view addSubview:testLabel];
    [testLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
}
- (void)labelClick:(UITapGestureRecognizer *)tapGest {
    tapGest.view.backgroundColor = BLACK_COLOR;
}

- (void)zoomInAction:(id)sender {
	
	NSLog(@"-----%@", [self ret32bitString]);
	NSLog(@"-----%@", [self num10String]);
	
}



- (NSString *)ret32bitString

{
	char data[32];
	
	for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
	
	return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

- (NSString *)num10String {

	int num = (arc4random() % 10000000000);
	NSString *randomNumber = [NSString stringWithFormat:@"%.10d", num];
	return randomNumber;
}

#pragma mark 取得请求链接
- (NSURL *)getUploadUrl:(NSString *)fileName{
	
	NSString *api_key = @"4r5CgwC8Y9U-ZESTVqCQagMvhMo8TXD_";
	NSString *api_secret = @"L2hf0M_-VaW-UFkqWxYSGonHgOkKYYAq";
	NSString *urlStr=[NSString stringWithFormat:@"%@?api_key=%@&api_secret=%@",kUrl,api_key,api_secret];
	urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url=[NSURL URLWithString:urlStr];
	return url;
}

#pragma mark 取得mime types
-(NSString *)getMIMETypes:(NSString *)fileName{
	return @"image/jpg";
}

#pragma mark 取得数据体
-(NSData *)getHttpBody:(NSString *)fileName{
	NSMutableData *dataM=[NSMutableData data];
	NSString *strTop=[NSString stringWithFormat:@"--%@\nContent-Disposition: form-data; name=\"file_name\"; filename=\"%@\"\nContent-Type: %@\n\n",kBOUNDARY_STRING,fileName,[self getMIMETypes:fileName]];
	NSString *strBottom=[NSString stringWithFormat:@"\n--%@--",kBOUNDARY_STRING];
	NSString *filePath=[[NSBundle mainBundle] pathForResource:fileName ofType:nil];
	NSData *fileData=[NSData dataWithContentsOfFile:filePath];
	[dataM appendData:[strTop dataUsingEncoding:NSUTF8StringEncoding]];
	[dataM appendData:fileData];
	[dataM appendData:[strBottom dataUsingEncoding:NSUTF8StringEncoding]];
	return dataM;
}



-(void)uploadFile{
	NSString *api_key = @"4r5CgwC8Y9U-ZESTVqCQagMvhMo8TXD_";
	NSString *api_secret = @"L2hf0M_-VaW-UFkqWxYSGonHgOkKYYAq";
	NSString *urlStr=[NSString stringWithFormat:@"%@?api_key=%@&api_secret=%@",kUrl,api_key,api_secret];
	urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:kUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0f];
	
	request.HTTPMethod=@"POST";
	
	NSData *fileData = UIImageJPEGRepresentation([UIImage imageNamed:@"andy"], 1);
	NSDictionary *dic = @{@"image_file":fileData};
	
	NSMutableData *data = [NSMutableData data];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:dic forKey:@"testData"];
	[archiver finishEncoding];
	
	
//	NSData *data=[self getHttpBody:fileName];
	
	//通过请求头设置
//	[request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
//	[request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBOUNDARY_STRING] forHTTPHeaderField:@"Content-Type"];
	
	//设置数据体
	request.HTTPBody=data;
	
	
	//发送请求
	[NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
		if(connectionError){
			NSLog(@"error:%@",connectionError.localizedDescription);
		}
		
		NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
		NSLog(@"jsonStr:%@",jsonStr);
	}];
}












@end
