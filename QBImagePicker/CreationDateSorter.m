//
//  CreationDateSorter.m
//  QBImagePicker
//
//  Created by Suto, Evelyne on 10/3/17.
//  Copyright © 2017 Katsuma Tanaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "CreationDateSorter.h"
@interface CreationDateSorter()
@property (nonatomic, strong) NSCalendar      *calendar;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ClusterDescription
@end

@implementation CreationDateSorter

- (id)init
{
    if (self = [super init])
    {
        self.calendar = [NSCalendar currentCalendar];
        self.dateFormatter = [[NSDateFormatter alloc] init];
    }
    return self;;
}

- (NSMutableArray<ClusterDescription *>*)clusterResult:(PHFetchResult *)fetchResult byUnit:(NSCalendarUnit)unitFlag
{
    NSMutableDictionary<NSString*,NSMutableArray *> *dictionary = [[NSMutableDictionary alloc] init];
    for (PHAsset *asset in fetchResult)
    {
        [self addToDictionary:dictionary object:asset andUnit:unitFlag];
    }
    
    NSMutableArray<ClusterDescription *> *result = [[NSMutableArray alloc] init];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        ClusterDescription *pair = [[ClusterDescription alloc] init];
        pair.array = (NSArray *)object;
        pair.header = (NSString *)key;
        [result addObject:pair];
    }];
    
    return result;
}

#pragma mark - Helpers
- (void)addToDictionary:(NSMutableDictionary *)dictionary object:(PHAsset *)object andUnit:(NSCalendarUnit)unitFlag
{
    NSDateComponents *components = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear                   fromDate:[object creationDate]];
    
    NSString *monthName = [[self.dateFormatter monthSymbols] objectAtIndex:([components month]-1)];
    NSString *key = [NSString stringWithFormat:@"%@ %ld",monthName, [components year]];

    NSMutableArray *array = (NSMutableArray *)dictionary[key];
    if (!array)
    {
        array = [[NSMutableArray alloc] initWithObjects:object, nil];
        [dictionary setObject:array forKey:key];
    }
    else
    {
        [array addObject:object];
    }
}
@end
