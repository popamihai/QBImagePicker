//
//  ClusturedPicturesByMonths.h
//  QBImagePicker
//
//  Created by Suto, Evelyne on 10/3/17.
//  Copyright © 2017 Katsuma Tanaka. All rights reserved.
//
#import "CreationDateSorter.h"

@interface ClusturedPicturesByMonth : NSObject

@property (nonatomic, strong) NSArray<ClusterDescription *>  *result;

- (id)initWithObjects:(PHFetchResult *)result;

- (void)updateWithObjects:(PHFetchResult *)result;
- (NSInteger)count;
- (NSInteger)numberOfPicturesInSection:(NSInteger)section;
- (PHAsset *)assetInSection:(NSInteger)section number:(NSInteger)number;
- (NSString *)clusterDescriptionForSection:(NSInteger)section;
@end
