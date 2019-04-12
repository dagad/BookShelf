//
//  BookDatacenterTests.m
//  BookShelfTests
//
//  Created by dagad on 12/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BookDataCenter.h"
#import "BookmarkContainer.h"
#import "BookShelf-Swift.h"

@class Book;

@interface BookDataCenterTests : XCTestCase

@end

@implementation BookDataCenterTests

+ (void)setUp {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    [[BookDataCenter shared] deleteAllBookmark];
    [[BookDataCenter shared] deleteAllHistory];
}

+ (void)tearDown {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    [[BookDataCenter shared] deleteAllBookmark];
    [[BookDataCenter shared] deleteAllHistory];
}

// MARK: - BookDataCenter Test
- (void)testInsertBookmark {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    Book *book = [Book mock];
    NSArray *booksBeforeTest = [[BookDataCenter shared] getBookmarkList];

    //when
    [[BookDataCenter shared] insertBookmark:book];

    //then
    NSArray *booksAfterTest = [[BookDataCenter shared] getBookmarkList];
    NSUInteger differ = [booksAfterTest count] - [booksBeforeTest count];
    XCTAssertEqual(differ, 1);
}

- (void)testDeleteBookmark {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    Book *book = [Book mock];
    [[BookDataCenter shared] insertBookmark:book];
    NSArray *booksBeforeTest = [[BookDataCenter shared] getBookmarkList];

    //when
    [[BookDataCenter shared] deleteBookmark:book];

    //then
    NSArray *booksAfterTest = [[BookDataCenter shared] getBookmarkList];
    NSUInteger differ = [booksBeforeTest count] - [booksAfterTest count];
    XCTAssertEqual(differ, 1);
}

- (void)testDeleteAllBookmark {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    for(int i = 0;i<10;i++) {
        [[BookDataCenter shared] insertBookmark:[Book mock]];
    }

    //when
    [[BookDataCenter shared] deleteAllBookmark];

    //then
    NSArray *booksAfterTest = [[BookDataCenter shared] getBookmarkList];
    XCTAssertEqual([booksAfterTest count], 0);
}

- (void)testGetBookmakList {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    Book *firstBook = [Book mock];
    [[BookDataCenter shared] insertBookmark:firstBook];
    Book *secondBook = [Book mock];
    [[BookDataCenter shared] insertBookmark:secondBook];

    //when
    NSArray *books = [[BookDataCenter shared] getBookmarkList];

    //then
    XCTAssertEqual([books count], 2);
}

- (void)testInsertHistory {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    Book *book = [Book mock];
    NSArray *booksBeforeTest = [[BookDataCenter shared] getHistoryList];

    //when
    [[BookDataCenter shared] insertHistory:book];

    //then
    NSArray *booksAfterTest = [[BookDataCenter shared] getHistoryList];
    NSUInteger differ = [booksAfterTest count] - [booksBeforeTest count];
    XCTAssertEqual(differ, 1);
}

- (void)testDeleteHistory {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    Book *book = [Book mock];
    [[BookDataCenter shared] insertHistory:book];
    NSArray *booksBeforeTest = [[BookDataCenter shared] getHistoryList];

    //when
    [[BookDataCenter shared] deleteHistory:book];

    //then
    NSArray *booksAfterTest = [[BookDataCenter shared] getHistoryList];
    NSUInteger differ = [booksBeforeTest count] - [booksAfterTest count];
    XCTAssertEqual(differ, 1);
}

- (void)testDeleteAllHistory {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    for(NSInteger i = 0;i<10;i++) {
        [[BookDataCenter shared] insertHistory:[Book mock]];
    }

    //when
    [[BookDataCenter shared] deleteAllHistory];

    //then
    NSArray *booksAfterTest = [[BookDataCenter shared] getHistoryList];
    XCTAssertEqual([booksAfterTest count], 0);
}

- (void)testGetHistory {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    Book *firstBook = [Book mock];
    [[BookDataCenter shared] insertHistory:firstBook];
    Book *secondBook = [Book mock];
    [[BookDataCenter shared] insertHistory:secondBook];

    //when
    NSArray *books = [[BookDataCenter shared] getHistoryList];

    //then
    XCTAssertEqual([books count], 2);
}



@end

