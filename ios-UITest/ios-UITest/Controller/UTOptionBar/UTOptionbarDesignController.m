//
//  UTOptionbarDesignController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/8.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTOptionbarDesignController.h"
#import "FitConsts.h"
#import "UTOptionView.h"

@interface UTOptionbarDesignController () <UIScrollViewDelegate>

@property(nonatomic,strong) NSArray *titles;

@property(nonatomic,strong) UTOptionView *optionView;

@property(nonatomic,strong) UIScrollView *scrollView;

@end

@implementation UTOptionbarDesignController

- (void)viewDidLoad {
    _titles = @[@"新闻", @"小说", @"电影"];
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    self.navigationItem.title = @"UTOptionBar Design";
    self.view.backgroundColor = BG_GRAY_COLOR;
    
    _optionView = [[UTOptionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) andTitles:_titles];
    [self.view addSubview:_optionView];
    _optionView.handleContentScroll = ^(NSInteger index) {
        _scrollView.contentOffset = CGPointMake(index * kScreenWidth, 0);
    };
    
    CGFloat optionHeight = _optionView.frame.size.height;
    CGFloat topHeight = optionHeight + kStatuBarHeight + kNaviHeight;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, optionHeight, kScreenWidth, kScreenHeight - topHeight)];
    _scrollView.backgroundColor = ORANGE_COLOR;
    _scrollView.contentSize = CGSizeMake(_titles.count * kScreenWidth, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _titles.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, _scrollView.frame.size.height)];
        view.backgroundColor = [UIColor colorWithRed:1.0*i/_titles.count green:1.0*i/_titles.count blue:1.0*i/_titles.count alpha:1];
        [_scrollView addSubview:view];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index;
    index = scrollView.contentOffset.x / kScreenWidth;
    [_optionView setSelectedTag:index];
    NSLog(@">>>>>>*********>>%d", index);
}


@end





