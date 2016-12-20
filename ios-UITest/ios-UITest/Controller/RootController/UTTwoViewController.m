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
#import "UTSwitchController.h"
#import "UTTextFieldController.h"
#import "UTOptionbarDesignController.h"
#import "CITestViewController.h"
#import "AnimationViewController.h"
#import "UTSearchController.h"

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
    NSString *six = @"UISwitch Test";
    NSString *seven = @"UITextField Test";
    NSString *eight = @"UTOptionBar Design";
    NSString *nine = @"CoreImage Test";
    NSString *ten = @"Animation Test";
	NSString *aa = @"UISearch Test";
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
    return 17;
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
    
    if (indexPath.section==0 && indexPath.row==5) {
        UTSwitchController *switchCtrl = [[UTSwitchController alloc] init];
        [self.navigationController pushViewController:switchCtrl animated:YES];
    }
    
    if (indexPath.section==0 && indexPath.row==6) {
        UTTextFieldController *textFieldCtrl = [[UTTextFieldController alloc] init];
        [self.navigationController pushViewController:textFieldCtrl animated:YES];
    }
    
    if (indexPath.section==0 && indexPath.row==7) {
        UTOptionbarDesignController *optionCtrl = [[UTOptionbarDesignController alloc] init];
        [self.navigationController pushViewController:optionCtrl animated:YES];
    }
	
	if (indexPath.section==0 && indexPath.row==8) {
		CITestViewController *CITestCtrl = [[CITestViewController alloc] init];
		CITestCtrl.navigationItem.title = @"Core Image Test";
		CITestCtrl.view.backgroundColor = WHITE_COLOR;
		[self.navigationController pushViewController:CITestCtrl animated:YES];
	}
	
	if (indexPath.section==0 && indexPath.row==9) {
		AnimationViewController *animationVC = [[AnimationViewController alloc] init];
		animationVC.navigationItem.title = @"Animation Test";
		animationVC.view.backgroundColor = WHITE_COLOR;
		[self.navigationController pushViewController:animationVC animated:YES];
	}
	
	if (indexPath.section==0 && indexPath.row==10) {
		UTSearchController *searchVC = [[UTSearchController alloc] init];
		searchVC.navigationItem.title = @"SearchController Test";
		searchVC.view.backgroundColor = WHITE_COLOR;
		[self.navigationController pushViewController:searchVC animated:YES];
	}
}






@end
