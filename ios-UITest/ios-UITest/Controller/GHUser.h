//
//  GHUser.h
//  ios-UITest
//
//  Created by yangl on 2017/4/27.
//  Copyright © 2017年 yl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHUser : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy) NSString *login;
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *gravatarId;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *htmlUrl;
@property (nonatomic, copy) NSString *followersUrl;
@property (nonatomic, copy) NSString *followingUrl;
@property (nonatomic, copy) NSString *gistsUrl;
@property (nonatomic, copy) NSString *starredUrl;
@property (nonatomic, copy) NSString *subscriptionsUrl;
@property (nonatomic, copy) NSString *organizationsUrl;
@property (nonatomic, copy) NSString *reposUrl;
@property (nonatomic, copy) NSString *eventsUrl;
@property (nonatomic, copy) NSString *receivedEventsUrl;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL siteAdmin;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
