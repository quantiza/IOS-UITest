//
//  ConcurrentViewController.m
//  ios-UITest
//
//  Created by yangl on 2017/4/21.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "ConcurrentViewController.h"
#import "Concurrent1ViewController.h"
#import "Concurrent2ViewController.h"
#import "Concurrent3ViewController.h"

@interface ConcurrentViewController ()

@end

@implementation ConcurrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self createUI];
}

- (void)createUI
{
	self.title = @"Concurrent";
}
    
- (IBAction)concurrent1Click:(id)sender {
	Concurrent1ViewController *concurrent1VC = [[Concurrent1ViewController alloc] init];
	concurrent1VC.title = @"NSThread";
	[self.navigationController pushViewController:concurrent1VC animated:YES];
}
- (IBAction)concurrent2Click:(id)sender {
	Concurrent2ViewController *concurrent2VC = [[Concurrent2ViewController alloc] init];
	concurrent2VC.title = @"NSOperationQueue";
	[self.navigationController pushViewController:concurrent2VC animated:YES];
}
- (IBAction)concurrent3Click:(id)sender {
	Concurrent3ViewController *concurrent3VC = [[Concurrent3ViewController alloc] init];
	concurrent3VC.title = @"GCD";
	[self.navigationController pushViewController:concurrent3VC animated:YES];
}
- (IBAction)concurrent4Click:(id)sender {
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
