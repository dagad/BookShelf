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

- (void)insertBook:(Book *)book;
- (void)deleteBook:(Book *)book;
- (NSArray<Book *> *)getBooks;

@end
