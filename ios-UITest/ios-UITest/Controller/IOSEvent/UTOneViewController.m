//
//  UTTabOneViewController.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/10/28.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTOneViewController.h"
#import "FitConsts.h"
#import "UTTouchEventViewController.h"
#import "UTGestureViewController.h"
#import "UTBasicGraphicsViewController.h"
#import "UTTableViewController.h"
#import "UTAAViewController.h"
#import "PNChartViewController.h"
#import "PickImageViewController.h"
#import "AssetPickerViewController.h"
#import "JsonModelTestViewController.h"
#import "GCDMainViewController.h"

@interface UTOneViewController () <UITableViewDelegate, UITableViewDataSource>{
    UITableView *table;
    NSArray *cellTitle;
}

@end

@implementation UTOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI {
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNaviHeight-kStatuBarHeight) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    NSString *one = @"Touch Event";
    NSString *two = @"Gesture Recognizer";
    NSString *three = @"Basic Graphics";
    NSString *four = @"TableView";
    NSString *five = @"Pass Value";
    NSString *six = @"PNChart";
    NSString *seven = @"Pick Image Demo";
	NSString *eight = @"Pick Assets Demo";
	NSString *nine = @"JsonModel Test";
	NSString *ten = @"GCDTest";
    cellTitle = @[one, two, three, four, five, six, seven, eight, nine, ten];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
        UTTouchEventViewController *touchVC = [[UTTouchEventViewController alloc] init];
        [self.navigationController pushViewController:touchVC animated:YES];
    }
    if (indexPath.section==0 && indexPath.row==1) {
        UTGestureViewController *gestureVC = [[UTGestureViewController alloc] init];
        [self.navigationController pushViewController:gestureVC animated:YES];
    }
    if (indexPath.section==0 && indexPath.row==2) {
        UTBasicGraphicsViewController *basicGraphVC = [[UTBasicGraphicsViewController alloc] init];
        [self.navigationController pushViewController:basicGraphVC animated:YES];
    }
    if (indexPath.section==0 && indexPath.row==3) {
        UTTableViewController *tableVC = [[UTTableViewController alloc] init];
        [self.navigationController pushViewController:tableVC animated:YES];
    }
    if (indexPath.section==0 && indexPath.row==4) {
        UTAAViewController *aaVC = [[UTAAViewController alloc] init];
        [self.navigationController pushViewController:aaVC animated:YES];
    }
    if (indexPath.section==0 && indexPath.row==5) {
        PNChartViewController *PNChartVC = [[PNChartViewController alloc] init];
        [self.navigationController pushViewController:PNChartVC animated:YES];
    }
	if (indexPath.section==0 && indexPath.row==6) {
		PickImageViewController *pickImageVC = [[PickImageViewController alloc] init];
		[self.navigationController pushViewController:pickImageVC animated:YES];
	}
	
	if (indexPath.section==0 && indexPath.row==7) {
		AssetPickerViewController *assetPickVC = [[AssetPickerViewController alloc] init];
		[self.navigationController pushViewController:assetPickVC animated:YES];
	}
	
	if (indexPath.section==0 && indexPath.row==8) {
		JsonModelTestViewController *jsonModelVC = [[JsonModelTestViewController alloc] init];
		[self.navigationController pushViewController:jsonModelVC animated:YES];
	}
	
	if (indexPath.section==0 && indexPath.row==9) {
		GCDMainViewController *gcdMainVC = [[GCDMainViewController alloc] init];
		gcdMainVC.navigationItem.title = @"GCDTest";
		[self.navigationController pushViewController:gcdMainVC animated:YES];
	}
}


@end






