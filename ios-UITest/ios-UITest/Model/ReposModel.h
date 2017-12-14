//
//  ReposModel.h
//  ios-UITest
//
//  Created by yangl on 2016/11/17.
//  Copyright © 2016年 yl. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GithubRepoModel;


@interface ReposModel : JSONModel

@property (strong, nonatomic) NSMutableArray<GithubRepoModel>* repositories;

@end






