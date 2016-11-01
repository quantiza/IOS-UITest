//
//  UTBBViewController.h
//  ios-UITest
//
//  Created by 华生侯 on 2016/11/1.
//  Copyright © 2016年 yl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UTBBViewDelegate <NSObject>

- (void)showName:(NSString *)nameStr;

@end

typedef void (^ablock) (NSString *str);


@interface UTBBViewController : UIViewController

@property(nonatomic) NSInteger flag;

@property(nonatomic,weak) id<UTBBViewDelegate> delegate;

@property(nonatomic,copy) ablock block;

@end
