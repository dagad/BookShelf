//
//  BookmarkContainer.m
//  BookShelf
//
//  Created by dagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookmarkContainer.h"
#import "BookShelf-Swift.h"

@interface BookmarkContainer ()

@property (strong, nonatomic) NSMutableArray *markedBooks;

@end

@implementation BookmarkContainer

+ (instancetype) shared {
    static dispatch_once_t token;
    static BookmarkContainer *instance = nil;
    dispatch_once(&token, ^{
        instance = [[BookmarkContainer alloc] init];
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

- (NSArray<Book *> *)getMarkedBooks {
    return [NSArray arrayWithArray:self.markedBooks];
}

- (void)registerBook:(Book *)book {
    [self.markedBooks insertObject:book atIndex:0];
}

- (void)unRegisterBook:(Book *)book {
    [self.markedBooks removeObject:book];
}

- (BOOL)isRegistered:(Book *)book {
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
