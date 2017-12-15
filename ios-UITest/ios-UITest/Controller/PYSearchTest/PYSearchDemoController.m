//
//  PYSearchDemoController.m
//  ios-UITest
//
//  Created by Long Yang on 2017/12/15.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "PYSearchDemoController.h"
#import "FitConsts.h"
#import <PYSearch.h>
#import "PYTempViewController.h"

@interface PYSearchDemoController () <PYSearchViewControllerDelegate>

@end

@implementation PYSearchDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 5 : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (0 == indexPath.section) {
        cell.textLabel.text = @[@"PYHotSearchStyleDefault", @"PYHotSearchStyleColorfulTag", @"PYHotSearchStyleBorderTag", @"PYHotSearchStyleARCBorderTag", @"PYHotSearchStyleRankTag", @"PYHotSearchStyleRectangleTag"][indexPath.row];
    } else {
        cell.textLabel.text = @[@"PYSearchHistoryStyleDefault", @"PYSearchHistoryStyleNormalTag", @"PYSearchHistoryStyleColorfulTag", @"PYSearchHistoryStyleBorderTag", @"PYSearchHistoryStyleARCBorderTag"][indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1. Create an Array of popular search
//    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    //2. Create a search controller
//    PYSearchViewController *searchVC = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches
//                                                                              searchBarPlaceholder:NSLocalizedString(@"PYExampleSearchPlaceholderText", @"搜索编程语言")
//                                                                                    didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//                                                                                        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
//                                                                                    }];
    PYSearchViewController *searchVC = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"搜索"];
    searchVC.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? NSLocalizedString(@"PYExampleTableSectionZeroTitle", @"选择搜索历史风格（热门搜索为默认风格)") : NSLocalizedString(@"PYExampleTabl   le", @"选择热门搜索风格（搜索历史为默认风格)");
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

@end



















