//
//  GihubRepoModel.h
//  ios-UITest
//
//  Created by yangl on 2016/11/17.
//  Copyright © 2016年 yl. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GithubRepoModel : JSONModel

@property (strong, nonatomic) NSDate* created;
@property (strong, nonatomic) NSDate* pushed;
@property (assign, nonatomic) int watchers;
@property (strong, nonatomic) NSString* owner;
@property (assign, nonatomic) int forks;
@property (strong, nonatomic) NSString<Optional>* language;
@property (assign, nonatomic) BOOL fork;
@property (assign, nonatomic) double size;
@property (assign, nonatomic) int followers;

@end
