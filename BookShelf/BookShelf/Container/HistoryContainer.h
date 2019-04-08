//
//  HistoryContainer.h
//  BookShelf
//
//  Created by dagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Book;

@interface HistoryContainer : NSObject

+ (instancetype)shared;
- (NSArray<Book *> *)getViewedBooks;
- (void)addBook:(Book *)book;

@end

NS_ASSUME_NONNULL_END
