//
//  GHIssueMantle.m
//  ios-UITest
//
//  Created by yangl on 2017/4/27.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "GHIssueMantle.h"
#import "GHUserMantle.h"

@implementation GHIssueMantle

+ (NSDateFormatter *)dateFormatter {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
	dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
	return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return @{
			 @"title":@"title",
			 @"URL": @"url",
			 @"HTMLURL": @"html_url",
			 @"number": @"number",
			 @"state": @"state",
			 @"reporterLogin": @"user.login",
			 @"assignee": @"assignee",
			 @"updatedAt": @"updated_at"
			 };
}

@end
