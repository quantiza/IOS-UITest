//
//  MainController.m
//  ios-UITest
//
//  Created by Long Yang on 2018/5/29.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "PhotoMasterController.h"
#import <Photos/Photos.h>

@interface PhotoMasterController () <UITableViewDelegate, UITableViewDataSource, PHPhotoLibraryChangeObserver>
{
    PHFetchResult<PHAsset*> *allPhotos;
    PHFetchResult<PHAssetCollection*> *smartAlbums;
    PHFetchResult<PHCollection*> *userCollections;
    
    NSArray *sectionLocalizedTitles;
    Section sectionEnum;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PhotoMasterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Photo Demo";
    sectionLocalizedTitles = @[@"", NSLocalizedString(@"Smart Albums", comment: @""), NSLocalizedString(@"Albums", comment: @"")];
    [self createUI];
    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES]];
    allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    userCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)createUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    sectionEnum = section;
    switch (sectionEnum) {
        case SectionAllPhotos:
            return 1;
        case SectionSmartAlbums:
            return smartAlbums.count;
        case SectionUserCollections:
            return userCollections.count;
        default: break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    switch (indexPath.section) {
        case SectionAllPhotos:
            cell.textLabel.text = @"All Photo";
            return cell;
        case SectionSmartAlbums:
            cell.textLabel.text = [[smartAlbums objectAtIndex:indexPath.row] localizedTitle];
            return cell;
        case SectionUserCollections:
            cell.textLabel.text = [[userCollections objectAtIndex:indexPath.row] localizedTitle];
            return cell;
        default:
            break;
    }
    return cell;
}

- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
