//
//  ClusturedPicturesByMonths.m
//  QBImagePicker
//
//  Created by Suto, Evelyne on 10/3/17.
//  Copyright © 2017 Katsuma Tanaka. All rights reserved.
//
#import "ClusturedPicturesByMonths.h"

#import <Foundation/Foundation.h>

@implementation ChangedAssetInClusturedModel
@end

@interface ClusturedPicturesByMonth ()
@property (nonatomic, strong)  PHFetchResult *unclusturedResult;
@end

@implementation ClusturedPicturesByMonth

-(id)initWithObjects:(PHFetchResult *)result
{
   if (self = [super init])
   {
       [self updateWithObjects:result];
   }
    return self;
}

- (void)updateWithObjects:(PHFetchResult *)result
{
    CreationDateSorter *sorter = [[CreationDateSorter alloc] init];
    self.result = nil;
    self.result = [sorter clusterResult:result byUnit:NSCalendarUnitYear];
    [self.result sortUsingComparator:^NSComparisonResult(ClusterDescription *obj1,ClusterDescription *obj2){
        return [obj2.array[0].creationDate compare:obj1.array[0].creationDate];
    }];
    self.unclusturedResult = result;

}

- (NSInteger)count
{
    return self.result.count;
}

- (NSInteger)numberOfPicturesInSection:(NSInteger)section
{
    return self.result[section].array.count;
}

- (PHAsset *)assetInSection:(NSInteger)section number:(NSInteger)number
{
    return (PHAsset *)self.result[section].array[number];
}

- (NSString *)clusterDescriptionForSection:(NSInteger)section
{
    return self.result[section].header;
}

- (ChangedAssetInClusturedModel *)getPositionForAsset:(PHAsset *)asset
{
    for (ClusterDescription *cluster in self.result)
    {
        NSUInteger index = [cluster.array indexOfObject:asset];
        if (index != NSNotFound)
        {
            ChangedAssetInClusturedModel *location = [[ChangedAssetInClusturedModel alloc] init];
            location.sectionNumber = [self.result indexOfObject:cluster];
            location.indexNumber = index;
            return location;
        }
    }
    return nil;
}

- (NSArray<ChangedAssetInClusturedModel *> *)indexSetForChangedIndexes:(NSIndexSet *)indexSet
{
    NSUInteger currentIndex = [indexSet firstIndex];
    NSMutableArray<ChangedAssetInClusturedModel *> *changed = [[NSMutableArray alloc] init];
    while (currentIndex != NSNotFound)
    {
        PHAsset * changedAsset = self.unclusturedResult[currentIndex];
        ChangedAssetInClusturedModel *location = [self getPositionForAsset:changedAsset];
        [changed addObject:location];
        currentIndex = [indexSet indexGreaterThanIndex: currentIndex];
    }
    return (NSArray *)changed;
}
@end
