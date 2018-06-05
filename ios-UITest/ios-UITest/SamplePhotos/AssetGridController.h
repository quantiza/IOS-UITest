//
//  AssetGridController.h
//  ios-UITest
//
//  Created by Long Yang on 2018/5/30.
//  Copyright © 2018年 yl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@interface AssetGridController : UICollectionViewController

@property(nonatomic, strong) PHFetchResult<PHAsset*> *fetchResult;

@end
