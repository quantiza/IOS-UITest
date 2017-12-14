//
//  UTPageController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/2.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTPageController.h"
#import "FitConsts.h"

@interface UTPageController ()<UIScrollViewDelegate> {
    UIPageControl *pageControl;
    UIPageControl *pageControl1;
    NSInteger nowPage;
    NSInteger lastPage;
    CALayer *_lineLayer;
}

@end

@implementation UTPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    nowPage = 0;
    lastPage = 0;
    [self initLayout];
    //[self showScrollView];
    // Do any additional setup after loading the view.
}


#pragma mark 特别注意，uipageControl页数为2时，可以自动回转，0-1-0-1-0-1
- (void)initLayout {
    self.title = @"Page Control";
    self.view.backgroundColor = WHITE_COLOR;
    
    pageControl1 = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 300, 100, 20)];
    [pageControl1 setPageIndicatorTintColor:ORANGE_COLOR];
    [pageControl1 setCurrentPageIndicatorTintColor:RED_COLOR];
    [pageControl1 setNumberOfPages:2];          //必须要设置页数否则不出现内容
    [self.view addSubview:pageControl1];
    
    
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth-40, 100)];
    [pageControl setBackgroundColor:BG_GRAY_COLOR];             //背景色
    [pageControl setNumberOfPages:5];                           //页数
    [pageControl setCurrentPage:3];                             //指定当前页
    [pageControl setCurrentPageIndicatorTintColor:RED_COLOR];   //选中页点色,默认白色
    [pageControl setPageIndicatorTintColor:BLACK_COLOR];        //默认页点色
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pageControl];
    
    
    _lineLayer = [CALayer layer];
    _lineLayer.frame = CGRectMake(0, 300, kScreenWidth, 5);
    _lineLayer.backgroundColor = RED_COLOR.CGColor;
    [self.view.layer addSublayer:_lineLayer];
    
}


//当使用UIControlEventTouchUpInside事件时，点击一直可以触发
//当使用UIControlEventValueChanged事件时，点击早page结尾或开头时就停止触发了
- (void)pageChanged:(UIPageControl *)pageC {
    //通过判断前后页的值是否相同进行循环轮动
    lastPage = nowPage;
    nowPage = pageC.currentPage;
    NSLog(@"=======lastPage=%ld, nowPage=%ld", (long)lastPage,(long)nowPage);
    if (nowPage == pageControl.numberOfPages-1) {
        if (lastPage == nowPage || lastPage == 0) {
            pageControl.currentPage = 0;
        }
    }
    
    if (nowPage == 0) {
        if (lastPage == nowPage || lastPage == pageControl.numberOfPages-1) {
            pageControl.currentPage = pageControl.numberOfPages - 1;
        }
    }
}


- (void)showScrollView {
    self.title = @"Page Control";
    self.view.backgroundColor = WHITE_COLOR;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置UIScrollView 的显示内容的尺寸，有n张图要显示，就设置 屏幕宽度*n ，这里假设要显示4张图
    scrollView.contentSize = CGSizeMake(kScreenWidth*4, kNormalHeight);
    scrollView.tag = 101;
    //设置翻页效果，不允许反弹，不显示水平滑动条，设置代理为自己
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    //在UIScrollView 上加入 UIImageView
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kNormalHeight)];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"shop%d", i+1]]];
        [scrollView addSubview:imageView];
    }
    //初始化 UIPageControl 和 _scrollView 显示在 同一个页面中
    UIPageControl *pc = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kNormalHeight-60, kScreenWidth, 40)];
    pc.numberOfPages = 4;
    pc.tag = 201;
    pc.currentPageIndicatorTintColor = COLOR_RED_LIGHT;
    pc.pageIndicatorTintColor = BLACK_COLOR;
    [self.view addSubview:scrollView];
    [self.view addSubview:pc];
}

#pragma mark scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int current = scrollView.contentOffset.x/kScreenWidth;
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:201];
    page.currentPage = current;
    
    if (page.currentPage == 3) {
        [self scrollViewDisappear];
    }
}

- (void)scrollViewDisappear {
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:101];
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:201];
    
    [UIView animateWithDuration:3.0f animations:^{
        scrollView.center = CGPointMake(kScreenWidth/2, 1.5*kNormalHeight);
    } completion:^(BOOL finished) {
        [scrollView removeFromSuperview];
        [page removeFromSuperview];
    }];
    
}

@end






