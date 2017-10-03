//
//  ClusturedPicturesByMonths.m
//  QBImagePicker
//
//  Created by Suto, Evelyne on 10/3/17.
//  Copyright © 2017 Katsuma Tanaka. All rights reserved.
//
#import "ClusturedPicturesByMonths.h"

#import <Foundation/Foundation.h>

@implementation ClusterDescription
@end

@implementation ClusturedPicturesByMonth

-(id)initWithObjects:(PHFetchResult *)result
{
   if (self = [super init])
   {
       CreationDateSorter *sorter = [[CreationDateSorter alloc] init];
       self.result = [sorter clusterResult:result byUnit:NSCalendarUnitYear];
   }
    return self;
}

- (void)updateWithObjects:(PHFetchResult *)result
{
    CreationDateSorter *sorter = [[CreationDateSorter alloc] init];
    self.result = nil;
    self.result = [sorter clusterResult:result byUnit:NSCalendarUnitYear];
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

@end
