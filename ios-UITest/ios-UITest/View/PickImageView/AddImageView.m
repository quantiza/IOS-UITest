//
//  AddImageView.m
//  ios-UITest
//
//  Created by yangl on 2016/11/16.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "AddImageView.h"

#define imageH 50	//image height
#define imageW 50	//image width
#define kMaxColumn 3	//每行显示数量
#define MaxImageCount 9	//最多显示图片数量
#define deleImageWH 25	//删除按钮的宽高
#define kDeleImage @"dele"//删除按钮图片
#define kAddImage	@"add"//添加按钮图片

@interface AddImageView()<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	// 标识被编辑的按钮 -1 为添加新的按钮
     NSInteger editTag;
}
@end

@implementation AddImageView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		UIButton *btn = [self createButtonWithImage:kAddImage andSelector:@selector(addNew:)];
		[self addSubview:btn];
	}
	return self;
}

- (NSMutableArray *)images {
	if (_images == nil) {
		_images = [NSMutableArray array];
	}
	return _images;
}

//添加新控件
- (void)addNew:(UIButton *)btn {
	if (![self deleClose:btn]) {
		editTag = -1;
		[self callImagePicker];
	}
}



// 根据图片名称或者图片创建一个新的显示控件
- (UIButton *)createButtonWithImage:(id)imageNameOrImage andSelector:(SEL)selector {
	UIImage *addImage = nil;
	
	if ([imageNameOrImage isKindOfClass:[NSString class]]) {
		addImage = [UIImage imageNamed:imageNameOrImage];
	} else if ([imageNameOrImage isKindOfClass:[UIImage class]]) {
		addImage = imageNameOrImage;
	}
	
	UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[addBtn setImage:addImage forState:UIControlStateNormal];
	[addBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
	addBtn.tag = self.subviews.count;
	
	//添加长按手势，删除
	if (addBtn.tag != 0) {
		UILongPressGestureRecognizer *gester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
		[addBtn addGestureRecognizer:gester];
	}
	
	return addBtn;
}

//长按删除手势函数
- (void)longPress:(UIGestureRecognizer *)gester {
	if (gester.state == UIGestureRecognizerStateBegan) {
		UIButton *btn = (UIButton *)gester.view;
		UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
		dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
		[dele setImage:[UIImage imageNamed:kDeleImage] forState:UIControlStateNormal];
		[dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
		dele.frame = CGRectMake(btn.frame.size.width - dele.frame.size.width, 0, dele.frame.size.width, dele.frame.size.height);
		[btn addSubview:dele];
		[self start:btn];
	}
}

//删除图片
- (void)deletePic:(UIButton *)btn {
	[self.images removeObject:[(UIButton *)btn.superview imageForState:UIControlStateNormal]];
	[btn.superview removeFromSuperview];
	if ([[self.subviews lastObject] isHidden]) {
		[[self.subviews lastObject] setHidden:NO];
	}
}

//长按开始抖动
- (void)start:(UIButton *)btn {
	double angle1 = -3 / 180 * M_PI;
	double angle2 = 3.0 / 180 * M_PI;
	CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
	anim.keyPath = @"transform.rotation";
	
	anim.values = @[@(angle1), @(angle2), @(angle1)];
	anim.duration = 0.15;
	anim.repeatCount = MAXFLOAT;
	
	anim.removedOnCompletion = NO;
	anim.fillMode = kCAFillModeForwards;
	
	[btn.layer addAnimation:anim forKey:@"shake"];
}

//停止抖动
- (void)stop:(UIButton *)btn {
	[btn.layer removeAnimationForKey:@"shake"];
}



//对所有子控件布局
- (void)layoutSubviews {
	[super layoutSubviews];
	int count = self.subviews.count;
	CGFloat btnW = imageW;
	CGFloat btnH = imageH;
	int maxColumn = kMaxColumn > self.frame.size.width / imageW ? self.frame.size.width / imageW : kMaxColumn;
	CGFloat marginX = 5;//(self.frame.size.width - maxColumn * btnW) / (count + 1);
	CGFloat marginY = marginX;
	
	for (int i = 0; i < count; i++) {
		UIButton *btn = self.subviews[i];
		CGFloat btnX = (i % maxColumn) * (marginX + btnW) + marginX;
		CGFloat btnY = (i / maxColumn) * (marginY + btnH) + marginY;
		btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
	}
	
}

#pragma mark - UIImagePickerController 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
	UIImage *image = info[UIImagePickerControllerEditedImage];
	if (editTag == -1) {
		//创建一个新控件
		UIButton *btn = [self createButtonWithImage:image andSelector:@selector(changeOld:)];
		[self insertSubview:btn atIndex:self.subviews.count - 1];
		[self.images addObject:image];
		
		if (self.subviews.count - 1 == MaxImageCount) {
			[[self.subviews lastObject] setHidden:YES];
		}
	} else {
		//根据tag修改需要编辑的控件
		UIButton *btn = (UIButton *)[self viewWithTag:editTag];
		int index = [self.images indexOfObject:[btn imageForState:UIControlStateNormal]];
		[self.images removeObjectAtIndex:index];
		[btn setImage:image forState:UIControlStateNormal];
		[self.images insertObject:image atIndex:index];
	}
	
	[picker dismissViewControllerAnimated:YES completion:nil];
}

//修改旧控件
- (void)changeOld:(UIButton *)btn {
	if (![self deleClose:btn]) {
		editTag = btn.tag;
		[self callImagePicker];
	}
}

//删除“删除按钮”
- (BOOL)deleClose:(UIButton *)btn {
	if (btn.subviews.count == 2) {
		[[btn.subviews lastObject] removeFromSuperview];
		[self stop:btn];
		return YES;
	}
	return NO;
}

// 调用图片选择器
- (void)callImagePicker {
	UIImagePickerController *pc = [[UIImagePickerController alloc] init];
	pc.allowsEditing = YES;
	pc.delegate = self;
	[self.window.rootViewController presentViewController:pc animated:YES completion:nil];
}


@end
