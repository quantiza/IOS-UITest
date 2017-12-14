//
//  FSAudioView.m
//  ios-UITest
//
//  Created by yangl on 2017/1/12.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "FSAudioView.h"
#import <FreeStreamer/FSAudioStream.h>

@interface FSAudioView ()

@property (nonatomic, strong) FSAudioStream *audioStream;

@end

@implementation FSAudioView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createUI];
	}
	return self;
}

- (void)createUI {

	NSString *urlStr = @"http://127.0.0.1/music-wqs.mp3";
	NSURL *url = [NSURL URLWithString:urlStr];
	
	_audioStream = [[FSAudioStream alloc] initWithUrl:url];
	
	[_audioStream setOnFailure:^(FSAudioStreamError error, NSString *description) {
		NSLog(@"播放过程中发生错误，错误信息：%@",description);
	}];
	
	[_audioStream setOnCompletion:^{
		NSLog(@"播放完成!");
	}];
	
	[_audioStream play];
}

@end
