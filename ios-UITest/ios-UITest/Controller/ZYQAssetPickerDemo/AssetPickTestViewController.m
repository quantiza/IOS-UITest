//
//  AssetPickTestViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/17.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "AssetPickTestViewController.h"
#import <ZYQAssetPickerController.h>
#import "FitConsts.h"

@interface AssetPickTestViewController ()<ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate>{
	UIButton *btn;
	
	UIScrollView *src;
	
	UIPageControl *pageControl;
}

@end

@implementation AssetPickTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"AssetPick Test";
	self.view.backgroundColor = [UIColor whiteColor];
	
	btn=[[UIButton alloc] init];
	btn.frame=CGRectMake(60., 100, self.view.frame.size.width-120, 60);
	[btn setTitle:@"Open" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:btn];
	[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	
}

- (void)btnClick:(id)sender {
	
	ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
	picker.maximumNumberOfSelection = 9;
	picker.assetsFilter = ZYQAssetsFilterAllAssets;
	picker.showEmptyGroups=NO;
	picker.delegate=self;
	[self presentViewController:picker animated:YES completion:NULL];

}


#pragma mark - ZYQAssetPickerController Delegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
	NSLog(@">>>>>>>>>>>>>assets:%@", assets);
	
	UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, kScreenWidth)];
	imgview.contentMode=UIViewContentModeScaleAspectFill;
	imgview.clipsToBounds=YES;
	[self.view addSubview:imgview];
	
	[assets[0] setGetFullScreenImage:^(UIImage *result) {
		imgview.image = result;
	}];
}




@end
