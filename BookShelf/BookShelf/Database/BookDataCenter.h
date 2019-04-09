//
//  BookDataCenter.h
//  BookShelf
//
//  Created by devdagad on 09/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;

@interface BookDataCenter : NSObject

+ (instancetype)shared;

- (void)insertBookmark:(Book *)book;
- (void)deleteBookmark:(Book *)book;
- (NSArray<Book *> *)getBookmarkList;

- (void)insertHistory:(Book *)book;
- (void)deleteHistory:(Book *)book;
- (NSArray<Book *> *)getHistoryList;



@end
