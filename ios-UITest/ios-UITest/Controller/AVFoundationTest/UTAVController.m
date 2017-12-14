//
//  UTAVController.m
//  ios-UITest
//
//  Created by yangl on 2017/1/11.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "UTAVController.h"
#import "AVAudioPlayerView.h"
#import "FitConsts.h"
#import "FSAudioView.h"

@interface UTAVController ()


@end

@implementation UTAVController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupUI];
}


// * 使用AVAudioPlayer播放本地音乐
//
- (void)setupUI {
	
//	AVAudioPlayerView *audioPlayer = [[AVAudioPlayerView alloc] initWithFrame:self.view.bounds];
//	[self.view addSubview:audioPlayer];
	
	FSAudioView *fsview = [[FSAudioView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:fsview];
}
@end
