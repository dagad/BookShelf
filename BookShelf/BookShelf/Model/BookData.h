//
//  BookData.h
//  BookShelf
//
//  Created by dagad on 09/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;
@class FMResultSet;

@interface BookData : NSObject

- (id)initWithResult:(FMResultSet *)result;
- (Book *)createBook;

@end
