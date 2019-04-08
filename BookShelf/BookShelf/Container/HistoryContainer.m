//
//  HistoryContainer.m
//  BookShelf
//
//  Created by dagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "HistoryContainer.h"
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

- (void)addBook:(Book *)book {
    if([self isContain:book]) {
        [self remove:book];
    }
    [self.markedBooks insertObject:book atIndex:0];
}

- (void)remove:(Book *)book {
    __weak __typeof(self) weakSelf = self;
    [self.markedBooks removeObject:book];
    [self.markedBooks enumerateObjectsUsingBlock:^(Book *item, NSUInteger idx, BOOL *stop) {
        if(book.isbn13 == item.isbn13) {
            [weakSelf.markedBooks removeObjectAtIndex:idx];
            *stop = YES;
        }
    }];
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
    return [NSMutableArray array];
}

@end
