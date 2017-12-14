//
//  UTSearchController.m
//  ios-UITest
//
//  Created by yangl on 2016/12/20.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTSearchController.h"
#import "FitConsts.h"
#import <Contacts/Contacts.h>
@interface UTSearchController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>

//tableView
@property (strong, nonatomic)  UITableView *tableView;

//searchController
@property (strong, nonatomic)  UISearchController *searchController;

//数据源
@property (strong,nonatomic) NSMutableArray  *dataList;

@property (strong,nonatomic) NSMutableArray  *searchList;

@end

@implementation UTSearchController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_dataList = [NSMutableArray array];
	_searchList = [NSMutableArray array];
	
	self.dataList=[NSMutableArray arrayWithCapacity:100];
	
	//产生100个“数字+三个随机字母”
	for (NSInteger i=0; i<100; i++) {
		[self.dataList addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
	}
	
	_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen  mainScreen].bounds.size.width ,[UIScreen  mainScreen].bounds.size.height)];
	
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
	
	//创建UISearchController
	_searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
	//设置代理
	_searchController.delegate = self;
	_searchController.searchResultsUpdater= self;
	
	//设置UISearchController的显示属性，以下3个属性默认为YES
	//搜索时，背景变暗色
//	_searchController.dimsBackgroundDuringPresentation = NO;
	//搜索时，背景变模糊
//	_searchController.obscuresBackgroundDuringPresentation = NO;
	//隐藏导航栏
	_searchController.hidesNavigationBarDuringPresentation = NO;
	
	_searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
	
	// 添加 searchbar 到 headerview
	self.tableView.tableHeaderView = _searchController.searchBar;
	
	[self.view addSubview:_tableView];
	[self getContact];
	// Do any additional setup after loading the view, typically from a nib.
}


//产生3个随机字母
- (NSString *)shuffledAlphabet {
	
	NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
	
	NSString *strTest = [[NSString alloc]init];
	for (int i=0; i<3; i++) {
		int x = arc4random() % 25;
		strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
	}
	
	return strTest;
	
}



- (void)getContact {
	CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
	if (authorizationStatus == CNAuthorizationStatusAuthorized) {
		NSLog(@"没有授权...");
	}
	
	// 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
	NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
	CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
	CNContactStore *contactStore = [[CNContactStore alloc] init];
	[contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
		NSLog(@"-------------------------------------------------------");
		NSString *givenName = contact.givenName;
		NSString *familyName = contact.familyName;
		NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
		
		
		NSArray *phoneNumbers = contact.phoneNumbers;
		for (CNLabeledValue *labelValue in phoneNumbers) {
			NSString *label = labelValue.label;
			CNPhoneNumber *phoneNumber = labelValue.value;
			
			NSLog(@"label=%@, phone=%@", label, phoneNumber.stringValue);
		}
		
		//        *stop = YES;  // 停止循环，相当于break；
	}];
	
}





//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (self.searchController.active) {
		return [self.searchList count];
	}else{
		return [self.dataList count];
	}
}


//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *flag=@"cell";
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
	if (cell==nil) {
		cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
	}
	if (self.searchController.active) {
		[cell.textLabel setText:self.searchList[indexPath.row]];
	}
	else{
		[cell.textLabel setText:self.dataList[indexPath.row]];
	}
	return cell;
}


#pragma mark - UISearchControllerDelegate代理

//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
	NSLog(@"willPresentSearchController");

}

- (void)didPresentSearchController:(UISearchController *)searchController
{
	NSLog(@"didPresentSearchController");

}

- (void)willDismissSearchController:(UISearchController *)searchController
{
	NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
	NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
	NSLog(@"presentSearchController");
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
	
	NSLog(@"updateSearchResultsForSearchController");
	NSString *searchString = [self.searchController.searchBar text];
	NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
	if (self.searchList!= nil) {
		[self.searchList removeAllObjects];
	}
	//过滤数据
	self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
	//刷新表格
	[self.tableView reloadData];
}

@end

