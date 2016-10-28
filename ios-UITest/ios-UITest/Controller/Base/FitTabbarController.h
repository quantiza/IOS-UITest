
//
//  FitTabbarController.h
//  FitTrainer
//
//  Created by Huasheng on 15/8/20.
//  Copyright (c) 2015年 Huasheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FitConsts.h"

typedef enum {
  
    kFitPickerViewTypeWater     = 1,
    kFitPickerViewTypeWeight    = 2
} FitPickerViewType;

@interface FitTabbarController : UITabBarController

@property   (assign, nonatomic) FitPickerViewType   pickerType;

@end
