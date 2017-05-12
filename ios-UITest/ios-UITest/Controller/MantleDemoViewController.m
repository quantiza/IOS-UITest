//
//  MantleDemoViewController.m
//  ios-UITest
//
//  Created by yangl on 2017/4/27.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "MantleDemoViewController.h"
#import "NoMantleViewController.h"

@interface MantleDemoViewController ()

@end

@implementation MantleDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"演示Gitub Issue";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
	}
	if (indexPath.row == 0) {
		cell.textLabel.text = @"不使用Mantle";
		cell.detailTextLabel.text = @"不使用Mantle显示数据";
	} else {
		cell.textLabel.text = @"使用Mantle";
		cell.detailTextLabel.text = @"使用Mantle显示数据";
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		NoMantleViewController *noMantleVC = [[NoMantleViewController alloc] init];
		noMantleVC.view.backgroundColor = [UIColor whiteColor];
		[self.navigationController pushViewController:noMantleVC animated:YES];
	}
	if (indexPath.row == 1) {
		UIViewController *vc2 = [[UIViewController alloc] init];
		vc2.view.backgroundColor = [UIColor whiteColor];
		[self.navigationController pushViewController:vc2 animated:YES];
	}
}
@end
