//
//  BookCollectionViewCell.m
//  BookShelf
//
//  Created by devdagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookCollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import "BookShelf-Swift.h"

@implementation BookCollectionViewCell

- (void)configureCellWithBook:(Book *)book {
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:book.imageSource]];
    [self.titleLabel setText:book.title];
    [self.subTitleLabel setText:book.subtitle];
    [self.priceLabel setText:book.price];
    [self.isbnLabel setText:book.isbn13];
    [self hideEmptyLabel];
}

- (void)hideEmptyLabel {
    [self.titleLabel setHidden:(self.titleLabel.text.length == 0)];
    [self.subTitleLabel setHidden:(self.subTitleLabel.text.length == 0)];
    [self.priceLabel setHidden:(self.priceLabel.text.length == 0)];
    [self.isbnLabel setHidden:(self.isbnLabel.text.length == 0)];
}

@end
