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
    NSString *t = @"Test";
    cellTitle = @[one,two,t,t,t,t,t,t,t,t];
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
}


@end







