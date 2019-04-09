//
//  BookDataCenterEnum.h
//  BookShelf
//
//  Created by dagad on 09/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

typedef NS_ENUM(NSUInteger, BookDataType) {
    BookDataError = 0,
    BookDataTitle,
    BookDataSubtitle,
    BookDataAuthors,
    BookDataPublisher,
    BookDataIsbn10,
    BookDataIsbn13,
    BookDataPages,
    BookDataYear,
    BookDataRating,
    BookDataDescription,
    BookDataPrice,
    BookDataImageSource,
    BookDataUrl,
    BookDataPDF
};
