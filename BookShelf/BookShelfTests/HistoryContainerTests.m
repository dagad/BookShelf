//
//  HistoryContainerTests.m
//  BookShelfTests
//
//  Created by dagad on 12/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BookDataCenter.h"
#import "HistoryContainer.h"
#import "BookShelf-Swift.h"

@class Book;

@interface HistoryContainerTests : XCTestCase

@end

@implementation HistoryContainerTests

+ (void)setUp {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    [[BookDataCenter shared] deleteAllHistory];
}

+ (void)tearDown {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    [[BookDataCenter shared] deleteAllHistory];
}

// BookmarkContainer
- (void)testSuccessfulRegisterBook {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllHistory];
    Book *book = [Book mock];

    //when
    [[HistoryContainer shared] addBook:book];

    //then
    XCTAssertTrue([[HistoryContainer shared] isContain:book]);
}

- (void)testFailedRegisterBook {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllHistory];
    Book *book = [Book mock];

    //when
    [[HistoryContainer shared] addBook:book];

    //then
    Book *otherBook = [Book mock];
    XCTAssertFalse([[HistoryContainer shared] isContain:otherBook]);
}

@end
