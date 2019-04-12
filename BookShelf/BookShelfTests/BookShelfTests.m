//
//  BookShelfTests.m
//  BookShelfTests
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BookDataCenter.h"
#import "BookShelf-Swift.h"

@class Book;

@interface BookShelfTests : XCTestCase

@end

@implementation BookShelfTests

// MARK: - BookDataCenter Test
- (void)testInsertBookmark {
    //given
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
    //given
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

- (void)testInsertHistory {
    //given
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
    //given
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



@end
