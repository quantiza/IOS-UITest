//
//  UTGestureView.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/29.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTGestureView.h"
#import "FitConsts.h"

@implementation UTGestureView {
    int _currentIndex;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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
    _imageView.userInteractionEnabled = YES;
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
    NSString *title = [NSString stringWithFormat:@"%i.jpg", _currentIndex];
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
//    if (gesture.state==UIGestureRecognizerStateChanged) {
//        _imageView.transform =
//    }
}









@end











