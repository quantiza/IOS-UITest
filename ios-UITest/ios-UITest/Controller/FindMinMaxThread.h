//
//  FindMinMaxThread.h
//  ios-UITest
//
//  Created by Long Yang on 2018/4/25.
//  Copyright © 2018年 yl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindMinMaxThread : NSThread

@property(nonatomic) NSUInteger min;
@property(nonatomic) NSUInteger max;

- (instancetype)initWithNumbers:(NSArray *)numbers;

@end
