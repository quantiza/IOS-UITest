//
//  AssetGridController.m
//  ios-UITest
//
//  Created by Long Yang on 2018/5/30.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "AssetGridController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "GridViewCell.h"

@interface AssetGridController () <PHPhotoLibraryChangeObserver>
{
    PHAssetCollection *assetCollection;
//    PHCachingImageManager *imageManager;
    PHImageManager *imageManager;
    CGRect previousPreheatRect;
}
@end

@implementation AssetGridController

static NSString * const reuseIdentifier = @"CellID";

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumLineSpacing = 5;
    layout.itemSize = CGSizeMake(kScreenWidth/3 - 10.0, kScreenWidth/3 - 10.0);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        //xib cell 要这样注册，否则cell内容显示不出来
        UINib *cellNib = [UINib nibWithNibName:@"GridViewCell" bundle:nil];
        [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:reuseIdentifier];
//        [self.collectionView registerClass:[GridViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetCacheAssets];
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    if (self.fetchResult == nil) {
        PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
        allPhotosOptions.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES]];
        self.fetchResult = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    }
}

- (void)resetCacheAssets {
//    [imageManager stopCachingImagesForAllAssets];
    previousPreheatRect = CGRectZero;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.item];
    imageManager = [PHImageManager defaultManager];
    GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GridViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.contentView.backgroundColor = RED_COLOR;
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(80, 80) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSLog(@"======%@", info);
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = result;
        });
    }];
//    cell.imageView.image = [UIImage imageNamed:@"andy"];
    return cell;
}


@end
