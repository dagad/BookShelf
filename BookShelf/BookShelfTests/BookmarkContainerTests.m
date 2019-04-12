//
//  BookmarkContainerTests.m
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

@interface BookmarkContainerTests : XCTestCase

@end

@implementation BookmarkContainerTests

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

// BookmarkContainer
- (void)testSuccessfulRegisterBook {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    Book *book = [Book mock];

    //when
    [[BookmarkContainer shared] registerBook:book];

    //then
    XCTAssertTrue([[BookmarkContainer shared] isRegistered:book]);
}

- (void)testFailedRegisterBook {
    NSLog(@"dagad %@", NSStringFromSelector(_cmd));
    //given
    [[BookDataCenter shared] deleteAllBookmark];
    Book *book = [Book mock];

    //when
    [[BookmarkContainer shared] registerBook:book];

    //then
    Book *otherBook = [Book mock];
    XCTAssertFalse([[BookmarkContainer shared] isRegistered:otherBook]);
}

@end
