//
//  ClusturedPicturesByMonths.h
//  QBImagePicker
//
//  Created by Suto, Evelyne on 10/3/17.
//  Copyright © 2017 Katsuma Tanaka. All rights reserved.
//
#import "CreationDateSorter.h"

@interface ChangedAssetInClusturedModel : NSObject
@property (nonatomic, assign) NSUInteger sectionNumber;
@property (nonatomic, assign) NSUInteger indexNumber;
@end

@interface ClusturedPicturesByMonth : NSObject

@property (nonatomic, strong) NSMutableArray<ClusterDescription *>  *result;

- (id)initWithObjects:(PHFetchResult *)result;

- (void)updateWithObjects:(PHFetchResult *)result;
- (NSInteger)count;
- (NSInteger)numberOfPicturesInSection:(NSInteger)section;
- (PHAsset *)assetInSection:(NSInteger)section number:(NSInteger)number;
- (NSString *)clusterDescriptionForSection:(NSInteger)section;
- (NSArray<ChangedAssetInClusturedModel *> *)indexSetForChangedIndexes:(NSIndexSet *)indexSet;
@end
