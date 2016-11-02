//
//  UTSliderController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/2.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTSliderController.h"
#import "FitConsts.h"

@interface UTSliderController ()

@end

@implementation UTSliderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"UISlider Test";
    //设置高度会被忽略，但不能设置太小，点不到了
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 50, kScreenWidth-40, 100)];
    slider.backgroundColor = BG_GRAY_COLOR;
    //设定范围,默认值
    slider.minimumValue = 0.0;
    slider.maximumValue = 100.0;
    slider.value = 50.0;
    //设置两边图标
    [slider setMinimumValueImage:[UIImage imageNamed:@"audio32"]];
    [slider setMaximumValueImage:[UIImage imageNamed:@"audio16"]];
    //设置track颜色，mini默认为蓝色，maxi默认为灰色
    slider.minimumTrackTintColor = RED_COLOR;
    slider.maximumTrackTintColor = BLUE_COLOR;
    //设置按钮颜色,默认为白色
    slider.thumbTintColor = ORANGE_COLOR;
    [self.view addSubview:slider];
    
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    //接收值得label
    UILabel *receiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, kScreenWidth-100, 40)];
    receiveLabel.backgroundColor = BG_GRAY_COLOR;
    receiveLabel.tag = 201;
    receiveLabel.text = [NSString stringWithFormat:@"value of slider is %f", slider.value];
    [self.view addSubview:receiveLabel];
}

- (void)sliderAction:(UISlider *)s {
    NSLog(@"-------------%f", s.value);
    UILabel *rLabel = (UILabel *)[self.view viewWithTag:201];
    rLabel.text = [NSString stringWithFormat:@"value of slider is %f", s.value];
}





@end
