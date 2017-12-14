//
//  AVAudioPlayerView.m
//  ios-UITest
//
//  Created by yangl on 2017/1/12.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "AVAudioPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "FitConsts.h"

@interface AVAudioPlayerView ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation AVAudioPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createUI];
	}
	return self;
}

- (void)createUI {
	NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"music-wqs" ofType:@"mp3"];
	NSURL *url = [NSURL fileURLWithPath:urlStr];
	NSError *error = nil;
	_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
														  error:&error];
//	_audioPlayer.delegate = self;
	[_audioPlayer prepareToPlay];
	if (error) {
		NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
	}
	
	//play button
	UILabel *playL = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 20)];
	playL.text = @"play";
	playL.textColor = ORANGE_COLOR;
	playL.userInteractionEnabled = YES;
	[playL addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playMusic)]];
	[self addSubview:playL];
	
	//pause button
	UILabel *pauseL = [[UILabel alloc] initWithFrame:CGRectMake(200, 50, 100, 20)];
	pauseL.text = @"pause";
	pauseL.textColor = ORANGE_COLOR;
	pauseL.userInteractionEnabled = YES;
	[pauseL addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseMusic)]];
	[self addSubview:pauseL];
}

- (void)playMusic {
	[_audioPlayer play];
}

- (void)pauseMusic {
	[_audioPlayer pause];
}

@end
