//
//  MultiLabelView.m
//  ios-UITest
//
//  Created by yangl on 2017/4/1.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "MultiLabelView.h"
#import "FitConsts.h"

#define defaultColor TEXT_COLOR_LEVEL_2
#define selectedColor RED_COLOR

@implementation MultiLabelView
{
	NSInteger clickTag;
}

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)arr
{
	self = [super initWithFrame:frame];
	if (self) {
		
		[self createUIWithArray:arr];
	}
	return self;
}

- (void)createUIWithArray:(NSArray *)arr
{
	CGFloat leadingSpace = 10;
	CGFloat topSpace = 10;
	CGFloat inset = 10;
	int i = 0;
	for (NSString *item in arr) {
		UILabel *label = [[UILabel alloc] init];
		label.tag = i;
		label.text = item;
		label.font = TEXT_FONT_LEVEL_1;
		label.textColor = TEXT_COLOR_LEVEL_2;
		label.layer.borderWidth = 0.5;
		label.layer.borderColor = TEXT_COLOR_LEVEL_2.CGColor;
		label.layer.cornerRadius = 3;
		label.layer.masksToBounds = YES;
		label.textAlignment = NSTextAlignmentCenter;
		[label sizeToFit];
		if (leadingSpace + label.frame.size.width + 20 + inset > self.frame.size.width) {
			topSpace = topSpace + label.frame.size.height + 10 + inset;
			_height = topSpace + label.frame.size.height + 10 + inset;
			leadingSpace = 10;
		}
		label.frame = CGRectMake(leadingSpace, topSpace, label.frame.size.width+20, label.frame.size.height+10);
		label.userInteractionEnabled = YES;
		[self addSubview:label];
		
		[label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabel:)]];
		
		leadingSpace = leadingSpace + label.frame.size.width + inset;
		i++;
	}
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _height);
}

- (void)clickLabel:(UITapGestureRecognizer *)tapGest
{
	if (clickTag != 0) {
		UILabel *lastSelectedLabel = [self viewWithTag:clickTag];
		lastSelectedLabel.textColor = defaultColor;
		lastSelectedLabel.layer.borderColor = defaultColor.CGColor;
	}
	UILabel *thisSelectedLabel = (UILabel *)tapGest.view;
	thisSelectedLabel.textColor = RED_COLOR;
	thisSelectedLabel.layer.borderColor = RED_COLOR.CGColor;
	clickTag = tapGest.view.tag;
	[self.delegate multilabelClickWithIndex:clickTag];
}

@end
