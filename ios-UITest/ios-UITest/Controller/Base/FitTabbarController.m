//
//  FitTabbarController.m
//  FitTrainer
//
//  Created by Huasheng on 15/8/20.
//  Copyright (c) 2015年 Huasheng. All rights reserved.
//

#import "FitTabbarController.h"
#import "FitNavigationController.h"
#import "UTOneViewController.h"
#import "UTTwoViewController.h"
#import "UTThirdViewController.h"

@implementation FitTabbarController

- (id)init
{
    self = [super init];
    if (self)
    {
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    [self.tabBar setTintColor:[UIColor blackColor]];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}
                                            forState:UIControlStateNormal];
   
    //设置工具栏中文字的偏移量
    [[UITabBarItem appearance]setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //1.创建一个VC，设置VC的title
    //2.创建一个Nav，设置其rootViewController
    //3.设置NavTabBarItem
    //4.最后把Nav加进TabbbarController的ViewControllers里
    //基本逻辑是：window.rootVC=tabbar => tabbar.VCs=[navVC1,navVC2...] => navVC.rootVC=VC
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    UTOneViewController *oneVC = [[UTOneViewController alloc] init];
    oneVC.title = @"TAB ONE";
    FitNavigationController *oneNav = [[FitNavigationController alloc] initWithRootViewController:oneVC];
    UITabBarItem *itemOne = [[UITabBarItem alloc] initWithTitle:@"First" image:nil selectedImage:nil];
    [oneNav setTabBarItem:itemOne];
    
    UTTwoViewController *twoVC = [[UTTwoViewController alloc] init];
    twoVC.title = @"TAB TWO";
    FitNavigationController *twoNav = [[FitNavigationController alloc] initWithRootViewController:twoVC];
    UITabBarItem *itemTwo = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil selectedImage:nil];
    [twoNav setTabBarItem:itemTwo];
	
	UTThirdViewController *thirdVC = [[UTThirdViewController alloc] init];
	thirdVC.title = @"TAB THREE";
	FitNavigationController *thirdNav = [[FitNavigationController alloc] initWithRootViewController:thirdVC];
	UITabBarItem *itemThird = [[UITabBarItem alloc] initWithTitle:@"Third" image:nil selectedImage:nil];
	[thirdNav setTabBarItem:itemThird];
	
    [self setViewControllers:@[oneNav, twoNav, thirdNav] animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end














