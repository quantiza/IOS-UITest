//
//  TableViewOptController.m
//  ios-UITest
//
//  Created by Long Yang on 2018/4/16.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "TableViewOptController.h"
#import "NSString+Additions.h"
#import "UIScreen+Additions.h"
#import "UIView+Additions.h"
#import "OptTableViewCell.h"
#import "GenerateDatas.h"

@implementation TableViewOptController 
{
    UITableView *tableView;
    NSMutableArray *datas;
}
//读取信息

- (void)viewDidLoad {
    [super viewDidLoad];
    GenerateDatas *dataObj = [GenerateDatas new];
    datas = [[dataObj loadData] mutableCopy];
    [self createUI];
}

- (void)createUI {
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = datas[indexPath.row];
    float height = [dict[@"frame"] CGRectValue].size.height;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    OptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[OptTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell drawWithData:[datas objectAtIndex:indexPath.row]];
    return cell;
}

@end
