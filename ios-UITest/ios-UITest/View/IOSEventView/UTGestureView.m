//
//  UTGestureView.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/29.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTGestureView.h"
#import "FitConsts.h"

#define kImageCount 3

@implementation UTGestureView {
    int _currentIndex;
    NSArray *array;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        array = @[@"flower", @"girl", @"andy"];
        [self createUI];
        [self addGesture];
    }
    return self;
}

- (void)createUI {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat topPadding = 20;
    CGFloat y = 22 + 44 + topPadding;
    CGFloat height = screenSize.height - y - topPadding;
    //图像初始化
    CGRect imageFrame = CGRectMake(0, y, screenSize.width, height/2);
    _imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    //UIImageView默认支持交互，所以不用设置
    //_imageView.userInteractionEnabled = YES;
    _imageView.image = [UIImage imageNamed:@"flower"];
    [self addSubview:_imageView];

    //显示图像名称的label
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _titleLb.backgroundColor = ORANGE_COLOR;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLb];
    [self showPhotoName];
}

#pragma mark 显示图片名称
- (void)showPhotoName {
    NSString *title = [NSString stringWithFormat:@"%@.jpg", array[_currentIndex]];
    _titleLb.text = title;
}

#pragma mark 添加手势
- (void)addGesture {
    
    //1.点击手势，隐藏titleLb
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    tapGesture.numberOfTapsRequired = 1;    //所需点按次数，默认1
    tapGesture.numberOfTouchesRequired = 1; //所需点按手指数，默认1
    [self addGestureRecognizer:tapGesture];
    
    //2.长按手势，删除图片
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressImage:)];
    longPressGesture.minimumPressDuration = 0.5;    //设置长按时间，默认0.5s
    [self addGestureRecognizer:longPressGesture];
    
    //3.捏合手势，缩放图片
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
    [self addGestureRecognizer:pinchGesture];
    
    //4.旋转手势，旋转图片
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    [self addGestureRecognizer:rotationGesture];
    
    //5.拖动手势，拖动图片
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImage:)];
    [self addGestureRecognizer:panGesture];
    
    //6.轻扫手势，
    UISwipeGestureRecognizer *swipeGestureToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    swipeGestureToRight.direction = UISwipeGestureRecognizerDirectionRight;//默认为向右轻扫
    [self addGestureRecognizer:swipeGestureToRight];
    
    UISwipeGestureRecognizer *swipeGestureToLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    swipeGestureToLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeGestureToLeft];
    
    //解决手势冲突
    [panGesture requireGestureRecognizerToFail:swipeGestureToLeft];
    [panGesture requireGestureRecognizerToFail:swipeGestureToRight];
    [longPressGesture requireGestureRecognizerToFail:panGesture];
}

#pragma mark - 手势操作
#pragma mark 点按隐藏或显示titleLb
- (void)tapImage:(UITapGestureRecognizer *)gesture {
    NSLog(@"tap:%li",(long)gesture.state);
    _titleLb.hidden = !_titleLb.hidden;;
}

#pragma mark 长按提示是否删除
- (void)longPressImage:(UILongPressGestureRecognizer *)gesture {
    NSLog(@"longpress:%li",(long)gesture.state);
    if (gesture.state==UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"System Info" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete the photo" otherButtonTitles:nil, nil];
        [actionSheet showInView:self];
    }
}

#pragma mark 捏合时缩放图片
- (void)pinchImage:(UIPinchGestureRecognizer *)gesture {
    NSLog(@"pinch:%li",(long)gesture.state);
    if (gesture.state==UIGestureRecognizerStateChanged) {
        _imageView.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }
    else if (gesture.state==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark 旋转图片
- (void) rotateImage:(UIRotationGestureRecognizer *)gesture {
    if (gesture.state==UIGestureRecognizerStateChanged) {
        _imageView.transform = CGAffineTransformMakeRotation(gesture.rotation);
    }
    else if (gesture.state==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.8 animations:^{
            _imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark 拖动图片
- (void)panImage:(UIPanGestureRecognizer *)gesture{
    if (gesture.state==UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        _imageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    }
    else if (gesture.state==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark 轻扫查看下一张
- (void)swipeImage:(UISwipeGestureRecognizer *)gesture {
    NSLog(@"swipe:%li", (long)gesture.state);
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight) {
        [self lastImage];
    }
    else if (gesture.direction==UISwipeGestureRecognizerDirectionLeft) {
        [self nextImage];
    }
}


- (void)nextImage {
    //int index = (_currentIndex + kImageCount + 1) % kImageCount;
    int index = (_currentIndex + kImageCount + 1) % kImageCount;
    _imageView.image = [UIImage imageNamed:array[index]];
    _currentIndex = index;
    [self showPhotoName];
}

- (void)lastImage {
    int index = (_currentIndex + kImageCount - 1) % kImageCount;
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", array[index]];
    _imageView.image = [UIImage imageNamed:imageName];
    _currentIndex = index;
    [self showPhotoName];
}







@end










