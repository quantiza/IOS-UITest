//
//  UTOptionView.h
//  ios-UITest
//
//  Created by yangl on 2016/11/8.
//  Copyright © 2016年 yl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UTOptionView : UIView

@property(nonatomic, strong) CALayer *lineLayer;

@property(nonatomic) NSInteger selectedTag;

@property(nonatomic, copy) void (^handleContentScroll)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;

@end
