//
//  SearchResultsViewController.m
//  ios-UITest
//
//  Created by yangl on 2016/12/20.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "SearchResultsViewController.h"

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//	self.tableView.tableHeaderView
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [self.searchDataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
	
	cell.textLabel.text = [self.searchDataArray objectAtIndex:indexPath.row];
	
	return cell;
}





@end
