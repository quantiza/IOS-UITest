//
//  AssetPickerViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/17.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "AssetPickerViewController.h"
#import <ZYQAssetPickerController.h>
#import "AssetPickTestViewController.h"

@interface AssetPickerViewController ()<ZYQAssetPickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate> {
	UIButton *btn;
	
	UIScrollView *src;
	
	UIPageControl *pageControl;
}


@end

@implementation AssetPickerViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//	if (self) {
//		// Custom initialization
//	}
//	return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Asset Picker";
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(gotoNext)];
	
	src=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-200)];
	src.pagingEnabled=YES;
	src.backgroundColor=[UIColor lightGrayColor];
	src.delegate=self;
	[self.view addSubview:src];
	
	btn=[[UIButton alloc] init];
	btn.frame=CGRectMake(60., self.view.frame.size.height-200, self.view.frame.size.width-120, 60);
	[btn setTitle:@"Open" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:btn];
	[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	
	pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(src.frame.origin.x, src.frame.origin.y+src.frame.size.height-20, src.frame.size.width, 20)];
	[self.view addSubview:pageControl];
    // Do any additional setup after loading the view.
}

-(void)btnClick:(id)sender {
	
	ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
	picker.maximumNumberOfSelection = 5;
	picker.assetsFilter = ZYQAssetsFilterAllAssets;
	picker.showEmptyGroups = NO;
	picker.delegate = self;
	picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		
		if ([(ZYQAsset *)evaluatedObject mediaType] == ZYQAssetMediaTypeVideo) {
			NSTimeInterval duration = [(ZYQAsset *)evaluatedObject duration];
			return duration >= 5;
		} else {
			return YES;
		}
	}];
	
	[self presentViewController:picker animated:YES completion:nil];
}



#pragma mark - ZYQAssetPickerController Delegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
	[src.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		src.contentSize = CGSizeMake(assets.count*src.frame.size.width, src.frame.size.height);
		dispatch_async(dispatch_get_main_queue(), ^{
			pageControl.numberOfPages = assets.count;
		});
		
		for (int i=0; i<assets.count; i++) {
			ZYQAsset *asset = assets[i];
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*src.frame.size.width, 0, src.frame.size.width, src.frame.size.height)];
			imageView.contentMode = UIViewContentModeScaleAspectFill;
			imageView.clipsToBounds = YES;
			[asset setGetFullScreenImage:^(UIImage *result) {
				dispatch_async(dispatch_get_main_queue(), ^{
					[imageView setImage:result];
					[src addSubview:imageView];
				});
			}];
		}
	});
}

- (void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker {
	NSLog(@"到达上限");
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	pageControl.currentPage = floor(scrollView.contentOffset.x / scrollView.frame.size.width);
}



- (void)gotoNext {
	AssetPickTestViewController *testVC = [[AssetPickTestViewController alloc] init];
	[self.navigationController pushViewController:testVC animated:YES];
}


@end
