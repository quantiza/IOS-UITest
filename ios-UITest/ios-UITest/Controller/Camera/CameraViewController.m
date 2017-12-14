//
//  CameraViewController.m
//  ios-UITest
//
//  Created by yangl on 2017/4/20.
//  Copyright © 2017年 yl. All rights reserved.
//

/***
1. AVCaptureDevice 是关于相机硬件的接口。它被用于控制硬件特性，诸如镜头的位置、曝光、闪光灯等。
2. AVCaptureDeviceInput 提供来自设备的数据。
3. AVCaptureOutput 是一个抽象类，描述 capture session 的结果。以下是三种关于静态图片捕捉的具体子类：
	3.1 AVCaptureStillImageOutput 用于捕捉静态图片
	3.2 AVCaptureMetadataOutput 启用检测人脸和二维码
	3.3 AVCaptureVideoOutput 为实时预览图提供原始帧
4. AVCaptureSession 管理输入与输出之间的数据流，以及在出现问题时生成运行时错误。
5. AVCaptureVideoPreviewLayer 是 CALayer 的子类，可被用于自动显示相机产生的实时图像。它还有几个工具性质的方法，可将 layer 上的坐标转化到设备上。它看起来像输出，但其实不是。另外，它拥有 session (outputs 被 session 所拥有)。
 */


#import "CameraViewController.h"
#import "FitConsts.h"

#import <AVFoundation/AVFoundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <GLKit/GLKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraViewController ()
<
AVCaptureVideoDataOutputSampleBufferDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>
{
	AVCaptureSession *session;
	EAGLContext *glContext;
	GLKView *glView;
	CIContext *ciContext;
}

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//	[self createUI];
	[self createUI99];
}

- (void)createUI99
{
	self.title = @"Camera And Photo";
	self.view.backgroundColor = WHITE_COLOR;
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		UIImagePickerController *imagePickerVC = [UIImagePickerController new];
		imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
		imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
		imagePickerVC.delegate = self;
		imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
		
		[self presentViewController:imagePickerVC animated:YES completion:nil];
	}
}


- (void)createUI
{
	self.title = @"Camera And Photo";
	self.view.backgroundColor = WHITE_COLOR;
	
	session = [[AVCaptureSession alloc] init];

	[self authorizationCamera];
	
	glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	glView = [[GLKView alloc] initWithFrame:self.view.frame context:glContext];
	ciContext = [CIContext contextWithEAGLContext:glContext];
	
	AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
	
	[videoOutput setSampleBufferDelegate:self queue:dispatch_queue_create("sample buffer delegate", DISPATCH_QUEUE_SERIAL)];
	if ([session canAddOutput:videoOutput]) {
		[session addOutput:videoOutput];
	}
}


#pragma mark - 授权使用相机
- (void)authorizationCamera
{
	AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
	if (authorizationStatus == AVAuthorizationStatusNotDetermined) {
		[AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
			NSLog(@"=====AVAuthorizationStatusNotDetermined");
		}];
	}
	if (authorizationStatus == AVAuthorizationStatusAuthorized) {
		NSLog(@"=====AVAuthorizationStatusAuthorized");
		[self startCamera];
		
	}
	if (authorizationStatus == AVAuthorizationStatusDenied) {
		NSLog(@"=====AVAuthorizationStatusDenied");
	}
}

#pragma mark - 启动相机
- (void)startCamera
{
	[session setSessionPreset:AVCaptureSessionPresetHigh];
	
	NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
	AVCaptureDevice *backCamera;
	AVCaptureDevice *frontCamera;
	
	for (AVCaptureDevice *device in devices) {
		if (device.position == AVCaptureDevicePositionBack) {
			backCamera = device;
		}
		if (device.position == AVCaptureDevicePositionFront) {
			frontCamera = device;
		}
	}
	
	NSError *error;
	AVCaptureDeviceInput *captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:frontCamera error:&error];
	if ([session canAddInput:captureDeviceInput]) {
		[session addInput:captureDeviceInput];
	}
	
	AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];

	previewLayer.frame = self.view.bounds;
	[self.view.layer addSublayer:previewLayer];
	[session startRunning];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
	CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	CIImage *image = [CIImage imageWithCVPixelBuffer:pixelBuffer];
	if (glContext != EAGLContext.currentContext) {
		EAGLContext.currentContext = glContext;
	}
	[glView bindDrawable];
	[ciContext drawImage:image inRect:image.extent fromRect:image.extent];
	[glView display];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:nil];
}

@end
