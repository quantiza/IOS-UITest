//
//  JsonModelTestViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/17.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "JsonModelTestViewController.h"
#import "FitConsts.h"
#import <JSONModel.h>
#import "ReposModel.h"
#import "GithubRepoModel.h"


@interface MyModel : JSONModel
@property(nonatomic) NSString *foo;
@property(nonatomic) NSInteger a;
@end

@implementation MyModel
@end



@interface JsonModelTestViewController ()

@end

@implementation JsonModelTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.navigationItem.title = @"JsonModel Test";
	self.view.backgroundColor = WHITE_COLOR;
	
	[self stringTest];
	[self arrayTest];
}

#pragma mark - pares string
- (void)stringTest
{
	NSString *json = @"{\"foo\":\"bar\",\"a\":1}";
	NSError *error = nil;
	
	MyModel *obj = [[MyModel alloc] initWithString:json error:&error];
	
	NSLog(@"%@", obj);
}

- (void)arrayTest {
	NSString* filePath = @"/Users/Ylong/Documents/IOS-UITest/ios-UITest/ios-UITest/Help/Data/github-iphone.json";
	NSString * jsonContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	NSError *err;
	
	ReposModel *repos = [[ReposModel alloc] initWithString:jsonContents error:&err];
	NSLog(@"%@", repos.repositories);

}



@end
