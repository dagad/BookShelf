//
//  HistoryContainer.m
//  BookShelf
//
//  Created by dagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "HistoryContainer.h"
#import "BookDataCenter.h"
#import "BookShelf-Swift.h"

@interface HistoryContainer ()

@property (strong, nonatomic) NSMutableArray *markedBooks;

@end

@implementation HistoryContainer

+ (instancetype)shared {
    static dispatch_once_t token;
    static HistoryContainer *instance = nil;
    dispatch_once(&token, ^{
        instance = [[HistoryContainer alloc] init];
    });

    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.markedBooks = [self reStoreData];
    }
    return self;
}

- (NSArray<Book *> *)getViewedBooks {
    return [NSArray arrayWithArray:self.markedBooks];
}

- (void)addBook:(Book *)book {
    if([self isContain:book]) {
        [self delete:book];
    }
    [self.markedBooks insertObject:book atIndex:0];
    [[BookDataCenter shared] insertHistory:book];
}

- (void)delete:(Book *)book {
    [self.markedBooks removeObject:book];
    [[BookDataCenter shared] deleteHistory:book];
}

- (BOOL)isContain:(Book *)book {
    for(Book *item in self.markedBooks) {
        if([item isEqual:book]) {
            return YES;
        }
    }
    return NO;
}

- (void)storeData {
    // store markedBooks
}

- (NSMutableArray<Book *> *)reStoreData {
    NSArray *books = [[BookDataCenter shared] getHistoryList];
    return [NSMutableArray arrayWithArray:books];
}

@end
