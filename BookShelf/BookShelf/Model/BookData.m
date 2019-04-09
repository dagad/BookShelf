//
//  BookData.m
//  BookShelf
//
//  Created by dagad on 09/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookData.h"
#import "FMResultSet.h"
#import "BookDataCenterEnum.h"
#import "BookShelf-Swift.h"

@interface BookData()

@property (strong, nonatomic) NSString *error;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subTitle;
@property (strong, nonatomic) NSString *authors;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSString *isbn10;
@property (strong, nonatomic) NSString *isbn13;
@property (strong, nonatomic) NSString *pages;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *imageSource;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSDictionary *pdf;

@end

@implementation BookData

- (id)initWithResult:(FMResultSet *)result {
    self = [super init];
    if (self) {
        self.error = [result stringForColumnIndex:BookDataError];
        self.title = [result stringForColumnIndex:BookDataTitle];
        self.subTitle = [result stringForColumnIndex:BookDataSubtitle];
        self.authors = [result stringForColumnIndex:BookDataAuthors];
        self.publisher = [result stringForColumnIndex:BookDataPublisher];
        self.isbn10 = [result stringForColumnIndex:BookDataIsbn10];
        self.isbn13 = [result stringForColumnIndex:BookDataIsbn13];
        self.pages = [result stringForColumnIndex:BookDataPages];
        self.year = [result stringForColumnIndex:BookDataYear];
        self.rating = [result stringForColumnIndex:BookDataRating];
        self.desc = [result stringForColumnIndex:BookDataDescription];
        self.price = [result stringForColumnIndex:BookDataPrice];
        self.imageSource = [result stringForColumnIndex:BookDataImageSource];

        NSData *data = [result dataForColumnIndex:BookDataUrl];
        self.pdf = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return self;
}

- (Book *)createBook {

    Book *book = [[Book alloc] init];
    book.error = self.error;
    book.title = self.title;
    book.subtitle = self.subTitle;
    book.authors = self.authors;
    book.publisher = self.publisher;
    book.isbn10 = self.isbn10;
    book.isbn13 = self.isbn13;
    book.pages = self.pages;
    book.year = self.year;
    book.rating = self.rating;
    book.desc = self.desc;
    book.price = self.price;
    book.imageSource = self.imageSource;

    return book;
}

@end
