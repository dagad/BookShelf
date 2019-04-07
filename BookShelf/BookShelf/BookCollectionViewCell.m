//
//  BookCollectionViewCell.m
//  BookShelf
//
//  Created by devdagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookCollectionViewCell.h"
#import "BookShelf-Swift.h"

@implementation BookCollectionViewCell

- (void)configureCellWithBook:(Book *)book {
    [self.titleLabel setText:book.title];
    [self.subTitleLabel setText:book.subtitle];
    [self.priceLabel setText:book.price];
    [self.isbnLabel setText:book.isbn13];
}

@end
