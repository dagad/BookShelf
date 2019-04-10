//
//  Fetcher.m
//  BookShelf
//
//  Created by Sangyeol Kang on 11/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "Fetcher.h"

@protocol FetcherDelegate <NSObject>

- (void)fetcher:(Fetcher *)fetcher didFetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)fetcher:(Fetcher *)fetcher didUpdateTotalCount:(NSInteger)totalCount;
- (void)fetcher:(Fetcher *)fetcher didOccurError:(NSError *)error;

@end

@implementation Fetcher



@end
