//
//  GHIssue.m
//  ios-UITest
//
//  Created by yangl on 2017/4/27.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "GHIssue.h"
#import "GHUser.h"

@implementation GHIssue

+ (NSDateFormatter *)dateFormatter
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
	dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
	return dateFormatter;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [self init];
	if (self == nil) {
		return nil;
	}
	
	_URL = [NSURL URLWithString:dictionary[@"url"]];
	_HTMLURL = [NSURL URLWithString:dictionary[@"html_url"]];
	_number = dictionary[@"number"];
	
	if ([dictionary[@"state"] isEqualToString:@"open"]) {
		_state = GHIssueStateOpen;
	} else if ([dictionary[@"state"] isEqualToString:@"closed"]) {
		_state = GHIssueStateClosed;
	}
	
	_title = [dictionary[@"title"] copy];
	_retrievedAt = [NSDate date];
	_body = [dictionary[@"body"] copy];
	_reporterLogin = [dictionary[@"user"][@"login"] copy];
	_assignee = [[GHUser alloc] initWithDictionary:dictionary[@"assignee"]];
	
	_updatedAt = [self.class.dateFormatter dateFromString:dictionary[@"updated_at"]];
	
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_URL = [aDecoder decodeObjectForKey:@"URL"];
	_HTMLURL = [aDecoder decodeObjectForKey:@"HTMLURL"];
	_number = [aDecoder decodeObjectForKey:@"number"];
	_state = [aDecoder decodeIntegerForKey:@"state"];
	_title = [aDecoder decodeObjectForKey:@"title"];
	_retrievedAt = [NSDate date];
	_body = [aDecoder decodeObjectForKey:@"body"];
	_reporterLogin = [aDecoder decodeObjectForKey:@"reporterLogin"];
	_assignee = [aDecoder decodeObjectForKey:@"assignee"];
	_updatedAt = [aDecoder decodeObjectForKey:@"updatedAt"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	if (self.URL != nil) [coder encodeObject:self.URL forKey:@"URL"];
	if (self.HTMLURL != nil) [coder encodeObject:self.HTMLURL forKey:@"HTMLURL"];
	if (self.number != nil) [coder encodeObject:self.number forKey:@"number"];
	if (self.title != nil) [coder encodeObject:self.title forKey:@"title"];
	if (self.body != nil) [coder encodeObject:self.body forKey:@"body"];
	if (self.reporterLogin != nil) [coder encodeObject:self.reporterLogin forKey:@"reporterLogin"];
	if (self.assignee != nil) [coder encodeObject:self.assignee forKey:@"assignee"];
	if (self.updatedAt != nil) [coder encodeObject:self.updatedAt forKey:@"updatedAt"];
	
	[coder encodeInteger:self.state forKey:@"state"];
}

- (instancetype)copyWithZone:(NSZone *)zone {
	GHIssue *issue = [[self.class allocWithZone:zone] init];
	issue->_URL = self.URL;
	issue->_HTMLURL = self.HTMLURL;
	issue->_number = self.number;
	issue->_state = self.state;
	issue->_reporterLogin = self.reporterLogin;
	issue->_assignee = self.assignee;
	issue->_updatedAt = self.updatedAt;
	
	issue.title = self.title;
	issue->_retrievedAt = [NSDate date];
	issue.body = self.body;
	
	return issue;
}

- (NSUInteger)hash
{
	return self.number.hash;
}

- (BOOL)isEqual:(GHIssue *)issue
{
	if (![issue isKindOfClass:GHIssue.class]) return NO;
	
	return [self.number isEqual:issue.number] && [self.title isEqual:issue.title] && [self.body isEqual:issue.body];
}

@end
