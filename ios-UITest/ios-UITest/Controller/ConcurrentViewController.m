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
#import "FindMinMaxThread.h"

@interface ConcurrentViewController ()
{
    NSMutableArray *numbers;
}
@end

@implementation ConcurrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self createUI];
    numbers = [NSMutableArray array];
    for (NSInteger i = 0; i<50000; i++) {
        [numbers addObject:[NSNumber numberWithInt:rand()]];
    }
    [self findMaxMin];
}

- (void)createUI
{
	self.title = @"Concurrent";
}

- (void)findMaxMin {
    NSDate *date1 = [NSDate date];
    NSNumber *max =  @0;
    for (NSNumber *x in numbers) {
        max = MAX(max, x);
    }
    NSDate *date2 = [NSDate date];
    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date1];
    
    for (NSUInteger i = 0; i<4; i++) {
        NSUInteger piece = i*numbers.count/4;
    }
    
    
    NSLog(@"======%f", timeInterval);
//    NSMutableSet *threads = [NSMutableSet set];
//    NSUInteger numberCount = numbers.count;
//    NSUInteger threadCount = 4;
//    for (NSUInteger i = 0; i < threadCount; i++) {
//        MAX(<#A#>, <#B#>)
//    }
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=======%d", rand());
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
