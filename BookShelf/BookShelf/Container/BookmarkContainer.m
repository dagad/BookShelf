//
//  BookmarkContainer.m
//  BookShelf
//
//  Created by dagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookmarkContainer.h"
#import "BookDataCenter.h"
#import "BookShelf-Swift.h"

/**
 BookmarkContainer
 북마크 정보를 가지고, 디비에 저장, 삭제, 불러오기 기능을 수행한다.
 */

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
    [[BookDataCenter shared] insertBookmark:book];
}

- (void)unRegisterBook:(Book *)book {
    [self.markedBooks removeObject:book];
    [[BookDataCenter shared] deleteBookmark:book];
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
    NSArray *books = [[BookDataCenter shared] getBookmarkList];
    return [NSMutableArray arrayWithArray:books];
}

@end
