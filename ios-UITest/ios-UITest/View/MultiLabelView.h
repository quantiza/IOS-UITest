//
//  MultiLabelView.h
//  ios-UITest
//
//  Created by yangl on 2017/4/1.
//  Copyright © 2017年 yl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultilabelViewDelegate <NSObject>

- (void)multilabelClickWithIndex:(NSInteger)index;

@end

@interface MultiLabelView : UIView

@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)arr;

@property(nonatomic, strong) id <MultilabelViewDelegate> delegate;

@end
