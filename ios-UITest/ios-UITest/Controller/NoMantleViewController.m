//
//  NoMantleViewController.m
//  ios-UITest
//
//  Created by yangl on 2017/4/27.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "NoMantleViewController.h"
#import "FitConsts.h"

@interface NoMantleViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
NSURLConnectionDataDelegate
>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NoMantleViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"不使用Mantle";
	[self.view addSubview:self.tableView];
	[self refreshDataSource];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
	if (!_dataSource) {
		_dataSource = [NSMutableArray array];
	}
	return _dataSource;
}

- (UITableView *)tableView
{
	if (_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
		_tableView.dataSource = self;
		_tableView.delegate = self;
		_tableView.backgroundColor = [UIColor whiteColor];
	}
	return _tableView;
}

#pragma mark - uitableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	return  cell;
}

- (void)refreshDataSource
{
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.github.com/repos/mantle/mantle/issues"]];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

#pragma mark - nsurlconnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSLog(@" current thread %@", [NSThread currentThread]);
	dispatch_async(dispatch_get_main_queue(), ^{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		NSLog(@" current thread %@", [NSThread currentThread]);
	});
	
	//数据处理
	//issue字典转换为模型
	NSArray *issueArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
	NSLog(@"current thread %@", [NSThread currentThread]);
}

@end
