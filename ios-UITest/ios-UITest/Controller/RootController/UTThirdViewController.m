//
//  UTThirdViewController.m
//  ios-UITest
//
//  Created by yangl on 2017/4/20.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "UTThirdViewController.h"
#import "FitConsts.h"
#import "CameraViewController.h"
#import "PlayStringViewController.h"
#import "ConcurrentViewController.h"
#import "MantleDemoViewController.h"
#import "RacTestViewController.h"
#import "TableViewOptController.h"
#import "CTMainController.h"
#import "RunloopMainController.h"

@interface UTThirdViewController() <UITableViewDelegate, UITableViewDataSource> {
	UITableView *table;
	NSArray *cellTitle;
}

@end

@implementation UTThirdViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initLayout];
	// Do any additional setup after loading the view.
}

- (void)initLayout {
	self.view.backgroundColor = ORANGE_COLOR;
	table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNaviHeight-kStatuBarHeight) style:UITableViewStyleGrouped];
	table.delegate = self;
	table.dataSource = self;
	[self.view addSubview:table];
	NSString *one = @"Camera And Photo";
	NSString *two = @"Play String";
	NSString *three = @"Concurrent";
	NSString *four = @"MantleDemo";
	NSString *five = @"RAC-DEMO";
	NSString *six = @"TabeView-Opt";
	NSString *seven = @"CTMainController";
	NSString *eight = @"Design";
	NSString *nine = @"Runloop";
	NSString *ten = @"Test";
	NSString *aa = @"Test";
	NSString *bb = @"Test";
	NSString *cc = @"Test";
	NSString *dd = @"Test";
	NSString *ee = @"Test";
	NSString *ff = @"Test";
	NSString *gg = @"Test";
	
	// NSString *t = @"Test";
	cellTitle = @[one, two, three, four, five, six, seven, eight, nine, ten, aa, bb,cc,dd,ee,ff,gg];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return cellTitle.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
	headView.backgroundColor = ORANGE_COLOR;
	return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
	footView.backgroundColor = RED_COLOR;
	return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.textLabel.text = [cellTitle objectAtIndex:indexPath.row];
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section==0 && indexPath.row==0) {
		CameraViewController *cameraVC = [[CameraViewController alloc] init];
		[self.navigationController pushViewController:cameraVC animated:YES];
	}
	
	if (indexPath.section==0 && indexPath.row==1) {
		PlayStringViewController *playStrVC = [[PlayStringViewController alloc] init];
		[self.navigationController pushViewController:playStrVC animated:YES];
	}
	
	if (indexPath.section==0 && indexPath.row==2) {
		ConcurrentViewController *concurrentVC = [[ConcurrentViewController alloc] init];
		[self.navigationController pushViewController:concurrentVC animated:YES];
	}

	if (indexPath.section==0 && indexPath.row==3) {
		MantleDemoViewController *mantleCtrl = [[MantleDemoViewController alloc] init];
		[self.navigationController pushViewController:mantleCtrl animated:YES];
	}

    if (indexPath.section==0 && indexPath.row==4) {
        RacTestViewController *racVC = [[RacTestViewController alloc] init];
        [self.navigationController pushViewController:racVC animated:YES];
    }

    if (indexPath.section==0 && indexPath.row==5) {
        TableViewOptController *vc = [[TableViewOptController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (indexPath.section==0 && indexPath.row==6) {
        CTMainController *vc = [[CTMainController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (indexPath.section==0 && indexPath.row==7) {
        RunloopMainController *vc = [[RunloopMainController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
//
//	if (indexPath.section==0 && indexPath.row==8) {
//		CITestViewController *CITestCtrl = [[CITestViewController alloc] init];
//		CITestCtrl.navigationItem.title = @"Core Image Test";
//		CITestCtrl.view.backgroundColor = WHITE_COLOR;
//		[self.navigationController pushViewController:CITestCtrl animated:YES];
//	}
//	
//	if (indexPath.section==0 && indexPath.row==9) {
//		AnimationViewController *animationVC = [[AnimationViewController alloc] init];
//		animationVC.navigationItem.title = @"Animation Test";
//		animationVC.view.backgroundColor = WHITE_COLOR;
//		[self.navigationController pushViewController:animationVC animated:YES];
//	}
//	
//	if (indexPath.section==0 && indexPath.row==10) {
//		UTSearchController *searchVC = [[UTSearchController alloc] init];
//		searchVC.navigationItem.title = @"SearchController Test";
//		searchVC.view.backgroundColor = WHITE_COLOR;
//		[self.navigationController pushViewController:searchVC animated:YES];
//	}
//	
//	if (indexPath.section==0 && indexPath.row==11) {
//		UTAVController *avVC = [[UTAVController alloc] init];
//		avVC.navigationItem.title = @"AVFoundation Test";
//		avVC.view.backgroundColor = WHITE_COLOR;
//		[self.navigationController pushViewController:avVC animated:YES];
	}

@end
