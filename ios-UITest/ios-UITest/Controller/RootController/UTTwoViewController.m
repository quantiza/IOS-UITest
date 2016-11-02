//
//  UTTwoViewController.m
//  ios-UITest
//
//  Created by 华生侯 on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTTwoViewController.h"
#import "FitConsts.h"
#import "UTButtonTestController.h"
#import "UTDatePickerTestController.h"
#import "UTPageController.h"
#import "UTSegmentedController.h"
#import "UTSliderController.h"

@interface UTTwoViewController() <UITableViewDelegate, UITableViewDataSource> {
    UITableView *table;
    NSArray *cellTitle;
}

@end

@implementation UTTwoViewController

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
    NSString *one = @"UIButton Test";
    NSString *two = @"UIDetePicker Test";
    NSString *three = @"UIPageControl Test";
    NSString *four = @"UISegmentedControl Test";
    NSString *five = @"UISlider Test";
    NSString *t = @"Test";
    cellTitle = @[one, two, three, four, five,t,t,t,t,t];
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
        UTButtonTestController *touchVC = [[UTButtonTestController alloc] init];
        [self.navigationController pushViewController:touchVC animated:YES];
    }
    
    if (indexPath.section==0 && indexPath.row==1) {
        UTDatePickerTestController *datePickerVC = [[UTDatePickerTestController alloc] init];
        [self.navigationController pushViewController:datePickerVC animated:YES];
    }
    
    if (indexPath.section==0 && indexPath.row==2) {
        UTPageController *pageCtrl = [[UTPageController alloc] init];
        [self.navigationController pushViewController:pageCtrl animated:YES];
    }
    
    if (indexPath.section==0 && indexPath.row==3) {
        UTSegmentedController *segCtrl = [[UTSegmentedController alloc] init];
        [self.navigationController pushViewController:segCtrl animated:YES];
    }
    
    if (indexPath.section==0 && indexPath.row==4) {
        UTSliderController *sliderCtrl = [[UTSliderController alloc] init];
        [self.navigationController pushViewController:sliderCtrl animated:YES];
    }
}






@end
