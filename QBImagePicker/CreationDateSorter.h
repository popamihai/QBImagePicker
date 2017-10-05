//
//  CreationDateSorter.h
//  QBImagePicker
//
//  Created by Suto, Evelyne on 10/3/17.
//  Copyright © 2017 Katsuma Tanaka. All rights reserved.
//
#import <Photos/Photos.h>
@interface ClusterDescription : NSObject
@property (nonatomic, strong) NSString  *header;
@property (nonatomic, strong) NSArray   *array;
@end

@interface CreationDateSorter : NSObject

- (NSArray<ClusterDescription *>*)clusterResult:(PHFetchResult *)fetchResult byUnit:(NSCalendarUnit)unitFlag;

@end
