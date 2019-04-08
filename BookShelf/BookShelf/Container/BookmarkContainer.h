//
//  BookmarkContainer.h
//  BookShelf
//
//  Created by dagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;

@interface BookmarkContainer : NSObject

+ (instancetype)shared;
- (NSArray<Book *> *)getMarkedBooks;
- (void)registerBook:(Book *)book;
- (void)unRegisterBook:(Book *)book;
- (BOOL)isRegistered:(Book *)book;

@end

