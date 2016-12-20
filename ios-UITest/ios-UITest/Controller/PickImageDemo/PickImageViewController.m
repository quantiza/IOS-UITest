//
//  PickImageViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/16.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "PickImageViewController.h"
#import "AddImageView.h"

@interface PickImageViewController ()

@end

@implementation PickImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"PickImage Demo";
	self.view.backgroundColor = [UIColor orangeColor];
	
	AddImageView *addImageV = [[AddImageView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:addImageV];
	
}



@end
