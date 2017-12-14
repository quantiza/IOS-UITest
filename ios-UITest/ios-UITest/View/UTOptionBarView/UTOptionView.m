//
//  UTOptionView.m
//  ios-UITest
//
//  Created by yangl on 2016/11/8.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTOptionView.h"
#import "FitConsts.h"

@interface UTOptionView () {
    NSMutableArray<UILabel *> *items;
}

@end


@implementation UTOptionView


- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        [self createItem:titles];
    }
    return self;
}


- (void)createItem:(NSArray *)titles {
    items = [NSMutableArray new];
    if (titles.count > 0) {
        CGFloat itemWidth = kScreenWidth / titles.count;
        for (int i = 0; i < titles.count; i++) {
            UILabel *item = [[UILabel alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, self.frame.size.height)];
            item.userInteractionEnabled = YES;
            item.tag = i;
            item.textAlignment = NSTextAlignmentCenter;
            item.font = TEXT_FONT_LEVEL_2;
            item.text = titles[i];
            [self addSubview:item];
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)]];
            [items addObject:item];
        }
    }
    //初始选中项
    items[0].textColor = RED_COLOR;
    //底部线条
    _lineLayer = [CALayer layer];
    _lineLayer.frame = CGRectMake(0, self.frame.size.height, kScreenWidth, kLineHeight);
    _lineLayer.backgroundColor = BLACK_COLOR.CGColor;
    [self.layer addSublayer:_lineLayer];
}


- (void)tapItem:(UITapGestureRecognizer *)tapGest {
    _handleContentScroll(tapGest.view.tag);
    NSLog(@">>>>>>>>>>>>>>>>>>>>%ld", (long)tapGest.view.tag);
    for (UILabel* element in items) {
        element.textColor = BLACK_COLOR;
    }
    UILabel *tapLabel = (UILabel *)tapGest.view;
    tapLabel.textColor = RED_COLOR;
}

- (void)setSelectedTag:(NSInteger)selectedTag {
    for (UILabel* element in items) {
        element.textColor = BLACK_COLOR;
    }
    items[selectedTag].textColor = RED_COLOR;
}

@end
